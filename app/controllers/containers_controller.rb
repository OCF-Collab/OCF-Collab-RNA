class ContainersController < ApplicationController
  def index
    if params[:query].present?
      @query = params[:query]
      @search = ContainersSearch.new(
        tenant: current_tenant,
        query: params[:query],
        page: params[:page]&.to_i,
      )
    end
  end

  def show
    fetcher = ContainerFetcher.new(
      tenant: current_tenant,
      id: params[:id],
    )

    @container_metadata = fetcher.container_metadata
    @container = fetcher.container
    @available_metamodels = Metamodels::METAMODELS
  end

  def download
    fetcher = ContainerFetcher.new(
      tenant: current_tenant,
      id: params[:id],
      requested_metamodel: params[:metamodel],
    )

    base_filename = params[:id].split("/").last.split(".").first
    extension = MIME::Types[fetcher.content_type].first.extensions.first
    filename = [base_filename, extension].join(".")

    send_data fetcher.body, type: fetcher.content_type, status: fetcher.status, filename: filename
  end
end
