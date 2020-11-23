module Metamodels
  module CtdlAsn
    class FrameworkParser
      attr_reader :body

      def initialize(body:)
        @body = body
      end

      def competency_framework
        CompetencyFramework.new(framework_attributes)
      end

      def framework_attributes
        {
          title: attr_lang_value("name"),
          description: attr_lang_value("description"),
          cirruculum_subject: nil,
          education_level: attr_value("educationLevelType"),
          language: attr_value("inLanguage"),
          author: nil,
          publisher: attr_value("publisher"),
          publisher_name: attr_lang_value("publisherName"),
          concept_keyword: attr_lang_value("conceptKeyword"),
          concept_category: attr_lang_value("conceptTerm"),
          rights: attr_value("rights", "asn"),
          rights_holder: attr_value("rightsHolder"),
          license: attr_value("license"),
          table_of_contents: nil,
          identifier: identifiers,
          date_created: attr_value("dateCreated"),
          valid_start_date: attr_value("dateValidFrom"),
          valid_end_date: attr_value("dateValidUntil"),
          jurisdiction: nil,
          derived_from: attr_value("derivedFrom"),
          publication_status: attr_value("publicationStatusType"),
          source: attr_value("source"),
          date_added: nil,
          competencies: competencies,
        }
      end

      def attr_lang_value(key)
        if attr_value(key).blank?
          return nil
        end

        attr_value(key).values.first
      end

      def attr_value(key, prefix = "ceasn")
        framework_data["%s:%s" % [prefix, key]]
      end

      def framework_data
        @framework_data ||= body["@graph"].find do |item|
          item["@type"] == "ceasn:CompetencyFramework"
        end
      end

      def identifiers
        [
          attr_value("ctid", "ceterms"),
          attr_value("identifier"),
        ].compact
      end

      def competencies
        @competencies ||= Metamodels::CtdlAsn::CompetenciesParser.new(body: body).competencies
      end
    end
  end
end
