module Metamodels
  module Asn
    class CompetenciesParser
      FRAMEWORK_TYPE_KEY = "http://www.w3.org/1999/02/22-rdf-syntax-ns#type"
      FRAMEWORK_TYPE_VALUE = "http://purl.org/ASN/schema/core/StandardDocument"
      HAS_CHILD_KEY = "http://purl.org/gem/qualifiers/hasChild"

      attr_reader :body

      def initialize(body:)
        @body = body
      end

      def competencies
        root_competency_ids.map do |competency_id|
          collect_competency(competency_id)
        end
      end

      def root_competency_ids
        container_data[HAS_CHILD_KEY].map { |v| v["value"] }
      end

      def container_data
        @container_data ||= body.values.find do |item|
          item.has_key?(FRAMEWORK_TYPE_KEY) &&
            item[FRAMEWORK_TYPE_KEY].first["value"] == FRAMEWORK_TYPE_VALUE
        end
      end

      def collect_competency(id)
        competency_data = body[id]
        competency_attributes = Metamodels::Asn::CompetencyParser.new(competency_data: competency_data).competency_attributes
        competency_children_ids = children_ids(id)
        children = competency_children_ids.present? && competency_children_ids.map { |child_id| collect_competency(child_id) }

        Competency.new(
          **competency_attributes,
          children: children,
        )
      end

      def children_ids(id)
        body[id].has_key?(HAS_CHILD_KEY) && body[id][HAS_CHILD_KEY].map { |v| v["value"] }
      end
    end
  end
end
