module Metamodels
  module Asn
    class FrameworkParser
      FRAMEWORK_TYPE_KEY = "http://www.w3.org/1999/02/22-rdf-syntax-ns#type"
      FRAMEWORK_TYPE_VALUE = "http://purl.org/ASN/schema/core/StandardDocument"

      attr_reader :body

      def initialize(body:)
        @body = body
      end

      def competency_framework
        CompetencyFramework.new(framework_attributes)
      end

      def framework_attributes
        {
          title: attr_value("http://purl.org/dc/elements/1.1/title"),
          description: attr_value("http://purl.org/dc/terms/description"),
          education_level: list_attr_value("http://purl.org/dc/terms/educationLevel"),
          language: attr_value("http://purl.org/dc/terms/language"),
          publisher: nil,
          publisher_name: attr_value("http://purl.org/dc/elements/1.1/publisher"),
          rights: document_attr_value("http://purl.org/dc/terms/rights"),
          rights_holder: document_attr_value("http://purl.org/dc/terms/rightsHolder"),
          license: attr_value("http://purl.org/dc/terms/license"),
          table_of_contents: attr_value("http://purl.org/dc/terms/tableOfContents"),
          identifier: nil,
          valid_start_date: nil,
          valid_end_date: nil,
          jurisdiction: attr_value("http://purl.org/ASN/schema/core/jurisdiction"),
          derived_from: nil,
          publication_status: attr_value("http://purl.org/ASN/schema/core/publicationStatus"),
          source: attr_value("http://purl.org/dc/terms/source"),
          date_added: attr_value("http://purl.org/ASN/schema/core/repositoryDate"),
          competencies: competencies,
        }
      end

      def attr_value(key)
        return nil unless framework_data.has_key?(key)

        framework_data[key].first["value"]
      end

      def framework_data
        @framework_data ||= body.values.find do |item|
          item.has_key?(FRAMEWORK_TYPE_KEY) &&
            item[FRAMEWORK_TYPE_KEY].first["value"] == FRAMEWORK_TYPE_VALUE
        end
      end

      def list_attr_value(key)
        return nil unless framework_data.has_key?(key)

        framework_data[key].map { |v| v["value"] }
      end

      def document_attr_value(key)
        return nil unless document_data.has_key?(key)

        document_data[key].first["value"]
      end

      def document_data
        @document_data ||= body.values.find do |item|
          item.has_key?("http://xmlns.com/foaf/0.1/primaryTopic")
        end
      end

      def competencies
        @competencies ||= Metamodels::Asn::CompetenciesParser.new(body: body).competencies
      end
    end
  end
end
