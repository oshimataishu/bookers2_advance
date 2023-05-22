class Group < ApplicationRecord
  has_many :user_groups, dependent: :destroy

  belongs_to :owner, class_name: 'User'
  has_many :users, through: :user_groups

  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :group_image

  def get_group_image(width, height)
    unless group_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      group_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    group_image.variant(resize_to_limit: [width, height]).processed
  end

  def is_owned_by?(user)
    owner_id == user.id
  end
end
