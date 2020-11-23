module Metamodels
  module Asn
    class CompetencyParser
      SCHEMA_URLS = {
        asn: "http://purl.org/ASN/schema/core",
        dcterms: "http://purl.org/dc/terms",
        loc: "http://id.loc.gov/vocabulary/relators",
      }

      attr_reader :competency_data

      def initialize(competency_data:)
        @competency_data = competency_data
      end

      def competency_attributes
        {
          identifier: list_attr_value(:asn, "identifier"),
          code: attr_value(:asn, "statementNotation"),
          alternative_code: list_attr_value(:asn, "altCodedNotation"),
          label: list_attr_value(:asn, "statementLabel"),
          alternative_label: nil,
          name: nil,
          competency_text: attr_value(:dcterms, "description"),
          abbreviated_competency_text: nil,
          comment: list_attr_value(:asn, "comment"),
          competency_category: list_attr_value(:asn, "conceptTerm"),
          concept_keyword: list_attr_value(:asn, "conceptKeyword"),
          cirruculum_subject: list_attr_value(:dcterms, "subject"),
          education_level: list_attr_value(:asn, "educationLevel"),
          complexity_level: list_attr_value(:asn, "complexityLevel"),
          language: nil,
          list_id: list_attr_value(:asn, "listID"),
          creator: list_attr_value(:loc, "aut"),
          license: nil,
          derived_from: list_attr_value(:asn, "derivedFrom"),
          comprised_of: list_attr_value(:asn, "comprisedOf"),
          skill_embodied: list_attr_value(:asn, "skillEmbodied"),
          ability_embodied: nil,
          knowledge_embodied: nil,
          task_embodied: nil,
          prerequesite: list_attr_value(:asn, "prerequisiteAlignment"),
          broad_alignment: list_attr_value(:asn, "broadAlignment"),
          exact_alignment: list_attr_value(:asn, "exactAlignment"),
          major_alignment: list_attr_value(:asn, "majorAlignment"),
          minor_alignment: list_attr_value(:asn, "minorAlignment"),
          narrow_alignment: list_attr_value(:asn, "narrowAlignment"),
        }
      end

      def list_attr_value(schema, key)
        return nil unless competency_data.has_key?(attribute(schema, key))

        competency_data[attribute(schema, key)].map { |v| v["value"] }
      end

      def attribute(schema, key)
        "%s/%s" % [
          SCHEMA_URLS[schema],
          key,
        ]
      end

      def attr_value(schema, key)
        list_attr_value(schema, key)&.first
      end
    end
  end
end
