module Metamodels
  module CtdlAsn
    class CompetenciesParser
      attr_reader :body

      def initialize(body:)
        @body = body
      end

      def competencies
        root_competency_ids.map do |competency_id|
          collect_competency(competency_id)
        end
      end

      def collect_competency(id)
        competency_data = competencies_map[id]
        competency_attributes = Metamodels::CtdlAsn::CompetencyParser.new(competency_data: competency_data).competency_attributes
        children_ids = competency_data["ceasn:hasChild"]
        children = children_ids.present? && children_ids.map { |child_id| collect_competency(child_id) }

        Competency.new(
          **competency_attributes,
          children: children,
        )
      end

      def root_competency_ids
        container_data["ceasn:hasTopChild"]
      end

      def container_data
        @container_data ||= body["@graph"].find do |item|
          ContainerParser::CONTAINER_TYPE_VALUES.include?(item["@type"])
        end
      end

      def competencies_map
        @competencies_map ||= competency_items.inject({}) do |hash, item|
          hash[item["@id"]] = item
          hash
        end
      end

      def competency_items
        @competency_items ||= body["@graph"].select do |item|
          item["@type"] == "ceasn:Competency"
        end
      end
    end
  end
end
