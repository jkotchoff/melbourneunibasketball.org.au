class Admin::BaseController < ApplicationController
  layout        "admin"
  
  before_filter :require_superadmin, :if => lambda { Rails.env.production? }

  newrelic_ignore if defined?(NewRelic)

  private

    def require_superadmin
      authenticate_or_request_with_http_basic("MUBC Admin") do |user, password|
        ENV['ADMIN_USERNAME'] == user && ENV['ADMIN_PASSWORD'] == password
      end
    end
  
  
end
