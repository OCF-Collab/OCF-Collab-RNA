module Metamodels
  METAMODELS = [
    {
      label: "CTDL-ASN",
      concept_url: "https://ocf-collab.org/concepts/f9a2b710-1cc4-4065-85fd-596b3c40906c",
      container_parser: Metamodels::CtdlAsn::ContainerParser,
    }, {
      label: "CASE",
      concept_url: "https://ocf-collab.org/concepts/f63b9a67-543a-49ab-b5ed-8296545c1db5",
      container_parser: Metamodels::Case::ContainerParser,
    }, {
      label: "ASN",
      concept_url: "https://ocf-collab.org/concepts/6ad27cff-5832-4b3d-bd3e-892208b80cad",
      container_parser: Metamodels::Asn::ContainerParser,
    }
  ]

  def self.from_concept_url(url)
    config = METAMODELS.find do |m|
      m[:concept_url] == url
    end

    Metamodel.new(config: config)
  end

  class Metamodel
    attr_reader :config

    def initialize(config:)
      @config = config
    end

    def container_parser
      config[:container_parser]
    end
  end
end
