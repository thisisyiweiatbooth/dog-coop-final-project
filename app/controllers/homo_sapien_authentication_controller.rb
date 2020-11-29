class HomoSapienAuthenticationController < ApplicationController
  # Uncomment this if you want to force homo_sapiens to sign in before any other actions
  # skip_before_action(:force_homo_sapien_sign_in, { :only => [:sign_up_form, :create, :sign_in_form, :create_cookie] })

  def sign_in_form
    render({ :template => "homo_sapien_authentication/sign_in.html.erb" })
  end

  def create_cookie
    homo_sapien = HomoSapien.where({ :email => params.fetch("query_email") }).first
    
    the_supplied_password = params.fetch("query_password")
    
    if homo_sapien != nil
      are_they_legit = homo_sapien.authenticate(the_supplied_password)
    
      if are_they_legit == false
        redirect_to("/homo_sapien_sign_in", { :alert => "Incorrect password." })
      else
        session[:homo_sapien_id] = homo_sapien.id
      
        redirect_to("/", { :notice => "Signed in successfully." })
      end
    else
      redirect_to("/homo_sapien_sign_in", { :alert => "No homo_sapien with that email address." })
    end
  end

  def destroy_cookies
    reset_session

    redirect_to("/", { :notice => "Signed out successfully." })
  end

  def sign_up_form
    render({ :template => "homo_sapien_authentication/sign_up.html.erb" })
  end

  def create
    @homo_sapien = HomoSapien.new
    @homo_sapien.email = params.fetch("query_email")
    @homo_sapien.password = params.fetch("query_password")
    @homo_sapien.password_confirmation = params.fetch("query_password_confirmation")
    @homo_sapien.username = params.fetch("query_username")
    # @homo_sapien.net_points = params.fetch("query_net_points")
    # @homo_sapien.dogs_count = params.fetch("query_dogs_count")
    # @homo_sapien.appointments_count = params.fetch("query_appointments_count")

    save_status = @homo_sapien.save

    if save_status == true
      session[:homo_sapien_id] = @homo_sapien.id
   
      redirect_to("/", { :notice => "Homo sapien account created successfully."})
    else
      redirect_to("/homo_sapien_sign_up", { :alert => "Homo sapien account failed to create successfully."})
    end
  end
    
  def edit_profile_form
    render({ :template => "homo_sapien_authentication/edit_profile.html.erb" })
  end

  def update
    @homo_sapien = @current_homo_sapien
    @homo_sapien.email = params.fetch("query_email")
    @homo_sapien.password = params.fetch("query_password")
    @homo_sapien.password_confirmation = params.fetch("query_password_confirmation")
    @homo_sapien.username = params.fetch("query_username")
    # @homo_sapien.net_points = params.fetch("query_net_points")
    # @homo_sapien.dogs_count = params.fetch("query_dogs_count")
    # @homo_sapien.appointments_count = params.fetch("query_appointments_count")
    
    if @homo_sapien.valid?
      @homo_sapien.save

      redirect_to("/", { :notice => "Homo sapien account updated successfully."})
    else
      render({ :template => "homo_sapien_authentication/edit_profile_with_errors.html.erb" })
    end
  end

  def destroy
    @current_homo_sapien.destroy
    reset_session
    
    redirect_to("/", { :notice => "HomoSapien account cancelled" })
  end
 
end
