class ProjectsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_project, only: [:update, :destroy, :show]

    #temporary code
    before_action do
      Rails.logger.debug ">>> Current user: #{current_user.inspect}"
    end

    def index
      authorize Project
      projects = current_user.projects
      render json: projects
    end
  
    def create
      @project = current_user.projects.build(project_params)
      authorize @project
    
      if @project.save
        render json: @project, status: :created
      else
        render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
      end
    end
    
  
    def update
      authorize @project
      if @project.update(project_params)
        render json: @project
      else
        render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def show
      authorize @project
      render json: @project
    end
  
    def destroy
      @project.destroy
      head :no_content
    end
  
    private
  
    def set_project
      @project = Project.find(params[:id])
      authorize @project
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Project not found" }, status: :not_found
    end
  
    def project_params
      params.require(:project).permit(:name, :description)
    end
  end
  