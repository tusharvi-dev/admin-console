class Admin::RolesController < ApplicationController
    layout 'admin'

  before_action :has_access?

  def index
    @roles = Role.all.paginate(page: params[:page], per_page: 10)
  end

  def show
    @role = Role.find(params[:id])
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    if @role.save!
      redirect_to admin_roles_path, notice: "Successfully created a new Role"
    else
      render action: "new"
    end
  end

  def edit
    @role = Role.find(params[:id])
  end

  def update
    @role = Role.find(params[:id])
    if @role.update_attributes(role_params)
      redirect_to admin_roles_path, notice: "Successfully update Role"
    else
      render action: "edit"
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy
    redirect_to admin_roles_path, notice: "Successfully deleted Role"
  end

  private

  def role_params
    params[:role].permit(:name)
  end

  def has_access?
    if current_user and current_user.has_role? :super_admin

    else
      redirect_to root_url
    end
  end
end
