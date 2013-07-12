namespace :db do
    desc "Create default admin user and group"
    task populate: :environment do
       make_groups
       make_users
       make_report_titles
       make_reports
    end
end 

def make_groups
    group = Group.create!(name: "Administrator")
    group.admin = true
    group.save
    19.times do |n|
      name  = "Group #{n+1}"
      Group.create!(name: name)
    end
end

def make_users
  u = AdminUser.create(email: "drsprj@gmail.com", password: "drsprj1234", password_confirmation: "drsprj1234",manager: true, group_id: 1)
  u.activate
  19.times do |n|
    email = "manager-#{n+1}@framgia.com"
    password  = "password"
    user = AdminUser.create!(email:    email,
                 password: password,
                 password_confirmation: password,
                 group_id: n%20+1,
                 manager: true)
    user.state = "active"
    user.save
  end
  40.times do |n|
    email = "example-#{n+1}@framgia.com"
    password  = "password"
    user = AdminUser.create!(email:    email,
                 password: password,
                 password_confirmation: password,
                 group_id: n%20+1)
    user.state = "active"
    user.save
  end
  5.times do |n|
    email = "inactive-#{n+1}@framgia.com"
    password  = "password"
    user = AdminUser.create!(email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_report_titles
  6.times do |n|
    title = Faker::Lorem.sentence(1)
    guide = Faker::Lorem.sentence(5)
    ReportTitle.create!(title: title, guide: guide)
  end
end

def make_reports
  users = AdminUser.all(limit: 6)
  10.times do |n|
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.reports.create!(content: content, report_title_id: n % 6 + 1) }
  end
end