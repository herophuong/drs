ActiveAdmin.register Report, :as => "Summary" do     
    menu :if => proc{current_admin_user.manager?}
    xlsx(:header_style => {:bg_color => 'FF0000', :fg_color => 'FF' }) do

      # deleting columns from the report
      delete_columns :id, :created_at, :updated_at, :content, :year, :day, :week, :month, :fileLink
  
      # adding a column to the report
      ReportTitle.all.each do |report_title|
        column(report_title.title) do |resource|
            if resource.report_title_id == report_title.id
              "#{resource.content}"
            end
        end
    end
end
  index do                            
    column :report_title
    column "Content" do |report|
      simple_format report.content
    end
    column :fileLink
    column :time
    column :admin_user

      
    default_actions                   
  end                                 

    scope "Default", :default => true do |report|
          report.order('time DESC')
          report.where(:group_id => current_admin_user.group_id)

        end
  scope :Week do |report|
          report.order('time DESC')
          report.where(:week => Time.now.strftime('%W').to_i, :year => Time.now.strftime('%Y').to_i,:group_id => current_admin_user.group_id)
        end
  scope :Month do |report|
          report.order('time DESC')
          report.where(:month => Time.now.strftime('%m').to_i, :year => Time.now.strftime('%Y').to_i, :group_id => current_admin_user.group_id)
        end
  scope :Year do |report|
          report.order('time DESC')
          report.where(:year => Time.now.strftime('%Y').to_i, :group_id => current_admin_user.group_id)
        end

  filter :admin_user, :collection => proc { AdminUser.where(:group_id => current_admin_user.group_id).map{|u| [u.email, u.id]}}

  form do |f|                         
    f.inputs "Report" do
      
      f.input :report_title
      f.input :content, :input_html => { :class => 'tinymce', :width =>'940px' }, :as => :text
      f.input :fileLink
    end                               
    f.actions                         
  end
  
  # index :download_links => proc { 
    # if current_admin_user.manager?
      # [:csv, :xml, :json, :xlsx]
    # else
      # false
    # end
  # }

  controller do
    def create(options={}, &block)
      object = build_resource
      object.admin_user_id = current_admin_user.id

      if create_resource(object)
        options[:location] ||= smart_resource_url
      end

      respond_with_dual_blocks(object, options, &block)
    end
   
    def action_methods
        # Remove unnecessary action based on user's roles
        if(current_admin_user && current_admin_user.manager?)
          ['show', 'index', 'destroy']
        else
          ['index']
        end
    end
    
    def index(options = {}, &block)
      if current_admin_user.manager?
        super
      else
        redirect_to admin_root_path
      end
    end
  end                                 
end  