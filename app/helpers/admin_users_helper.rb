module AdminUsersHelper 
    def redirect_back_or(default, messages = nil)
        redirect_to(session[:return_to] || default, messages)
        session.delete(:return_to)
    end
    
    def store_location
        session[:return_to] = request.fullpath
    end
end
