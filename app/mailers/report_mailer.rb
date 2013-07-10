class ReportMailer < ActionMailer::Base
    default from: "drsprj@gmail.com"
    
    def notify_managers
        groups = Group.all
        groups.each do |group|
          managers = group.managers
          managers.each do |manager|
            mail(to: manager.email, subject: "You are manager")    
          end
        end
        #mail(to: "sonnguyenhoang2309@gmail.com", subject: "You are manager")
    end
end