class Admin::UsersController < ApplicationController

	layout 'admin/application'

	before_action :remove_password, only: [:update]

	before_action :has_access?

  def index
  	@users = User.all.paginate(page: params[:page], per_page: 10)
  end

  def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save!
			redirect_to admin_users_path, notice: "Successfully created a new User"
		else
			render action: "new"
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			redirect_to admin_users_path, notice: "Successfully update User"
		else
			render action: "edit"
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to admin_users_path, notice: "Successfully deleted User"
	end

	private

	def user_params
		params[:user].permit(:first_name, :last_name, :city, :email, :mobile_number, :password, :password_confirmation)
	end

	def remove_password
		if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
			params[:user].delete("password")
			params[:user].delete("password_confirmation")
		end
	end

	def has_access?
		if current_user and current_user.has_role? :super_admin

		else
			redirect_to root_url
		end
	end
end
