class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
#  has_many :wikis, through: :collaborators, dependent: :destroy
#  has_many :collaborators
  has_many :wikis, dependent: :destroy
  
  after_initialize :init
	
  def init
    if new_record?
      self.role ||= "standard"
    end
  end
  
  def admin?
    role == 'admin'
  end
 
  def standard?
    role == 'standard'
  end
  
  def premium?
    role == 'premium'
  end
end
