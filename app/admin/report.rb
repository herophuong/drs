ActiveAdmin.register Report do    
  index do                            
    column :report_title_id
    column "Content" do |report|
      simple_format report.content
    end
    column "Attachment link" do |report|
      link_to report.document_file_name, report.document.url(:original)
    end
    column :time
    column :admin_user

      
    default_actions                   
  end                                 

  scope "Default", :default => true do |report|
          report.order('time DESC')
          report.where(:admin_user_id => current_admin_user.id)

        end
  filter :time#, :as => :string                   

  form do |f|                         
    f.inputs "Report" do
      
      f.input :report_title
      f.input :content, :input_html => { :class => 'tinymce', :width =>'940px' }, :as => :text
      f.input :document  
    end

    f.actions                         
  end

  controller do
    def create(options={}, &block)
      object = build_resource
      object.admin_user_id = current_admin_user.id

      object.group_id = current_admin_user.group_id

      if create_resource(object)
        options[:location] ||= smart_resource_url
      end

      respond_with_dual_blocks(object, options, &block)
    end
    def action_methods
      super - ['destroy', 'update', 'edit']
    end
    
  end                                 
end  