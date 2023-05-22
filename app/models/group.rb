class Group < ApplicationRecord
  has_many :user_groups, dependent: :destroy

  belongs_to :owner, class_name: 'User'
  has_many :users, through; :user_groups

  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :group_image

  def is_owned_by?(user)
    owner_id == user.id
  end
end
