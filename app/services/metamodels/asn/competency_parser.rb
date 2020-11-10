module Metamodels
  module Asn
    class CompetencyParser
      attr_reader :competency_data

      def initialize(competency_data:)
        @competency_data = competency_data
      end

      def competency_attributes
        {
          identifier: attr_value(""),
          code: attr_value("http://purl.org/ASN/schema/core/statementNotation"),
          alternative_code: attr_value("http://purl.org/ASN/schema/core/altCodedNotation"),
          label: attr_value("http://purl.org/ASN/schema/core/statementLabel"),
          alternative_label: nil,
          name: nil,
          competency_text: attr_value("http://purl.org/dc/terms/description"),
          abbreviated_competency_text: nil,
          comment: attr_value(""),
          competency_category: nil,
          concept_keyword: attr_value(""),
          education_level: list_attr_value("http://purl.org/dc/terms/educationLevel"),
          complexity_level: attr_value(""),
          language: attr_value("http://purl.org/dc/terms/language"),
          list_id: attr_value("http://purl.org/ASN/schema/core/listID"),
          creator: attr_value("http://id.loc.gov/vocabulary/relators/aut"),
          subject: attr_value("http://purl.org/dc/terms/subject"),
          derived_from: nil,
          comprised_of: nil,
          skill_embodied: nil,
          ability_embodied: nil,
          knowledge_embodied: nil,
          task_embodied: nil,
          prerequesite: nil,
          broad_alignment: nil,
          exact_alignment: nil,
          major_alignment: nil,
          minor_alignment: nil,
          narrow_alignment: nil,
        }
      end

      def attr_value(key)
        return nil unless competency_data.has_key?(key)

        competency_data[key].first["value"]
      end

      def list_attr_value(key)
        return nil unless competency_data.has_key?(key)

        competency_data[key].map { |v| v["value"] }
      end
    end
  end
end
