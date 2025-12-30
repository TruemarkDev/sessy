module Event::Searchable
  extend ActiveSupport::Concern

  included do
    scope :search, ->(term) {
      left_joins(:message).where(
        "recipient_email ILIKE ? OR messages.subject ILIKE ?",
        "%#{sanitize_sql_like(term)}%",
        "%#{sanitize_sql_like(term)}%"
      )
    }
  end
end
