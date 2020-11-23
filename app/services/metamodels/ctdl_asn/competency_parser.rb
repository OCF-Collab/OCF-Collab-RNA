module Metamodels
  module CtdlAsn
    class CompetencyParser
      attr_reader :competency_data

      def initialize(competency_data:)
        @competency_data = competency_data
      end

      def competency_attributes
        {
          identifier: attr_value("identifier"),
          code: attr_value("codedNotation"),
          alternative_code: nil,
          label: nil,
          alternative_label: nil,
          name: attr_lang_value("competencyLabel"),
          competency_text: attr_lang_value("competencyText"),
          abbreviated_competency_text: nil,
          comment: nil,
          competency_category: attr_lang_value("competencyCategory"),
          concept_keyword: attr_lang_value("conceptKeyword"),
          cirruculum_subject: nil,
          education_level: attr_value("educationLevelType"),
          complexity_level: attr_value("complexityLevel"),
          language: attr_value("inLanguage"),
          list_id: attr_value("listID"),
          creator: attr_value("author"),
          subject: nil,
          license: nil,
          weight: attr_value("weight"),
          derived_from: attr_value("derivedFrom"),
          comprised_of: attr_value("comprisedOf"),
          skill_embodied: attr_value("skillEmbodied"),
          ability_embodied: attr_value("abilityEmbodied"),
          knowledge_embodied: attr_value("knowledgeEmbodied"),
          task_embodied: attr_value("taskEmbodied"),
          prerequesite: attr_value("prerequesiteCompetency"),
          broad_alignment: attr_value("broadAlignment"),
          exact_alignment: attr_value("exactAlignment"),
          major_alignment: attr_value("majorAlignment"),
          minor_alignment: attr_value("minorAlignment"),
          narrow_alignment: attr_value("minorAlignment"),
        }
      end

      def attr_lang_value(key)
        if attr_value(key).blank?
          return nil
        end

        attr_value(key).values.first
      end

      def attr_value(key, prefix = "ceasn")
        competency_data["%s:%s" % [prefix, key]]
      end

      def identifiers
        [
          attr_value("ctid", "ceterms"),
          attr_value("identifier"),
        ].compact
      end
    end
  end
end
