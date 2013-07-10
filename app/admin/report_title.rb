ActiveAdmin.register ReportTitle do     
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
end  