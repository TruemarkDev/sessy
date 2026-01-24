module EventsHelper
  def event_badge_classes(event)
    case event.event_type
    when "send"
      "bg-green-100 text-green-800"
    when "delivery"
      "bg-green-600 text-white"
    when "bounce"
      event_bounce_badge_classes(event)
    when "complaint", "reject", "rendering_failure"
      "bg-red-600 text-white"
    when "delivery_delay"
      "bg-yellow-100 text-yellow-800"
    when "subscription"
      "bg-blue-100 text-blue-800"
    when "open"
      "bg-cyan-100 text-cyan-800"
    when "click"
      "bg-purple-100 text-purple-800"
    else
      "bg-gray-100 text-gray-800"
    end
  end

  def event_label(event)
    case event.event_type
    when "send"
      "Sent"
    when "delivery"
      "Delivered"
    when "bounce"
      event_bounce_label(event)
    when "complaint"
      "Complained"
    when "reject"
      "Rejected"
    when "delivery_delay"
      "Delayed"
    when "rendering_failure"
      "Rendering Failed"
    when "subscription"
      "Subscription"
    when "open"
      "Opened"
    when "click"
      "Clicked"
    else
      event.event_type.titleize
    end
  end

  def gravatar_url(email, size: 32)
    hash = Digest::MD5.hexdigest(email.to_s.downcase)
    "https://www.gravatar.com/avatar/#{hash}?s=#{size}&d=mp"
  end

  private

  def event_bounce_label(event)
    case event.bounce_type
    when "Permanent"
      "Hard Bounce"
    when "Transient"
      "Soft Bounce"
    else
      "Bounced"
    end
  end

  def event_bounce_badge_classes(event)
    case event.bounce_type
    when "Permanent"
      "bg-red-600 text-white"
    when "Transient", "Undetermined"
      "bg-red-100 text-red-800"
    else
      "bg-red-600 text-white"
    end
  end
end
