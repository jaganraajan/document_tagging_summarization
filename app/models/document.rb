class Document < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  
  validates :title, presence: true
  validates :user, presence: true
  
  scope :processed, -> { where.not(summary: nil) }
  scope :tagged, -> { where.not(tags: nil) }
  
  def processing_complete?
    summary.present? && tags.present?
  end
  
  def tags_array
    tags.present? ? tags.split(',').map(&:strip) : []
  end
end
