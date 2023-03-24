require "cgi"

class ContainerFetcher
  ASSET_FILE_PATH = "/containers/asset_file"

  attr_reader :tenant, :id, :requested_metamodel

  def initialize(tenant:, id:, requested_metamodel: nil)
    @tenant = tenant
    @id = id
    @requested_metamodel = requested_metamodel
  end

  def container
    @container ||= container_parser.new(body: response_data).container
  end

  def response_data
    @response_data ||= JSON.parse(body)
  end

  def body
    response.body
  end

  def content_type
    response.content_type
  end

  def status
    response.status
  end

  def response
    @response ||= oauth2_token.get(path, params: params)
  end

  def oauth2_token
    oauth2_client.client_credentials.get_token
  end

  def oauth2_client
    @oauth2_client ||= TenantOauth2Client.new(tenant: tenant)
  end

  def path
    ASSET_FILE_PATH
  end

  def params
    {
      id: id,
      metamodel: requested_metamodel,
    }
  end

  def container_parser
    metamodel.container_parser
  end

  def metamodel
    @metamodel ||= Metamodels.from_concept_url(metamodel_concept_url)
  end

  def metamodel_concept_url
    requested_metamodel || container_metadata.provider_meta_model
  end

  def container_metadata
    @container_metadata ||= ContainerMetadataFetcher.new(
      tenant: tenant,
      id: id,
    ).container_metadata
  end
end
