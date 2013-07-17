class AdminLogsController < ApplicationController
  before_action :set_admin_log, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:create]
  before_action :authenticate

  layout "layout_with_sidebar"

  # GET /admin_logs
  def index
    @admin_logs = AdminLog.all.order("created_at desc")
  end

  # GET /admin_logs/1
  # GET /admin_logs/1.json
  def show
  end

  # GET /admin_logs/new
  def new
    @admin_log = AdminLog.new
  end

  # GET /admin_logs/1/edit
  def edit
  end

  # POST /admin_logs
  # POST /admin_logs.json
  def create
    @admin_log = AdminLog.new(admin_log_params)

    respond_to do |format|
      if @admin_log.save
        format.html { redirect_to @admin_log, notice: 'Admin log was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_log }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_logs/1
  # PATCH/PUT /admin_logs/1.json
  def update
    respond_to do |format|
      if @admin_log.update(admin_log_params)
        format.html { redirect_to @admin_log, notice: 'Admin log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_logs/1
  # DELETE /admin_logs/1.json
  def destroy
    @admin_log.destroy
    respond_to do |format|
      format.html { redirect_to admin_logs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_log
      @admin_log = AdminLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_log_params
      params.require(:admin_log).permit(:alert_type, :message, :link, :from)
    end

    def authenticate
      unless session[:isAdmin]
        AdminLog.create(alert_type: 2, message: "Someone failed to authenticate [#{request.remote_ip}]", from: "admin_logs#authenticate")
        render(file: 'public/401.html', status: :unauthorized) and return
      end
    end
end
