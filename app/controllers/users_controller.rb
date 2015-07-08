class UsersController < ApplicationController
  def downgrade
    @user = current_user
    @user.role = "standard"
    @user.save!
    
    @wikis = Wiki.where(private: true, user_id: @user.id)
    #binding.pry
    @wikis.each do |wiki|
      wiki.private = false
      wiki.save! 
    end
    
    flash[:notice] = "Your account has been downgraded successfully."
    redirect_to edit_user_registration_path 
  end
end