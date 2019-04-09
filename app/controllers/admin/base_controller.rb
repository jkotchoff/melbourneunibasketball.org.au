class Admin::BaseController < ApplicationController
  before_action :require_admin
  before_action :set_admin

  newrelic_ignore if defined?(NewRelic)

  private

    def require_admin
      return true if Rails.env.test?
      authenticate_or_request_with_http_basic("MUBC Admin") do |user, password|
        authenticated_super_password = ENV['SUPERADMIN_PASSWORD'] == password
        is_admin = ENV['ADMIN_USERNAME'] == user && (ENV['ADMIN_PASSWORD'] == password || authenticated_super_password)
        cookies[:superadmin] = true if is_admin and authenticated_super_password
        is_admin
      end
    end

    def require_superadmin
      render text: 'unauthorised - only the superadmin account can access this' and return false unless cookies[:superadmin].present?
    end

  def set_admin
    @admin = true
  end
end
