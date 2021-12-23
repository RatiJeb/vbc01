class Project < ApplicationRecord
  belongs_to :category

  has_one :first_task, class_name: 'Task', foreign_key: 'project_id'
  has_many :tasks, class_name: 'Task', foreign_key: 'project_id'

  belongs_to :category, required: false
  has_one :task, class_name: 'Task', foreign_key: 'project_id'

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :with_category, -> { where.not(category_id: nil) }
  scope :filter_by_category, -> (id) { where(category_id: id) }
end
