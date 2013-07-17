class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  layout :resolve_layout
  # GET /users
  # GET /users.json
  def index
    if session[:user_id].nil?
      redirect_to check_login_path
    elsif session[:isAdmin]
      @users = User.all
    else
      redirect_to user_path(id: session[:user_id])
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    unless params[:id].to_i == session[:user_id] || session[:isAdmin]
      AdminLog.create(alert_type: 2, message: "Someone failed to authenticate [#{request.remote_ip}]", from: "users#show")
      render file: 'public/401.html', status: :unauthorized
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    params = user_params
    @user = User.new()
    @user.username = params[:username]
    @user.password = params[:passwd]

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, notice: '<strong>Success!</strong><br>You can login with your new account now'.html_safe }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new', layout: "index" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :passwd, :new_plate)
    end

    def resolve_layout
      case action_name
      when 'new'
        "index"
      else
        "layout_with_sidebar"
      end
    end
end
