class ProjectsController < ApplicationController
  allow_unauthenticated_access

  def index
    @projects = Project.all
  end
end
