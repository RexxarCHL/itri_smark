class SessionController < ApplicationController
	def new
	end

	def login
		u = session[:user_id]
		unless(u.nil?)
			puts "Status: #{u}"
		else
			puts "Status: nil"
		end

		unless logged_in?
			params = session_params
			user = User.find_by(username: params[:username])
			if user && user.authenticate(params[:password])
				puts "Authenticated"
				session[:user_id] = user.id
				session[:isAdmin] = user.isAdmin
				redirect_to :check_login
			else
				AdminLog.create(alert_type: 3, message: "Someone failed to login [#{request.remote_ip}]", from: "session#login")
				puts "Not authenticated"
				flash[:alert] = "Authentication failed"
				redirect_to :login
			end
		else
			redirect_to :check_login
		end
	end

	def logout
		session.destroy
		redirect_to check_login_path
	end

	def check_login
	end

	private
		def session_params
			params.require(:session).permit(:username, :password)
		end

		def logged_in?
			!session[:user_id].nil?
		end
end
