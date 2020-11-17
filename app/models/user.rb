# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,

  validates :name, presence: true, uniqueness: true, length: {maximum: 50}
  include DeviseTokenAuth::Concerns::User

  has_many :posts

end
