class ContainerMetadataParser
  attr_reader :body

  def initialize(body:)
    @body = body
  end

  def container_metadata
    @container_metadata ||= ContainerMetadata.new(
      id: body["id"],
      title: body["title"],
      description: body["description"],
      attribution_name: body["attributionName"],
      attribution_url: body["attributionUrl"],
      attribution_logo_url: body["attributionLogoUrl"],
      provider_meta_model: body["providerMetaModel"],
      registry_rights: body["registryRights"],
      beneficiary_rights: body["beneficiaryRights"],
      html_url: body["htmlUrl"]
    )
  end
end
