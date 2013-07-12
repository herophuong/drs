class ReportMailer < ActionMailer::Base
    default from: "drsprj@gmail.com"
    
    def notify_managers
        groups = Group.all
        groups.each do |group|
          managers = group.managers
          @group = group
          @links = group.summarize
          managers.each do |manager|
            mail(to: manager.email, subject: "Daily Report " + Time.now.strftime('%d-%m-%Y'))    
          end
        end
        #mail(to: "sonnguyenhoang2309@gmail.com", subject: "You are manager")
    end
end