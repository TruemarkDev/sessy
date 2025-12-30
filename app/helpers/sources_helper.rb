module SourcesHelper
  def config_set_name(source)
    "#{source.name.parameterize}-ses"
  end

  def sns_topic_name(source)
    "#{source.name.parameterize}-ses-events"
  end
end
