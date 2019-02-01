class User < ApplicationRecord
	include TokenAuthenticatable
  include RailsAdmin::User

  # mount_uploader :avatar, AvatarUploader

  validates_presence_of :email, :name
  validates_uniqueness_of :document, :email
  validate :document_validation

  has_many :devices, as: :pushable, class_name: 'JeraPush::Device'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private
    def document_validation
      if self.document.to_s.length == 11
        errors.add(:document, I18n.t("activerecord.errors.models.user.attributes.document.invalid")) unless CPF.valid?(self.document)
      else
        return true # because RG Brazilian document has no size pattern in Brazil states
      end
    end

end
