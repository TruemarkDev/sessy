class EventsController < ApplicationController
  include SourceScoped

  def index
    events = @source.events
    events = events.search(params[:query]) if params[:query].present?
    @filter_counts = events.filter_counts(filter_params)

    events = events.filter_by_params(filter_params).reverse_chronologically.includes(:message)
    @pagy, @events = pagy(events, limit: 50)
  end

  private

  def filter_params
    params.permit(:query, :date_range, :from_date, :to_date, event_types: [], bounce_types: [])
  end
end
