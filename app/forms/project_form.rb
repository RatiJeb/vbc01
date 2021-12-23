class ProjectForm
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :project, :title, :format, :description, :active

  delegate :persisted?, :model_name, :to_param, to: :project

  KNOWN_FORMATS = %w[plain markdown].freeze

  validates :title, :format, :description, presence: true
  validates :title, length: {minimum:5, maximum:150}
  validates :format, inclusion: {in: KNOWN_FORMATS, message: "%w{value} is not included in #{KNOWN_FORMATS}"}, presence: true

  validate :title_first_five_letters

  validates_with DescriptionValidator

  def title_first_five_letters
    if title.present? && title.first(5) =~ /\d{5}/
      errors.add(:title, "First 5 letters can't be numbers")
    end
  end

  def initialize(params = {}, project: Project.new)
    @project = project
    super(project.slice(
      :title, 
      :format, 
      :description, 
      :active).merge(params)
    )
  end

  def attributes
    {
      title: @title,
      format: @format,
      description: @description,
      active: @active
    }
  end

  def create
    return false unless valid?

    project.assign_attributes(attributes)
    project.save
  end

  def update
    return false unless valid?

    project.assign_attributes(attributes)
    project.save
  end
end