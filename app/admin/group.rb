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
    default_actions                   
  end                                 

  filter :admin                     

  form do |f|                         
    f.inputs "Group Details" do       
      f.input :name
      f.input :admin, :input_html => { :disabled => true }
    end                               
    f.actions                         
  end                                 
end                                   
 
