class CompetencyFrameworksController < ApplicationController
  def index
    @competency_frameworks = []
  end

  def search
    @competency_frameworks = CompetencyFrameworksSearch.new(query: params.require(:search).require(:query)).competency_frameworks

    render :index
  end
end
