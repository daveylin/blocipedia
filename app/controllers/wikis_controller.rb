class WikisController < ApplicationController
  def index
    #@wikis = Wiki.all #Wiki.visible_to(current_user)
    @user = current_user
    @wikis = policy_scope(Wiki)
    #authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body, :private))
    @user = current_user
    @wiki.user_id = @user.id
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end
  
  def edit
    @wiki = Wiki.find(params[:id])
    @users = User.all
    #@collaborators = Collaborator.new
    @collaborator = Collaborator.new
  end
  
   def update
     @wiki = Wiki.find(params[:id])
     if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :private))
       flash[:notice] = "Wiki was updated."
       redirect_to @wiki
     else
       flash[:error] = "There was an error saving the wiki. Please try again."
       render :edit
     end
   end

  def destroy
    @wiki = Wiki.find(params[:id])
 
    if @wiki.destroy
      flash[:notice] = "Item was deleted successfully."
      redirect_to [@wiki], notice: "Item was deleted successfully."
     else
      flash[:error] = "There was an error deleting the item. Please try again."
     end
    
  end
  
  private
  
  def collaborator_params
    params.require(:collaborator).permit(:wiki_id, :user_id)
  end
end
