module Metamodels
  module Case
    class CompetencyParser
      attr_reader :competency_data

      def initialize(competency_data:)
        @competency_data = competency_data
      end

      def competency_attributes
        {
          identifier: attr_value("identifier"),
          code: attr_value("humanCodingScheme"),
          alternative_code: nil,
          label: attr_value("CFItemType"),
          alternative_label: attr_value("alternativeLabel"),
          name: nil,
          competency_text: attr_value("fullStatement"),
          abbreviated_competency_text: attr_value("abbreviatedStatement"),
          comment: attr_value("notes"),
          competency_category: nil,
          concept_keyword: attr_value("conceptKeywords"),
          cirruculum_subject: attr_value("subject"),
          education_level: attr_value("educationLevel"),
          complexity_level: nil,
          language: attr_value("language"),
          list_id: attr_value("listEnumeration"),
          creator: attr_value("creator"),
          license: attr_value("licenseURI"),
          weight: nil,
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
        competency_data[key]
      end
    end
  end
end
