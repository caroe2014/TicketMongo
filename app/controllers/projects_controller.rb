class ProjectsController < ApplicationController
  
  before_action :verify_logged_in_user
  before_action :set_project, only: [:edit, :update, :destroy]
  before_action :set_company_in_session


  # GET /projects
  # GET /projects.json
  def index
   
    if ! params[:search].nil?            
       @projects = Project.search_by_nickname(@company._id, params[:search]) 
  
       if @projects.empty?
           @projects = Project.search_by_number(@company._id, params[:search])
           
       elsif @projects.empty?
            @projects = Project.search_by_name(@company._id, params[:search])           
       end           
    else    
       @projects = Project.where(company_id: session[:company_id])
    end
    
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
        
    if params[:project_id].present?
       @project_id = params[:project_id]
    elsif params[:id].present?
      @project_id = params[:id]
    end    

    @project = Project.find(@project_id)        
#    respond_with(@project.as_json)
    render json: @project 
  end

  # GET /projects/new
  def new
    @project = Project.new
   
  end

  # GET /projects/1/edit
  def edit
    
  end

  # POST /projects
  # POST /projects.json
  def create
    
    @project = Project.new(project_params)

    @project.company_id = session[:company_id] 
   
    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: 'Project was successfully created.' }
        format.json { render :index, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to projects_path, notice: 'Project was successfully updated.' }
        format.json { render :index, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
   
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :nickname, :project_number, :status, :start_task, :end_task, 
                                      :client, :phone, :estimate, :approved_budget, :accumulated_cost, :items_to_do, :start_project, :end_project, :register_status)
    end
end
