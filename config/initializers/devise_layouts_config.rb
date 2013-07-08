# Specify the layout file that should be used for each Devise controller
Drs::Application.configure do
    config.to_prepare do
        Devise::RegistrationsController.layout  "signup"
    end
end