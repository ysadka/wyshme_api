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
  #validates :first_name, :last_name, presence: true
  after_create :create_auth_token

  def access_token
    Doorkeeper::AccessToken.where(resource_owner_id: self.id).first.try(:token)
  end

  private

  def create_auth_token
    # Load application which is represents API itself
    # TODO: load it once on start, for example, in the initializer.
    application = Doorkeeper::Application.where(name: 'WyshMeAPIRoot').first
    Doorkeeper::AccessToken.create!(application_id: application.id,
                                    resource_owner_id: self.id)
  end

end
