class Category < ApplicationRecord
    validates :title, :description, presence: true
    validates :description, length: {maximum: 300}
    validates :title, uniqueness: true, if: :active
    validates :title, format: { with: /\A[a-zA-Z0-9]+\z/,
      message: "only allows letters and numbers" }
end
