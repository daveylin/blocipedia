class UsersController < ApplicationController
  def downgrade
    @user = current_user
    @user.role = "standard"
    @user.save!
    
    flash[:notice] = "Your account has been downgraded successfully."
    redirect_to edit_user_registration_path 
  end
end