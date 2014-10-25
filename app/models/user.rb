class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def teammate?
   role == 'teammate'
  end
 
  def team_captain?
    role == 'team_captain'
  end

  def admin?
    role == 'admin'
  end
end

