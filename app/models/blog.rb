class Blog < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_rich_text :body

  mount_uploader :image, ImageUploader

  acts_as_taggable_on :tags

  THUMBNAIL_SIZE = [150, 150].freeze

  validates :title, presence: true
  validates :body, presence: true

  scope :find_with_comments, -> (id) {
    includes(:favorites, comments: :user).find(id)
  }

  scope :search_body, -> (search_param = nil) {
    return if search_param.blank?
    joins("INNER JOIN action_text_rich_texts ON action_text_rich_texts.record_id = blogs.id AND action_text_rich_texts.record_type = 'Blog'")
    .where("action_text_rich_texts.body LIKE ? ", "%#{search_param}%")
  }

  def has_favorites?(favorite_user)
    self.favorites.to_a.find {|favorite| favorite.user_id == favorite_user.id }.present?
  end

  def like(favorite_user_id)
    self.favorites.new(user_id: favorite_user_id).save!
  end

  def unlike(favorite_user_id)
    favorite_id = self.favorites.find_by(user_id: favorite_user_id).id
    self.favorites.destroy(favorite_id)
  end
end
