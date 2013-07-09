FactoryGirl.define do
    factory :admin_user do
        sequence(:email) { |n| "person_#{n}@framgia.com" }
        password    "foobarraboof"
        password_confirmation "foobarraboof"
        
        after_build { |admin_user| admin_user.send(:initialize_state_machines, :dynamic => :force)}
        group
        factory :user_manager do
            manager true
        end
    end
    
    factory :group do
        sequence(:name) { |n| "Group #{n}" }
        
        factory :admin_group do
            admin true
        end
    end
    
    factory :report do
        content "Lorem Ipsum"
#         reporttype
#         user
    end
    
    factory :report_type do
        title "Lorem Ipsum"
        guide "Lorem Ipsum"
    end
end