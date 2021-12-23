class ScheduleValidator < ActiveModel::Validator
  def validate(record)

    if record.status_state == 'scheduled'
      if !record.scheduled_at.present?
        record.errors.add(:scheduled_at, 'must be filled')

      elsif record.scheduled_at < Time.now
        record.errors.add(:scheduled_at, 'date must be after now')
      end
    end
  end
end