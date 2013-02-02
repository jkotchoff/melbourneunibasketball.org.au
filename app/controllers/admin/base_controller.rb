class Admin::BaseController < ApplicationController
  layout        "admin"
  
  before_filter :require_superadmin, :if => lambda { Rails.env.production? }

  newrelic_ignore if defined?(NewRelic)

  private

    def require_superadmin
      authenticate_or_request_with_http_basic("TVfeeds Admin") do |user, password|
        APP_CONFIG['admin_username'] == user && APP_CONFIG['admin_password'] == password
      end
    end
  
  
end
