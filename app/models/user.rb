class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :boards

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            email: true
  validates :first_name, :last_name, presence: true
end
