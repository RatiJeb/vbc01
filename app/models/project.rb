class Project < ApplicationRecord
  belongs_to :category
  KNOWN_FORMATS = %w[plain markdown].freeze

  validates :title, :format, :description, presence: true
  validates :title, length: {minimum:5, maximum:150}
  validates :format, inclusion: {in: KNOWN_FORMATS, message: "%w{value} is not included in #{KNOWN_FORMATS}"}
end
