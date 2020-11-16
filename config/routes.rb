Rails.application.routes.draw do


  get("/", { :controller => "application", :action => "index"})

  # Routes for the Appointment resource:

  # CREATE
  post("/insert_appointment", { :controller => "appointments", :action => "create" })
          
  # READ
  get("/appointments", { :controller => "appointments", :action => "index" })
  
  get("/appointments/:path_id", { :controller => "appointments", :action => "show" })
  
  # UPDATE
  
  post("/modify_appointment/:path_id", { :controller => "appointments", :action => "update" })
  
  # DELETE
  get("/delete_appointment/:path_id", { :controller => "appointments", :action => "destroy" })

  #------------------------------

  # Routes for the Dog resource:

  # CREATE
  post("/insert_dog", { :controller => "dogs", :action => "create" })
          
  # READ
  get("/dogs", { :controller => "dogs", :action => "index" })
  
  get("/dogs/:path_id", { :controller => "dogs", :action => "show" })
  
  # UPDATE
  
  post("/modify_dog/:path_id", { :controller => "dogs", :action => "update" })
  
  # DELETE
  get("/delete_dog/:path_id", { :controller => "dogs", :action => "destroy" })

  #------------------------------

  # Routes for the Homo sapien account:

  # SIGN UP FORM
  get("/homo_sapien_sign_up", { :controller => "homo_sapien_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_homo_sapien", { :controller => "homo_sapien_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_homo_sapien_profile", { :controller => "homo_sapien_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_homo_sapien", { :controller => "homo_sapien_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_homo_sapien_account", { :controller => "homo_sapien_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/homo_sapien_sign_in", { :controller => "homo_sapien_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/homo_sapien_verify_credentials", { :controller => "homo_sapien_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/homo_sapien_sign_out", { :controller => "homo_sapien_authentication", :action => "destroy_cookies" })
             
  #------------------------------

end
