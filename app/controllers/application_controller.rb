class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    load_and_authorize_resource
    before_action :authenticate_user!


    rescue_from CanCan::AccessDenied do |exception|
      redirect_to request.referer
      flash[:danger] = "Sorry, you're not authorized to perform this action!" 
    end

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:fname, :lname, :phone, :birth_date])
    end

    def self.permission
      return name = self.name.gsub('Controller','').singularize.split('::').last.constantize.name rescue nil
    end
   
    def current_ability
      @current_ability ||= Ability.new(current_user)
    end
   
    #load the permissions for the current user so that UI can be manipulated
    def load_permissions
      @current_permissions = current_user.role.permissions.collect{|i| [i.subject_class, i.action]}
    end
end
