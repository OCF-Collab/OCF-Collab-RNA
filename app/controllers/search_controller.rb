class SearchController < ApplicationController
  # GET /
  # GET /containers/:container_id/search
  def index
    @search_form_params = params.fetch(:search_form, {})
    @form = SearchForm.new(@search_form_params)
    return if @search_form_params.empty?

    @global_search = params[:container_id].blank?

    @search = Search.new(
      **@form.to_params,
      container_id: params[:container_id],
      page: params[:page],
      tenant: current_tenant
    )

    @search_results = @search.results.map do |result|
      SearchResultParser.new(result:).search_result
    end
  end
end
