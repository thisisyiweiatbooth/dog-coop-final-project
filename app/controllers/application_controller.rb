class ApplicationController < ActionController::Base
  before_action(:load_current_homo_sapien)
  
  # Uncomment this if you want to force homo_sapiens to sign in before any other actions
  # before_action(:force_homo_sapien_sign_in)

  require "date"

  def index
  
    render({ :template => "misc/homepage.html.erb"})
  end
  
  def load_current_homo_sapien
    the_id = session[:homo_sapien_id]
    @current_homo_sapien = HomoSapien.where({ :id => the_id }).first
  end
  
  def force_homo_sapien_sign_in
    if @current_homo_sapien == nil
      redirect_to("/homo_sapien_sign_in", { :notice => "You have to sign in first." })
    end
  end

end
