include AdminUsersHelper
ActiveAdmin.register AdminUser, :as => "User" do     
    
    scope :all, :default => true
    scope :active
    scope :inactive
    
    filter :email
    filter :group_id, :as => :select, :collection => Group.all.collect { |o| [o.name, o.id] }
    
    index do                            
        column :email                     
        column :current_sign_in_at        
        column :last_sign_in_at           
        column :sign_in_count          
        column "Group" do |user|
            if (user.group)
                user.group.name
            else
                "Not set"
            end
        end
        
        column "State" do |user|
            status_tag(user.state)
        end
        
        column :actions do |resource|
            links = ''.html_safe
            links << link_to(I18n.t('active_admin.view'), resource_path(resource), :class => "member_link view_link")
            if (current_admin_user.admin? || resource.id = current_admin_user.id)
                links << link_to(I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link")
            end
            if (current_admin_user.admin? && resource.id != current_admin_user.id)
                if resource.inactive?
                    links << link_to("Activate", activate_admin_user_path(resource), :method => :put, :class => "member_link activate_link")
                else
                    links << link_to("Deactivate", deactivate_admin_user_path(resource), :method => :put, :class => "member_link activate_link")
                end
                links << link_to(I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :data => {:confirm => I18n.t('active_admin.delete_confirmation')}, :class => "member_link delete_link")
            end
            links
        end
        
        store_location
    end                                 
    
    PRIVILEGE_ALERT = "You do not have enough privilege to do this action"
    UNASSIGNED_GROUP_ALERT = "Please assign this user to a group before changing its state"
    
    member_action :activate, :method => :put do
        if current_admin_user.admin?
            user = AdminUser.find(params[:id])
            if user.activate
                redirect_back_or({:action => :index}, {:notice => "Successfully activated user #{user.email}"})
            else
                redirect_back_or({:action => :index}, {:alert => user.errors.full_messages})
            end
        else
            redirect_back_or({:action => :index}, {:alert => PRIVILEGE_ALERT})
        end
    end
    
    member_action :deactivate, :method => :put do
        if current_admin_user.admin?
            user = AdminUser.find(params[:id])
            if user != current_admin_user
                if user.deactivate
                    redirect_back_or({:action => :index}, {:notice => "Successfully deactivated user #{user.email}"})
                else
                    redirect_back_or({:action => :index}, {:alert => user.errors.full_messages})
                end
            else
                redirect_back_or({:action => :index}, {:alert => "Cannot deactivated current login user"})
            end
        else
            redirect_back_or({:action => :index}, {:alert => PRIVILEGE_ALERT})
        end
    end

    form do |f|                         
        f.inputs "User Details" do       
        f.input :email, :input_html => { :disabled => (!current_admin_user.admin? || current_admin_user.id == f.object.id) }
        f.input :group_id, :collection => Group.all, :as => :select
        f.input :manager
        f.input :state, :as => :select, :collection => [['Active', 'active'], ['Inactive', 'inactive']], :include_blank => false
        f.input :password               
        f.input :password_confirmation
        end                               
        f.actions                         
    end
    
    show do |user|
        attributes_table do
            row :email
            row :sign_in_count
            row :current_sign_in_at
            row :last_sign_in_at
            row :state do
                status_tag(user.state)
            end
            row "Group Manager" do
                if user.manager?
                    "Yes"
                else
                    "No"
                end
            end
            row :group
        end
        active_admin_comments
    end
    controller do
        def update_resource(object, attributes)
            # Detect update method based on password existence
            update_method = attributes.first[:password].present? ? :update_attributes : :update_without_password

            # Send email to user if it is activated through this method
            if (attributes.first[:state] == 'active' && object.state == 'inactive')
                UserMailer.activated(object).deliver
            end
            
            # Send update message
            object.send(update_method, *attributes)
        end
        
        def action_methods
            # Remove unnecessary action based on user's roles
            if (current_admin_user && current_admin_user.admin?)
                super
            else
                super - ['new', 'destroy', 'create']
            end
        end
    end
end                                   
