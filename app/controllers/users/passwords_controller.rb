class Users::PasswordsController < Devise::PasswordsController
  def create
    if !verify_recaptcha
      flash.delete :recaptcha_error
      build_resource
      # resource.valid?  #removed because it was causing unrelated build errors
      resource.errors.add(:base, "There was an error with the recaptcha code below. Please re-enter the code.")
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render_with_scope :new }
    else
      flash.delete :recaptcha_error
      super
    end
  end
  
  def clean_up_passwords(*args)
    # Delete or comment out this method to prevent the password fields from 
    # repopulating after a failed registration
  end
end