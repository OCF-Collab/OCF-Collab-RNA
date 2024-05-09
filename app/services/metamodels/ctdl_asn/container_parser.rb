module Metamodels
  module CtdlAsn
    class ContainerParser
      CONTAINER_TYPE_VALUES = %w(ceasn:CompetencyFramework ceterms:Collection)

      attr_reader :body

      def initialize(body:)
        @body = body
      end

      def container
        Container.new(container_attributes)
      end

      def container_attributes
        {
          title: attr_lang_value("name") || attr_lang_value("name", "ceterms"),
          description: attr_lang_value("description") || attr_lang_value("description", "ceterms"),
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

      def attr_lang_value(key, prefix = "ceasn")
        return if attr_value(key, prefix).blank?

        attr_value(key, prefix).values.first
      end

      def attr_value(key, prefix = "ceasn")
        container_data["%s:%s" % [prefix, key]]
      end

      def container_data
        @container_data ||= body["@graph"].find do |item|
          CONTAINER_TYPE_VALUES.include?(item["@type"])
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
