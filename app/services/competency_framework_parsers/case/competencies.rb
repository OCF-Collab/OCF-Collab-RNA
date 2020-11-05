module CompetencyFrameworkParsers
  module Case
    class Competencies
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
        children_ids(framework_identifier)
      end

      def framework_identifier
        body["CFDocument"]["identifier"]
      end

      def children_ids(identifier)
        children_map[identifier]
      end

      def children_map
        @children_map ||= associations.each_with_object(Hash.new { |h, k| h[k] = [] }) do |association, hash|
          parent_id = association["destinationNodeURI"]["identifier"]
          child_id = association["originNodeURI"]["identifier"]
          hash[parent_id] << child_id
        end
      end

      def associations
        @associations = children_associations.sort_by do |association|
          association["sequenceNumber"]
        end
      end

      def children_associations
        @children_associations ||= body["CFAssociations"].select do |association|
          association["associationType"] == "isChildOf"
        end
      end

      def collect_competency(id, parent_id = nil)
        competency_data = competencies_map[id]
        competency_attributes = CompetencyFrameworkParsers::Case::Competency.new(competency_data: competency_data).competency_attributes

        competency_children_ids = children_ids(id)
        children = competency_children_ids.present? && competency_children_ids.map { |child_id| collect_competency(child_id, id) }

        ::Competency.new(
          **competency_attributes,
          children: children,
        )
      end

      def competencies_map
        @competencies_map ||= competency_items.each_with_object({}) do |item, hash|
          hash[item["identifier"]] = item
        end
      end

      def competency_items
        @competency_items ||= body["CFItems"]
      end
    end
  end
end
