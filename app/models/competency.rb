COMPETENCY_ATTRIBUTES = [
  {
    key: :identifier,
    label: "Identifier",
  }, {
    key: :code,
    label: "Code",
  }, {
    key: :alternative_code,
    label: "Alternative Code",
  }, {
    key: :label,
    label: "Label",
  }, {
    key: :alternative_label,
    label: "Alternative Label",
  }, {
    key: :name,
    label: "Name",
  }, {
    key: :competency_text,
    label: "Competency Text",
  }, {
    key: :abbreviated_competency_text,
    label: "Abbreviated Competency Text",
  }, {
    key: :comment,
    label: "Comment",
  }, {
    key: :competency_category,
    label: "Competency Category",
  }, {
    key: :concept_keyword,
    label: "Concept Keyword",
  }, {
    key: :education_level,
    label: "Education Level",
  }, {
    key: :complexity_level,
    label: "Complexity Level",
  }, {
    key: :language,
    label: "Language",
  }, {
    key: :list_id,
    label: "List ID",
  }, {
    key: :creator,
    label: "Creator",
  }, {
    key: :subject,
    label: "Subject",
  }, {
    key: :weight,
    label: "Weight",
  }, {
    key: :derived_from,
    label: "Derived From",
  }, {
    key: :comprised_of,
    label: "Comprised Of",
  }, {
    key: :skill_embodied,
    label: "Skill Embodied",
  }, {
    key: :ability_embodied,
    label: "Ability Embodied",
  }, {
    key: :knowledge_embodied,
    label: "Knowledge Embodied",
  }, {
    key: :task_embodied,
    label: "Task Embodied",
  }, {
    key: :prerequesite,
    label: "Prerequesite",
  }, {
    key: :broad_alignment,
    label: "Broad Alignment",
  }, {
    key: :exact_alignment,
    label: "Exact Alignment",
  }, {
    key: :major_alignment,
    label: "Major Alignment",
  }, {
    key: :minor_alignment,
    label: "Minor Alignment",
  }, {
    key: :narrow_alignment,
    label: "Narrow Alignment",
  },
]

Competency = Struct.new(
  *COMPETENCY_ATTRIBUTES.map { |a| a[:key] },
  :children,
  keyword_init: true,
)
