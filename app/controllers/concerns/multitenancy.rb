module Multitenancy
  class TenantMissing < StandardError; end

  extend ActiveSupport::Concern

  included do
    before_action :set_tenant!
  end

  def set_tenant!
    @current_tenant ||= find_tenant.tap do |tenant|
      raise TenantMissing unless tenant.present?

      session[:tenant_token] = tenant_token
    end
  end

  def find_tenant
    Tenant.joins(:tenant_tokens).where(tenant_tokens: { active: true, token: tenant_token }).first
  end

  def tenant_token
    params[:token] || session[:tenant_token]
  end
end
