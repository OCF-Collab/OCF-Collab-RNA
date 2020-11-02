CompetencyFramework = Struct.new(
  :id,
  :title,
  :description,
  :publisher,
  :publisher_name,
  :publication_status,
  :language,
  :rights,
  :rights_holder,
  :license,
  :source,
  :derived_from,
  :date_added,
  :identifier,
  :table_of_contents,
  :valid_start_date,
  :valid_end_date,
  :jurisdiction,
  :education_level,
  :has_top_competency,
  :has_child,
  :has_top_child,
  :competencies,
  keyword_init: true,
) do

  def hierarchical?
    @hierarchical ||= competencies&.any? { |c| c.children.present? }
  end
end
