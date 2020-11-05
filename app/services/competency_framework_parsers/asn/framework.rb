module CompetencyFrameworkParsers
  module Asn
    class Framework
      attr_reader :body

      def initialize(body:)
        @body = body
      end

      def competency_framework
        CompetencyFramework.new(framework_attributes)
      end

      def framework_attributes
        {
          id: body["@id"],
          title: attr_lang_value("name"),
          description: attr_lang_value("description"),
          publisher: attr_value("publisher")&.first,
          publisher_name: attr_lang_value("publisherName")&.first,
          publication_status: attr_value("publicationStatusType"),
          language: attr_value("inLanguage")&.first,
          rights: attr_value("rights"),
          rights_holder: attr_value("rightsHolder"),
          license: attr_value("license"),
          source: attr_value("source"),
          derived_from: attr_value("derivedFrom"),
          date_added: nil,
          identifier: framework_data["ceterms:ctid"],
          table_of_contents: nil,
          valid_start_date: attr_value("dateValidFrom"),
          valid_end_date: attr_value("dateValidUntil"),
          jurisdiction: nil,
          education_level: attr_value("educationLevelType"),
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
        @competencies ||= CompetencyFrameworkParsers::Asn::Competencies.new(body: body).competencies
      end
    end
  end
end
