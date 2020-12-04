class DogsController < ApplicationController
  def index
    matching_dogs = Dog.all

    @list_of_dogs = matching_dogs.order({ :created_at => :desc })

    render({ :template => "dogs/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_dogs = Dog.where({ :id => the_id })

    @the_dog = matching_dogs.at(0)

    render({ :template => "dogs/show.html.erb" })
  end

  def create
    the_dog = Dog.new
    the_dog.name = params["query_name"]
    the_dog.owner_id = @current_homo_sapien.id
    the_dog.photo = params[:photo]

  if params["query_name"] == nil || params[:photo] == nil
    redirect_to("/dogs", { :alert => "Dog failed to create successfully. You must include a name and a photo." })
    
    elsif the_dog.valid?
      the_dog.save
      redirect_to("/dogs", { :notice => "Dog created successfully." })
    else
      redirect_to("/dogs", { :alert => "Dog failed to create successfully. You must include a name and a photo." })
    end
  end



  def update
    the_id = params.fetch("path_id")
    the_dog = Dog.where({ :id => the_id }).at(0)

    the_dog.name = params.fetch("query_name")
    the_dog.photo = params[:photo]

    if params[:photo] == nil
      p the_dog.errors.full_messages
      redirect_to("/dogs/#{the_dog.id}", { :alert => "Dog failed to update successfully. Make sure both the Name and Photo fields are completed." })

    elsif the_dog.valid?   
      the_dog.save
      redirect_to("/dogs/#{the_dog.id}", { :notice => "Dog updated successfully."} )
    else
      p the_dog.errors.full_messages
      redirect_to("/dogs/#{the_dog.id}", { :alert => "Dog failed to update successfully. Make sure both the Name and Photo fields are completed." })
    end
  end

  

  def destroy
    the_id = params.fetch("path_id")
    the_dog = Dog.where({ :id => the_id }).at(0)

    the_dog.destroy

    redirect_to("/dogs", { :notice => "Dog deleted successfully."} )
  end
end
