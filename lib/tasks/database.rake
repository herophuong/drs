namespace :db do
    desc "Create default admin user and group"
    task :initadmin => :environment do
        g = Group.create(name: "Administrator")
        g.admin = true
        g.save
        
        u = AdminUser.create(email: "drsprj@gmail.com", password: "drsprj1234", password_confirmation: "drsprj1234", group_id: g.id)
        u.activate
    end
end 
