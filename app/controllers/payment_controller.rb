class PaymentController < ApplicationController
  before_action :authenticate
  def topup
  	user = User.find(params[:user_id])
  	user.quota += params[:amount].to_i
  	user.save
  	redirect_to user_path(id: params[:user_id])
    return
  end

  private
  	def authenticate
  	  unless (session[:user_id] == params[:user_id].to_i) or session[:isAdmin]
        AdminLog.create(alert_type: 2, message: "Someone failed to authenticate [#{request.remote_ip}]", from: "payment#authenticate")
  	  	  puts "userid: #{session[:user_id]}, #{params[:user_id]}"
        render(file: 'public/401.html', status: :unauthorized) and return
      end
  	end
end