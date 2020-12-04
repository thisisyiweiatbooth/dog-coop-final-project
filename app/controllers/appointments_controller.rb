class AppointmentsController < ApplicationController
  def index
    matching_appointments = Appointment.all

    @list_of_appointments = matching_appointments.order({ :created_at => :desc })

    render({ :template => "appointments/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_appointments = Appointment.where({ :id => the_id })

    @the_appointment = matching_appointments.at(0)

    render({ :template => "appointments/show.html.erb" })
  end

  def create
    the_appointment = Appointment.new
    the_appointment.start_date = params["query_start_date"]
    the_appointment.end_date = params["query_end_date"]
    the_appointment.dog_id = params["query_dog_id"]
  
    if params["query_start_date"] == nil || params["query_end_date"] == nil 
      redirect_to("/appointments", { :alert => "Appointment request failed to create successfully. Make sure you have selected a start date, end date, and a dog to be watched." })
    elsif the_appointment.valid?
      the_appointment.save
      redirect_to("/appointments", { :notice => "Appointment request created successfully." })
    else
      redirect_to("/appointments", { :alert => "Appointment request failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_appointment = Appointment.where({ :id => the_id }).at(0)

    the_appointment.start_date = params.fetch("query_start_date")
    the_appointment.end_date = params.fetch("query_end_date")
    the_appointment.dog_id = params.fetch("query_dog_id")


    if the_appointment.valid?
      the_appointment.save
      redirect_to("/appointments/#{the_appointment.id}", { :notice => "Appointment request updated successfully."} )
    else
      redirect_to("/appointments/#{the_appointment.id}", { :alert => "Appointment request failed to update successfully. Make sure you have selected a start date, end date, and a dog to be watched." })
    end
  end

  def signup_to_watch
    the_id = params.fetch("path_id")
    the_appointment = Appointment.where({ :id => the_id }).at(0)
    the_appointment.dog_watcher_id = @current_homo_sapien.id

    if the_appointment.valid?
      the_appointment.save
      redirect_to("/appointments/#{the_appointment.id}", { :notice => "Thank you for helping to watch #{the_appointment.dog.name}!"} )
    else
      redirect_to("/appointments/#{the_appointment.id}", { :alert => "Appointment failed to update successfully." })
    end
  end

  def cancel_watch
    the_id = params.fetch("path_id")
    the_appointment = Appointment.where({ :id => the_id }).at(0)
    the_appointment.dog_watcher_id = nil

    if the_appointment.valid?
      the_appointment.save
      redirect_to("/appointments/#{the_appointment.id}", { :notice => "Your watch has been successfully cancelled. Thanks for trying to help."} )
    else
      redirect_to("/appointments/#{the_appointment.id}", { :alert => "Appointment failed to cancel." })
    end
  end


  def destroy
    the_id = params.fetch("path_id")
    the_appointment = Appointment.where({ :id => the_id }).at(0)

    the_appointment.destroy

    redirect_to("/appointments", { :notice => "Appointment deleted successfully."} )
  end
end
