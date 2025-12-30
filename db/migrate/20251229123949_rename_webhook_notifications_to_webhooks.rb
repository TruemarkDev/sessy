class RenameWebhookNotificationsToWebhooks < ActiveRecord::Migration[8.1]
  def change
    rename_table :webhook_notifications, :webhooks
  end
end
