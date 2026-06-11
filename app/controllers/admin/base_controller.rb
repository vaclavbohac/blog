class Admin::BaseController < ApplicationController
  layout "admin"

  helper_method :admin_nav_active?

  private
    def admin_nav_active?(path)
      request.path == path || request.path.start_with?("#{path}/")
    end
end
