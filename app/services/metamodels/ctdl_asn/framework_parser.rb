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
          education_level: attr_value("educationLevelType"),
          language: attr_value("inLanguage"),
          publisher: attr_value("publisher"),
          publisher_name: attr_lang_value("publisherName"),
          rights: attr_value("rights"),
          rights_holder: attr_value("rightsHolder"),
          license: attr_value("license"),
          table_of_contents: nil,
          identifier: framework_data["ceterms:ctid"],
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

        attr_value(key)[language_code]
      end

      def attr_value(key)
        framework_data["ceasn:%s" % key]
      end

      def framework_data
        @framework_data ||= body["@graph"].find do |item|
          item["@type"] == "ceasn:CompetencyFramework"
        end
      end

      def language_code
        "en-us"
      end

      def competencies
        @competencies ||= Metamodels::CtdlAsn::CompetenciesParser.new(body: body).competencies
      end
    end
  end
end
