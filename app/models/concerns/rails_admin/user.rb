module RailsAdmin::User
  extend ActiveSupport::Concern

  included do
    rails_admin do
      list do
        field :id
        field :email
        field :sign_in_count
        field :devices
        field :last_sign_in_at
        field :created_at do
          strftime_format '%d/%m/%Y às %H:%M'
        end
        field :updated_at do
          strftime_format '%d/%m/%Y às %H:%M'
        end
      end

      show do
        field :id
        field :email
        field :sign_in_count
        field :devices
        field :last_sign_in_at
        field :created_at do
          strftime_format '%d/%m/%Y às %H:%M'
        end
        field :updated_at do
          strftime_format '%d/%m/%Y às %H:%M'
        end
      end

      edit do
      end

      create do
        field :email
        field :password
      end
    end
  end
end
