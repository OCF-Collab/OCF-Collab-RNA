class SearchController < ApplicationController
  def index
    @competency_query = params[:competency_query]&.squish.presence
    @container_query = params[:container_query]&.squish.presence

    if @competency_query || @container_query
      @search = Search.new(
        competency_query: @competency_query,
        container_query: @container_query,
        page: params[:page],
        tenant: current_tenant
      )

      if @competency_query && @container_query && @search.competency_results_count.zero?
        search = Search.new(
          competency_query: @competency_query,
          tenant: current_tenant
        )

        @has_containerless_results = search.competency_results_count.positive?
      end
    end
  end
end
