class Loan < ActiveRecord::Base
  attr_accessible :amount, :approved_by_user_id, :approved_date, :credit_user_id, :debtor_user_id, :is_archived, :debtor, :creditor,:created_at, :updated_at
  validates_presence_of :amount, :credit_user_id, :debtor_user_id

  belongs_to :debtor, :class_name => 'User', :foreign_key => 'debtor_user_id'
  belongs_to :creditor, :class_name => 'User', :foreign_key => 'credit_user_id'

  validates :amount, numericality: { greater_than: 0, message: 'must be a legitimate value or it\'ll shut that whole thing down' }

  scope :current, where(:is_archived => nil)

  def can_be_marked_paid_by?(user)
  	user == creditor
  end
  def can_be_marked_approved_by?(user)
  	user == debtor
  end
end
