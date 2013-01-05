class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :initials
  # attr_accessible :title, :body

  has_many :debts, :foreign_key => 'debtor_user_id', :class_name => 'Transfer'
  has_many :credits, :foreign_key => 'creditor_user_id', :class_name => 'Transfer'
  has_many :approvals, :foreign_key => 'approved_by_user_id', :class_name => 'Transfer'

  def to_s
  	initials
  end
end