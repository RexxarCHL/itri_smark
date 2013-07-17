class PlatesController < ApplicationController
	before_action :set_user_plates
	before_action :authenticate

	layout "layout_with_sidebar"

	#GET /users/#{user_id}/plates
	def index
	end

	#GET /users/#{user_id}/new
	def new
		@plate ||= Plate.new
	end

	#POST /users/#{user_id}/plates
	def create
		params = plates_params
		@plate = @plates.create(plateNo: params[:plateNo])
		unless @plate.id.nil?
			redirect_to user_plates_path
		else
			render :new, status: 400
		end
	end

	#DELETE /users/#{user_id}/plates/#{plate_id}
	def destroy
		@plates.find(params[:id]).destroy
		render :index
	end

	private
		def set_user_plates
			@plates = User.find(params[:user_id]).plates
		end

		def authenticate
			unless params[:user_id].to_i == session[:user_id] || session[:isAdmin]
				render file: 'public/401.html'
				AdminLog.create(alert_type: 2, message: "Someone failed to authenticate [#{request.remote_ip}]", from: "plates#authenticate")
			end
		end

		def plates_params
			params.require(:plate).permit(:plateNo)
		end
end