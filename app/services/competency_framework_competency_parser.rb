class CompetencyFrameworkCompetencyParser
  attr_reader :competency_data

  def initialize(competency_data:)
    @competency_data = competency_data
  end

  def competency_attributes
    {
      identifier: attr_value("identifier"),
      code: attr_value("codedNotation"),
      label: attr_value("competencyCategory"),
      name: attr_value("competencyLabel"),
      competency_text: attr_lang_value("competencyText"),
      competency_category: attr_value("competencyCategory"),
      concept_keyword: attr_value("conceptKeyword"),
      education_level: attr_value("educationLevelType"),
      complexity_level: attr_value("complexityLevel"),
      language: attr_value("inLanguage"),
      list_id: attr_value("listID"),
      creator: attr_value("author"),
      weight: attr_value("weight"),
      derived_from: attr_value("derivedFrom"),
      comprised_of: attr_value("comprisedOf"),
      skill_embodied: attr_value("skillEmbodied"),
      ability_embodied: attr_value("abilityEmbodied"),
      knowledge_embodied: attr_value("knowledgeEmbodied"),
      task_embodied: attr_value("taskEmbodied"),
      prerequesite: attr_value("prerequesiteCompetency"),
      broad_alignment: attr_value("broadAlignment"),
      exact_alignment: attr_value("exactAlignment"),
      major_alignment: attr_value("majorAlignment"),
      minor_alignment: attr_value("minorAlignment"),
      narrow_alignment: attr_value("minorAlignment"),
    }
  end

  def attr_lang_value(key)
    attr_value(key)[language_code]
  end

  def attr_value(key)
    competency_data["ceasn:%s" % key]
  end

  def language_code
    "en-us"
  end
end
