require 'csv'

namespace :populate do
  task states: :environment do
    states_file = File.read("#{Rails.root}/lib/assets/seeds/dados_estados.csv")

    states_csv = CSV.parse(states_file, headers: true)

    bar = ProgressBar.new(states_csv.size, :bar, :percentage, :counter, :elapsed)

    if states_csv && states_csv.any?
      State.transaction do
        states_csv.each do |state_row|
          State.create(state_row.to_hash.compact)
          bar.increment!
        end
      end
    else
      abort "Can't import States"
    end
  end

  task cities: :environment do
    cities_file = File.read("#{Rails.root}/lib/assets/seeds/dados_municipios.csv")

    cities_csv = CSV.parse(cities_file, headers: true)

    bar = ProgressBar.new(cities_csv.size, :bar, :percentage, :counter, :elapsed)

    if cities_csv && cities_csv.any?
      City.transaction do
        cities_csv.each do |city_row|
          row = city_row.to_hash
          row["name"] = row["name"].titlecase
          City.create(row.compact)
          bar.increment!
        end
      end
    else
      abort "Can't import Cities"
    end
  end

end
