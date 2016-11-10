class Admin::DashboardController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  def home
  end
  def tables
  end
end