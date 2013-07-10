ActiveAdmin.register_page "Summary" do
	
	content do
		render 'test'
	end
	
	controller do
		def index(options={}, &block)
			@type = report.type
			if @type == 1
      			@report = Report.find(:all, 
                            :order => 'time DESC',
                            :conditions => 'week =' +  Time.now.strftime('%W') + ' AND year = ' + Time.now.strftime('%Y') + ' AND user_id = ' + @user_id )

    		elsif @type == 2	
       			@report = Report.find(:all, 
                            :order => 'time DESC',
                            :conditions => 'month =' +  Time.now.strftime('%m') + ' AND year = ' + Time.now.strftime('%Y') + ' AND user_id = ' + @user_id )

    		else
       			@report = Report.find(:all, 
                            :order => 'time DESC',
                            :conditions => 'year =' +  Time.now.strftime('%Y') + ' AND user_id = ' + @user_id )
    		end

      		respond_to do |format|
        		format.html # viewlist.html.erb
        		format.json { render json: @report }
      		end
			super
		end
	end
end