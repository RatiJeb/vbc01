class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  # GET /projects or /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project_form = ProjectForm.new
  end

  # GET /projects/1/edit
  def edit
    @project_form = ProjectForm.new(project: @project)
  end

  # POST /projects or /projects.json
  def create
    @project_form = ProjectForm.new(project_params)

    respond_to do |format|
      if @project_form.create
        format.html { redirect_to @project_form, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project_form }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    @project_form = ProjectForm.new(project_params, project: @project)
    respond_to do |format|
      if @project_form.update
        format.html { redirect_to @project_form, notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project_form }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project_form = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:title, :format, :description, :category_id, :active)
    end
end
