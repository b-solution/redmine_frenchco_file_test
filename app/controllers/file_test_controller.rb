class FileTestController < ApplicationController
  unloadable

  before_filter :find_project
  before_filter :find_issue, only: [:create_or_update]
  before_filter :authorize, except: [:update_active_columns]
  before_filter :require_admin, only: [:update_active_columns]


  def update_active_columns
    columns = ActiveFilePlanColumn::ALL_COLUMNS
    columns.each do |c|
      a = ActiveFilePlanColumn.where(project_id: @project.id, column_name: c).first_or_initialize
      a.is_active = params[c] ?  true : false
      a.save
    end
    redirect_to back_url
  end


  def index
    @issues = @project.issues.order('issues.id DESC').
        where(status_id: IssueStatus.where.not(is_closed: true).pluck(:id) ).
        includes(:test_plan).references(:test_plan)

    @active_columns = ActiveFilePlanColumn.active_columns(@project)
    @last_update = TestPlan.where(project_id: @project.id).order('updated_on DESC').first.try(:updated_on).to_s
  end

  def create_or_update
    @test_plan = @issue.test_plan || TestPlan.new(issue_id: @issue.id)
    @test_plan.project_id = @project.id

    @type = params[:type]
    @value = params[:value]
    #check type if is safe
    if @test_plan.safe_attribute?(@type)
      if @type.in?(['url', 'client_note'])
        @test_plan.send("#{@type}=", @value)
      else
        @test_plan.send("#{@type}=", @value) if TestPlan::STATUS.map{|v| v.last }.include?(@value.to_i)
      end
    end
    @test_plan.save

    @last_update = TestPlan.where(project_id: @project.id).order('updated_on DESC').first.try(:updated_on).to_s
    respond_to do |format|
      format.js {}
    end
  end

  def destroy

  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  rescue
    render_404
  end

  def find_issue
    @issue = @project.issues.find(params[:issue_id])
  rescue
    render_404
  end


end
