class VehicleLogsController < ApplicationController
  before_action :set_vehicle_log, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:create]

  # GET /vehicle_logs
  # GET /vehicle_logs.json
  def index
    @vehicle_logs = VehicleLog.all
  end

  # POST /vehicle_logs.json
  def create
    @vehicle_log = VehicleLog.new(vehicle_log_params)

    if @vehicle_log.save
      render none, status: :created, location: @vehicle_log
    else
      render json: @vehicle_log.errors, status: :unprocessable_entity
    end
  end

  # DELETE /vehicle_logs/1
  # DELETE /vehicle_logs/1.json
  def destroy
    @vehicle_log.destroy
    respond_to do |format|
      format.html { redirect_to vehicle_logs_url }
      format.json { head :no_content }
    end
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
end
