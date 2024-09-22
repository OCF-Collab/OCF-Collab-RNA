class SearchForm < ApplicationForm
  CONTAINER_TYPES = {
    'all' => nil,
    'framework' => 'framework',
    'collection' => 'collection'
  }.freeze

  FACETS = {
    text: "All text",
    container_text: "Container All text",
    container_external_id: "Container ID",
    container_description: "Container Description",
    container_name: "Container Name",
    container_attribution_name: "Attribution",
    competency_category: "Competency category",
    competency_label: "Competency label",
    competency_text: "Competency text",
    keywords: "Keywords",
    occupation: "Occupation",
    industry: "Industry",
    credential: "Credential",
    learn_opp: "Learning Opportunity"
  }.freeze

  attr_reader :container_type, :facets

  def initialize(params = {})
    @container_type = params.fetch(:container_type, CONTAINER_TYPES.keys.first)

    @facets = params.fetch(:facets, []).map do |f|
      Facet.new(
        key: f[:key],
        optional: ActiveRecord::Type::Boolean.new.deserialize(f[:optional]),
        value: f[:value]
      )
    end

    @facets << Facet.new(key: FACETS.keys.first) if facets.empty?
  end

  def to_params
    {
      container_type: CONTAINER_TYPES.fetch(container_type),
      facets: facets.select(&:value?).map(&:to_h)
    }
  end

  class Facet < ApplicationForm
    attr_reader :id, :key, :optional, :value

    def initialize(key: nil, optional: false, value: nil)
      @key = key
      @optional = optional
      @value = value
    end

    def to_h
      { key:, optional:, value: }
    end

    def value?
      value.present?
    end
  end
end
