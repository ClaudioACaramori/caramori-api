class User < ApplicationRecord
	include TokenAuthenticatable
  include RailsAdmin::User

  has_many :devices, as: :pushable, class_name: 'JeraPush::Device'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
