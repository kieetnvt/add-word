class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :words, dependent: :destroy

  before_create :set_defaults_value

  mount_uploader :avatar, AvatarUploader

  def self.find_or_create_from_omniauth(auth)
  end

  private

  def set_defaults_value
    self.username = "Update your name"
    self.nickname = "Update your nickname"
  end
end
