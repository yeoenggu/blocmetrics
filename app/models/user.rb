class User < ActiveRecord::Base
  # Include default devise modules.
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable
  include DeviseTokenAuth::Concerns::User
end
