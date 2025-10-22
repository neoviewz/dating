class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  # No required validations per requirements; all optional
end
