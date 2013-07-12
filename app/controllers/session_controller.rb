class SessionController < ApplicationController
	def new
		render :check_login if logged_in?
	end

	def login
		unless logged_in?
			params = session_params
			puts "Params: #{params}"
			user = User.find_by(username: params[:username])
			puts "User: #{user.username}"
			if user && user.authenticate(params[:password])
				puts "Authenticated"
				session[:user_id] = user.id
			end
		end
		render :check_login
	end

	def logout
		session[:user_id] = nil
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
			session[:user_id] != nil
		end
end
