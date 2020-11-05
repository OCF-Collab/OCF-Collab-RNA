module CompetencyFrameworkParsers
  module Case
    class Competency
      attr_reader :competency_data

      def initialize(competency_data:)
        @competency_data = competency_data
      end

      def competency_attributes
        {
          identifier: attr_value("identifier"),
          code: attr_value("humanCodingScheme"),
          label: attr_value("CFItemType"),
          alternative_label: attr_value("alternativeLabel"),
          name: nil,
          competency_text: attr_value("fullStatement"),
          abbreviated_competency_text: attr_value("abbreviatedStatement"),
          comment: attr_value("notes"),
          competency_category: nil,
          concept_keyword: attr_value("conceptKeywords"),
          education_level: attr_value("educationLevel"),
          complexity_level: nil,
          language: attr_value("language"),
          list_id: attr_value("listEnumeration"),
          creator: attr_value("creator"),
          subject: attr_value("subject"),
          weight: attr_value("weight"),
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
