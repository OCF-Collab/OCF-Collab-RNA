module ApplicationHelper
  def external_link_to(name = nil, options = nil, html_options = nil, &block)
    html_options ||= {}
    link_to(name, options, html_options.merge(target: "_blank"), &block)
  end
end
