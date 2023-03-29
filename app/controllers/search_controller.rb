class SearchController < ApplicationController
  def index
    search_form_params = params.fetch(:search_form, {})
    @form = SearchForm.new(search_form_params)
    return if search_form_params.empty?

    if @form.valid?
      @search = Search.new(
        **@form.to_params,
        page: params[:page],
        tenant: current_tenant
      )
    else
      @error = "Please enter at least one non-optional term to perform a search"
    end
  end
end
