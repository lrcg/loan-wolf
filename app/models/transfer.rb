class Transfer < ActiveRecord::Base
  attr_accessible :amount, :approved_by_user_id, :approved_date,:creditor_user_id, :debtor_user_id, :is_archived, :debtor, :creditor,:created_at, :updated_at
  validates_presence_of :amount, :creditor_user_id, :debtor_user_id

  belongs_to :debtor, :class_name => 'User', :foreign_key => 'debtor_user_id'
  belongs_to :creditor, :class_name => 'User', :foreign_key => 'creditor_user_id'

  validates :amount, numericality: { greater_than: 0, message: 'must be a legitimate dollar value greater than $0' }

  scope :current, where(:is_archived => nil)

  def can_be_marked_paid_by?(user)
  	user == creditor
  end
  def can_be_marked_approved_by?(user)
  	user == debtor
  end
end