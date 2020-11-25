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
    the_appointment.start_date = params.fetch("query_start_date")
    the_appointment.end_date = params.fetch("query_end_date")
    the_appointment.dog_id = params.fetch("query_dog_id")
    # appt_dog_name = params.fetch("query_dog_name")

    # matching_dogs = Dog.where({ :name => appt_dog_name}).at(0)
    # matching_dogs_id = matching_dogs.id

    # the_appointment.dog_watcher_id = params.fetch("query_dog_watcher_id")
    # the_appointment.points_earned = params.fetch("query_points_earned")

    if the_appointment.valid?
      the_appointment.save
      redirect_to("/appointments", { :notice => "Appointment created successfully." })
    else
      redirect_to("/appointments", { :notice => "Appointment failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_appointment = Appointment.where({ :id => the_id }).at(0)

    the_appointment.start_date = params.fetch("query_start_date")
    the_appointment.end_date = params.fetch("query_end_date")
    the_appointment.dog_id = params.fetch("query_dog_id")
    the_appointment.dog_watcher_id = params.fetch("query_dog_watcher_id")
    the_appointment.points_earned = params.fetch("query_points_earned")

    if the_appointment.valid?
      the_appointment.save
      redirect_to("/appointments/#{the_appointment.id}", { :notice => "Appointment updated successfully."} )
    else
      redirect_to("/appointments/#{the_appointment.id}", { :alert => "Appointment failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_appointment = Appointment.where({ :id => the_id }).at(0)

    the_appointment.destroy

    redirect_to("/appointments", { :notice => "Appointment deleted successfully."} )
  end
end
