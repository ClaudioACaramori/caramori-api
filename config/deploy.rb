require 'mina/bundler'
require 'mina/deploy'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

set :repository, 'git@gitlab.com:jera-software/seu-projeto-show.git'

set :identity_file, ENV['IDENTIFY_FILE']
set :environment,   ENV['ENV']

set :application_name, 'seu-projeto-show'
set :user, fetch(:application_name)
set :ruby_version, 'ruby-2.5.1'
set :rvm_use_path, '/usr/local/rvm/scripts/rvm'
set :gemset,    fetch(:user)

if fetch(:environment) == 'staging'
  set :branch,    'develop'
  set :rails_env, 'staging'
  set :domain,    '18.235.124.66'
  set :deploy_to, "/var/www/#{fetch(:user)}/staging"
elsif fetch(:environment) == 'production'
  set :branch,    'master'
  set :rails_env, 'production'
  set :domain,    'valhalla.jera.com.br'
  set :deploy_to, "/var/www/#{fetch(:user)}/production"
end

set :sidekiq_pid, "#{fetch(:deploy_to)}/current/tmp/pids/sidekiq.pid"

set :shared_dirs, fetch(:shared_dirs, []).push('log', 'public/system', 'tmp/pids', 'tmp/sockets')

set :shared_files, fetch(:shared_files, []).push('public/uploads', 'config/database.yml', '.ruby-gemset', '.ruby-version')

task :remote_environment do
  ruby_version = File.read('.ruby-version').strip
  ruby_gemset = File.read('.ruby-gemset').strip

  gemset = "#{ruby_version}@#{ruby_gemset}"
  raise "Couldn't determine Ruby version: Do you have a file .ruby-version in your project root?" if ruby_version.empty?

  invoke :'rvm:use', "#{fetch(:ruby_version)}@#{fetch(:gemset)}"
end

task :restart => :remote_environment do
  pidfile = "#{fetch(:deploy_to)}/current/tmp/pids/unicorn.pid"
  command "if [ -f #{pidfile} ]; then kill -s USR2 `cat #{pidfile}`;fi"
  command "if [ -f #{fetch(:sidekiq_pid)} ]; then kill -s USR2 `cat #{fetch(:sidekiq_pid)}`;fi"
end

task :log => :remote_environment do
  if !fetch(:environment)
    abort "You need to pass the identify file and environment, ex. mina log ENV=[production,staging] IDENTIFY_FILE=$HOME/ec2/key.pem"
  end
  command %[tail -f -n 200 "#{fetch(:deploy_to)}/shared/log/#{fetch(:environment)}.log"]
end

task :get_env => :remote_environment do
  if !fetch(:environment)
    abort "You need to pass the identify file and environment, ex. mina log ENV=[production,staging] IDENTIFY_FILE=$HOME/ec2/key.pem"
  end
  command %[cat "#{deploy_to}/shared/.env"]
end

task :nano_env => :remote_environment do
  if !fetch(:environment)
    abort "You need to pass the identify file and environment, ex. mina log ENV=[production,staging] IDENTIFY_FILE=$HOME/ec2/key.pem"
  end
  command %[nano "#{deploy_to}/shared/.env"]
end


task :setup do

  in_path(fetch(:shared_path)) do
    command %[mkdir -p "#{fetch(:deploy_to)}/shared/log"]
    command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/log"]

    command %[mkdir -p "#{fetch(:deploy_to)}/shared/config"]
    command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/config"]

    command %[touch "#{fetch(:deploy_to)}/shared/config/database.yml"]

    command %[mkdir -p "#{fetch(:deploy_to)}/shared/tmp/pids"]
    command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/tmp/pids"]

    command %[mkdir -p "#{fetch(:deploy_to)}/shared/tmp/sockets"]
    command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/tmp/sockets"]

    command %[mkdir -p "#{fetch(:deploy_to)}/shared/public/system"]
    command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/public/system"]

    command %[mkdir -p "#{fetch(:deploy_to)}/shared/public/uploads"]
    command %[chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/public/uploads"]

    command %[echo "#{fetch(:ruby_version)}" > "#{fetch(:deploy_to)}/shared/.ruby-version"]

    command %[echo "#{fetch(:gemset)}" > "#{fetch(:deploy_to)}/shared/.ruby-gemset"]
  end
end

desc "Deploys the current version to the server."
task :deploy do

  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    command %[echo "ENV ---> #{fetch(:environment)}"]
    command %[echo "DEPLOY_TO ---> #{fetch(:deploy_to)}"]
    command %[echo "SHARED PATH ---> #{fetch(:shared_path)}"]
    command %[bundle install --without development test]
    invoke :'rvm:wrapper', "#{fetch(:ruby_version)}@#{fetch(:gemset)}","#{fetch(:gemset)}",'unicorn_rails'
    invoke :'rvm:wrapper', "#{fetch(:ruby_version)}@#{fetch(:gemset)}","#{fetch(:gemset)}",'sidekiq'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      invoke :restart
    end
  end
end
