class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    admin_posts(resource)
  end
  
  def after_sign_up_path_for(resource)
    root_path(resource)
  end
  
  def after_sign_in_path_for(resource)
    root_path(resource)
    
  
end
