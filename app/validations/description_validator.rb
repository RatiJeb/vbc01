class DescriptionValidator < ActiveModel::Validator
  def validate(record)
    if record.description.include?('todo')
      record.errors.add(:description, "Can't include todo!")
    end
  end
end