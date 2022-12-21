class CompetenciesController < ApplicationController
  def show
    @competency = CompetencyFetcher
      .new(id: params.require(:id), tenant: current_tenant)
      .competency
  end
end
