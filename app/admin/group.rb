ActiveAdmin.register Group do     
    index do                            
        column :name                     
        column "Type" do |group|
            if group.admin?
                "Administrators"
            else
                "Common"
            end
        end
        
        column :actions do |resource|
            links = ''.html_safe
            links << link_to(I18n.t('active_admin.view'), resource_path(resource), :class => "member_link view_link")
            if (current_admin_user.admin?)
                links << link_to(I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link")
                if (current_admin_user.group != resource)
                    links << link_to(I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :data => {:confirm => I18n.t('active_admin.delete_group_confirmation')}, :class => "member_link delete_link")
                end
            end
            links
        end
                            
    end                                 

    filter :admin                     

    form do |f|                         
        f.inputs "Group Details" do       
        f.input :name
        f.input :admin, :input_html => { :disabled => true }
        end                               
        f.actions                         
    end
    controller do        
        def action_methods
            # Remove unnecessary action based on user's roles
            if (current_admin_user && current_admin_user.admin?)
                super
            else
                super - ['new', 'edit', 'destroy', 'update', 'create']
            end
        end
        
        def destroy(options={}, &block)
            # Do not allow admin to delete its group
            if (current_admin_user.group_id != resource.id)
                super
            else
                options[:location] ||= smart_collection_url
                respond_with_dual_blocks(resource, options, &block)
            end          
        end
    end
end                                   
 
