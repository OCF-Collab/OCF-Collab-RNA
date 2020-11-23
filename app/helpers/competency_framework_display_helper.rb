module CompetencyFrameworkDisplayHelper
  def display_attribute_value(value)
    if value.is_a?(Hash)
      return display_hash_attribute_value(value)
    end

    if value.is_a?(Array)
      return display_array_attribute_value(value)
    end

    display_string_attribute_value(value)
  end

  def display_hash_attribute_value(value)
    content_tag :ul do
      value.map do |key, v|
        concat(
          content_tag(:li, "%s: %s" % [
            key.humanize,
            v,
          ])
        )
      end
    end
  end

  def display_array_attribute_value(value)
    if value.length == 1
      return display_string_attribute_value(value.first)
    end

    if value.all? { |v| v.length < 20 }
      return value.join(", ")
    end

    content_tag :ul do
      value.map do |v|
        concat(
          content_tag(:li, v)
        )
      end
    end
  end

  def display_string_attribute_value(value)
    simple_format(value)
  end
end
