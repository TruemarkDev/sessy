class RemoveSesPrefix < ActiveRecord::Migration[8.1]
  def change
    rename_table :ses_webhook_notifications, :webhook_notifications
    rename_table :ses_messages, :messages
    rename_table :ses_events, :events

    # Rename the enum type
    execute "ALTER TYPE ses_event_type RENAME TO event_type"
  end
end
