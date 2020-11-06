module Metamodels
  module Case
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
          title: attr_value("title"),
          description: attr_value("description"),
          education_level: attr_value("educationLevel"),
          language: attr_value("language"),
          publisher: nil,
          publisher_name: attr_value("publisher"),
          rights: nil,
          rights_holder: attr_value("creator"),
          license: attr_value("license"),
          table_of_contents: nil,
          identifier: attr_value("identifier"),
          valid_start_date: attr_value("statusStartDate"),
          valid_end_date: attr_value("statusEndDate"),
          jurisdiction: nil,
          derived_from: nil,
          publication_status: attr_value("adoptionStatus"),
          source: attr_value("officialSourceURL"),
          date_added: nil,
          competencies: competencies,
        }
      end

      def attr_value(key)
        framework_data[key]
      end

      def framework_data
        body["CFDocument"]
      end

      def competencies
        @competencies ||= Metamodels::Case::CompetenciesParser.new(body: body).competencies
      end
    end
  end
end
