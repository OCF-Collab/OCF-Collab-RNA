class CompetencyFrameworksController < ApplicationController
  def index
    if params[:query].present?
      @query = params[:query]
      @competency_frameworks_metadata = CompetencyFrameworksSearch.new(query: params[:query]).competency_frameworks_metadata
    end
  end

  def show
    fetcher = CompetencyFrameworkFetcher.new(id: params[:id])

    @competency_framework_metadata = fetcher.competency_framework_metadata
    @competency_framework = fetcher.competency_framework
  end
end
