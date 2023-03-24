module CompetencyDisplayHelper
  def display_competency_property(value)
    if value.is_a?(Array)
      return display_competency_property(value.first) if value.size == 1
      return display_array_competency_property(value)
    end

    case value.fetch("type")
    when "string" then display_string_competency_property(value)
    when "uri" then display_uri_competency_property(value)
    end
  end

  def display_array_competency_property(value)
    content_tag :ul do
      value.map do |v|
        concat(
          content_tag(:li, display_competency_property(v))
        )
      end
    end
  end

  def display_string_competency_property(value)
    simple_format(value.fetch("value"))
  end

  def display_uri_competency_property(value)
    value.symbolize_keys => { resource_type:, value: }

    url =
      case resource_type
      when "competency" then competency_path(value)
      when "container" then container_path(value)
      else value
      end

    link_to value, url, target: "_blank"
  end
end
