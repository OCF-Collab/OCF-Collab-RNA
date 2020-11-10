module Metamodels
  METAMODELS = [
    {
      label: "CTDL-ASN",
      concept_url: "https://ocf-collab.org/concepts/6ad27cff-5832-4b3d-bd3e-892208b80cad",
      framework_parser: Metamodels::CtdlAsn::FrameworkParser,
    }, {
      label: "CASE",
      concept_url: "https://ocf-collab.org/concepts/f63b9a67-543a-49ab-b5ed-8296545c1db5",
      framework_parser: Metamodels::Case::FrameworkParser,
    }, {
      label: "ASN",
      concept_url: "https://ocf-collab.org/concepts/concepts/f9a2b710-1cc4-4065-85fd-596b3c40906c",
      framework_parser: Metamodels::Asn::FrameworkParser,
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

    def competency_framework_parser
      config[:framework_parser]
    end
  end
end
