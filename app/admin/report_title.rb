ActiveAdmin.register ReportTitle do    
  menu :if => proc {current_admin_user.admin?} 
  index do                            
    column :title                     
    column "Guide" do |report|
      simple_format report.guide
    end
    default_actions                   
  end                                 
                 

  form do |f|                         
    f.inputs "Report Title" do       
      f.input :title
      f.input :guide, :input_html => { :class => 'tinymce', :width =>'940px' }, :as => :text
    end                               
    f.actions                         
  end   

  controller do
    def action_method
      if (current_admin_user.admin?)
        super
      else
        []
      end
    end
  end                              
end  