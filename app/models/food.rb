class Food < ApplicationRecord

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites



end