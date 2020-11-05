COMPETENCY_FRAMEWORK_ATTRIBUTES = [
  {
    key: :title,
    label: "Title",
  }, {
    key: :description,
    label: "Description",
  }, {
    key: :education_level,
    label: "Education Level",
  }, {
    key: :language,
    label: "Language",
  }, {
    key: :publisher,
    label: "Publisher",
  }, {
    key: :publisher_name,
    label: "Publisher Name",
  }, {
    key: :rights,
    label: "Rights",
  }, {
    key: :rights_holder,
    label: "Rights Holder",
  }, {
    key: :license,
    label: "License",
  }, {
    key: :table_of_contents,
    label: "Table of Contents",
  }, {
    key: :identifier,
    label: "Identifier",
  }, {
    key: :valid_start_date,
    label: "Valid Start Date",
  }, {
    key: :valid_end_date,
    label: "Valid End Date",
  }, {
    key: :jurisdiction,
    label: "Jurisdiction",
  }, {
    key: :derived_from,
    label: "Derived From",
  }, {
    key: :publication_status,
    label: "Publication Status",
  }, {
    key: :source,
    label: "Source",
  }, {
    key: :date_added,
    label: "Date Added",
  },
]

CompetencyFramework = Struct.new(
  *COMPETENCY_FRAMEWORK_ATTRIBUTES.map { |a| a[:key] },
  :competencies,
  keyword_init: true,
) do
  def hierarchical?
    @hierarchical ||= competencies&.any? { |c| c.children.present? }
  end
end
