class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: [:slugged, :finders]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  # Geocoder configuration
  geocoded_by :city
  after_validation :geocode, if: ->(obj){ obj.city.present? && obj.city_changed? }

  has_one :profile, dependent: :destroy

  # Validations
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }
  validates :city, presence: true
  validates :couple_type, presence: true, inclusion: { in: %w(couple homme femme trans_trav) }

  # Virtual attribute for sign up form
  attr_accessor :terms_of_service

  # Ensure slug updates when username changes
  def should_generate_new_friendly_id?
    will_save_change_to_username?
  end
end
