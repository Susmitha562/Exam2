class UsersController < ApplicationController
   before_action :authenticate_user!
  # before_action :doorkeeper_authorize! # Requires access token for all actions
  
  def index
    @users = User.all
  end

  def create
    @user = User.new(first_name: params[:user][:first_name], last_name: params[:user][:last_name], email: params[:user][:email])
    @user.password = "test1234"
    @user.password_confirmation = "test1234"
    @user.date_if_birth = params[:user][:date_if_birth]
    if @user.valid?

      @user.save
      flash[:notice] = 'Successfully created a new post!'
      redirect_to root_path
    else
      puts @user.errors.full_messages
      flash[:alert] = 'Something went wrong...'
      render :new
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
  end

  def delete
  end

  def show
    @user = User.find(params[:id])
  end

  private 

  def user_params 
    params.permit(:first_name, :last_name, :email, :date_if_birth)
  end
end
