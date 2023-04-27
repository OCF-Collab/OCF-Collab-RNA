class SearchResultParser
  attr_reader :result

  def initialize(result:)
    @result = result
  end

  def search_result
    @search_result ||= ContainerSearchResult.new(
      **ContainerMetadataParser.new(body: result).container_metadata.to_h,
      competencies:,
      total_count: result.fetch("total_count")
    )
  end

  private

  def competencies
    result.fetch("competencies").map do |competency|
      CompetencySearchResult.new(
        competency_text: competency.fetch("competency_text"),
        external_id: competency.fetch("external_id"),
        hit_score: competency.fetch("hit_score")
      )
    end
  end
end
