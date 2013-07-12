require 'rubygems'
require 'rake'
require 'rufus/scheduler'
scheduler = Rufus::Scheduler.start_new
scheduler.cron '00 17 * * 1-5' do
  puts 'activate security system'
  ReportMailer.notify_managers.deliver
end
