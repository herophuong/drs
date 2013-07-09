class RegistrationsController < Devise::RegistrationsController
    def create
        admin_user = params["admin_user"]
        if (!admin_user.has_key?('password') && !admin_user.has_key?('password_confirmation'))
            admin_user["password"] = admin_user["password_confirmation"] = Devise.friendly_token.first(8)
        end
        
        # Technically copied from super()
        build_resource

        if resource.save
            if resource.active_for_authentication?
                set_flash_message :notice, :signed_up if is_navigational_format?
                sign_up(resource_name, resource)
                respond_with resource, :location => after_sign_up_path_for(resource)
            else
                set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
                expire_session_data_after_sign_in!
                respond_with resource, :location => after_inactive_sign_up_path_for(resource)
            end
            
            # Send email to user
            RegistrationMailer.welcome(resource, admin_user["password"]).deliver
            RegistrationMailer.notify_admins(resource).deliver
        else
            clean_up_passwords resource
            respond_with resource
        end
    end
    
    def after_inactive_sign_up_path_for(resource)
        new_admin_user_session_path
    end
end
