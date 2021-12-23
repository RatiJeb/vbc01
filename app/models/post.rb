class Post < ApplicationRecord
  include AASM

  validates_with ScheduleValidator
  validates :cancellation_reason, presence: true, if: :status_state_canceled

  def status_state_canceled
    status_state == 'canceled'
  end

  aasm :column => 'status_state', whiny_persistence: true do
  state :draft, initial: true
  state :scheduled, :on_moderation, :published, :canceled

  event :process_scheduled do
    transitions from: :draft, to: :scheduled, after: Proc.new {|*args| set_scheduled_at(*args)}
  end

  event :process_on_moderation do
    transitions from: [:draft, :scheduled], to: :on_moderation
  end

  event :mark_as_draft do
    transitions from: [:scheduled, :published, :canceled], to: :draft, after: :clear_excess_attributes
  end

  event :mark_as_published do
    transitions from: :on_moderation, to: :published, after: Proc.new {|*args| set_published_at(*args) }
  end

  event :mark_as_canceled do
    transitions from: :on_moderation, to: :canceled, after: Proc.new {|*args| set_cancellation_reason(args.first, args.second) }
  end
end

  def set_scheduled_at(current_datetime)
    self.scheduled_at = current_datetime
  end
  
  def set_published_at(moderator)
    self.moderator_id = moderator.id
    self.published_at = Time.now
    self.scheduled_at = nil
  end
  
  def set_cancellation_reason(moderator, reason)
    self.moderator_id = moderator.id
    self.cancellation_reason = reason
    self.scheduled_at = nil
  end
  
  def clear_excess_attributes
    self.moderator_id = nil
    self.published_at = nil
    self.scheduled_at = nil
    self.cancellation_reason = nil
  end

  belongs_to :user
  belongs_to :moderator, class_name: 'User', foreign_key: :moderator_id, required: false
end
