class RenameCandellationReasonToCancellationReason < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :candellation_reason, :cancellation_reason
  end
end
