# == Schema Information
#
# Table name: groups
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  admin      :boolean
#

class Group < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_many :admin_users, :dependent => :nullify, before_remove: :deactivate_user
  has_many :reports, :through => :admin_users
  
  def managers
    admin_users.find_by_sql("SELECT * FROM admin_users WHERE manager = 't'")
  end
  
  def summarize
    links = Array.new
    admin_users.each do |user|
      if user.reports.where(:day => Time.now.strftime('%j')).count != 0
        links.push({ link: "admin/summaries.xlsx?utf8=1&q[admin_user_id_eq]=#{user.id}&commit=Filter&order=id_desc", email: user.email })
      end
    end
    links
  end
  
  private
    def deactivate_user(user)
        user.deactivate
    end

end
