class VehicleLogsController < ApplicationController
  before_action :set_vehicle_log, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:create]

  layout "layout_with_sidebar"
  # GET /vehicle_logs
  def index
    if session[:isAdmin]
      @vehicle_logs = VehicleLog.all.order("timestamp desc")
    elsif session[:user_id]
      user = User.find(session[:user_id])
      AdminLog.create(alert_type: 2, message: "User #{user.name} tried to access vehicle logs but unsuccessed.",
                       link: "#", from: "vehicle_log#index")
      render file: 'public/401.html', status: 401
    else
      AdminLog.create(alert_type: 2, message: "Someone from #{request.remote_ip} tried to access vehicle logs but unsuccessed.",
                       link: "#", from: "vehicle_log#index")
      render file: 'public/401.html', status: 401
    end
  end

  # GET /vehicle_logs/1/edit
  def edit
  end

  # POST /vehicle_logs.json
  def create
    @vehicle_log = VehicleLog.new(vehicle_log_params)
    if @vehicle_log.save
      charge
    else
      render json: @vehicle_log.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /vehicle_log/1
  def update
    if @vehicle_log.update(vehicle_log_params)
      redirect_to @vehicle_log, notice: 'vehicle log was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /vehicle_logs/1
  def destroy
    @vehicle_log.destroy
    redirect_to vehicle_logs_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle_log
      @vehicle_log = VehicleLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vehicle_log_params
      params.permit(:plate, :timestamp)
    end

    def charge
      puts "Charging #{@vehicle_log.plate}"
      plate ||= Plate.find_by(plateNo: @vehicle_log.plate)
      if plate.nil?
        puts "Plate not found."
        AdminLog.create(alert_type: 0, message: "Plate #{@vehicle_log.plate} is not in the database.", 
                            link: edit_vehicle_log_path(id: @vehicle_log.id), from: "vehicle_log#charge")
        render(nothing: true, status: :not_found) and return
      else
        user = User.find(plate.user_id)
        user.quota -= 1
        if user.quota < 0
          AdminLog.create(alert_type: 1, message: "User #{user.name} is out of quota.", 
                            link: user_path(id: user.id), from: "vehicle_log#charge")
        end
        user.save
        puts "Charged #{user.name}"
        render(text: "Charged #{user.name}") and return
      end
    end
end
