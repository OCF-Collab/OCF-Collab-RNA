module Metamodels
  module Asn
    class ContainerParser
      FRAMEWORK_TYPE_KEY = "http://www.w3.org/1999/02/22-rdf-syntax-ns#type"
      FRAMEWORK_TYPE_VALUE = "http://purl.org/ASN/schema/core/StandardDocument"
      SCHEMA_URLS = {
        asn: "http://purl.org/ASN/schema/core",
        dcterms: "http://purl.org/dc/terms",
        dcelements: "http://purl.org/dc/elements/1.1",
        loc: "http://id.loc.gov/vocabulary/relators",
      }

      attr_reader :body

      def initialize(body:)
        @body = body
      end

      def container
        Container.new(container_attributes)
      end

      def container_attributes
        {
          title: attr_value(:dcelements, "title"),
          description: attr_value(:dcterms, "description"),
          cirruculum_subject: list_attr_value(:dcterms, "subject"),
          education_level: list_attr_value(:dcterms, "educationLevel"),
          language: list_attr_value(:dcterms, "language"),
          author: list_attr_value(:loc, "aut"),
          publisher: nil,
          publisher_name: list_attr_value(:dcelements, "publisher"),
          concept_keyword: list_attr_value(:asn, "conceptKeyword"),
          concept_category: list_attr_value(:asn, "conceptTerm"),
          rights: document_list_attr_value(:dcterms, "rights"),
          rights_holder: document_list_attr_value(:dcterms, "rightsHolder"),
          license: list_attr_value(:dcterms, "license"),
          table_of_contents: list_attr_value(:dcterms, "tableOfContents"),
          identifier: nil,
          date_created: document_list_attr_value(:dcterms, "created"),
          valid_start_date: list_attr_value(:dcterms, "valid"),
          valid_end_date: nil,
          jurisdiction: list_attr_value(:asn, "jurisdiction"),
          derived_from: nil,
          publication_status: list_attr_value(:asn, "publicationStatus"),
          source: list_attr_value(:dcterms, "source"),
          date_added: list_attr_value(:asn, "repositoryDate"),
          competencies: competencies,
        }
      end

      def attr_value(schema, key)
        list_attr_value(schema, key)&.first
      end

      def list_attr_value(schema, key)
        return nil unless container_data.has_key?(attribute(schema, key))

        container_data[attribute(schema, key)].map { |v| v["value"] }
      end

      def attribute(schema, key)
        "%s/%s" % [
          SCHEMA_URLS[schema],
          key,
        ]
      end


      def container_data
        @container_data ||= body.values.find do |item|
          item.has_key?(FRAMEWORK_TYPE_KEY) &&
            item[FRAMEWORK_TYPE_KEY].first["value"] == FRAMEWORK_TYPE_VALUE
        end
      end

      def document_list_attr_value(schema, key)
        return nil unless document_data.has_key?(attribute(schema, key))

        document_data[attribute(schema, key)].map { |v| v["value"] }
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
