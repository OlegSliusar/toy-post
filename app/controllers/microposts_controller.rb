class MicropostsController < ApplicationController
  before_action :set_micropost,  only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update, :create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    @microposts = Micropost.all
    @micropost = current_user.microposts.build if logged_in?
  end

  def show
    @user = User.find(@micropost.user_id)
  end

  def edit
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Post was successfully created."
      redirect_to request.referrer || root_url
    else
      flash[:danger] = "Post can't be blank and should have no more than 240 characters."
      redirect_to request.referrer || root_url
    end
  end

  def update
    respond_to do |format|
      if @micropost.update(micropost_params)
        flash[:success] = "Micropost was successfully updated."
        format.html { redirect_to @micropost }
        format.json { render :show, status: :ok,
          location: @micropost }
      else
        format.html { render :edit }
        format.json { render json: @micropost.errors,
          status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost was successfully destroyed."
    redirect_to request.referrer || root_url
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_micropost
      @micropost = Micropost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      unless current_user.admin?
        @micropost = current_user.microposts.find_by(id: params[:id])
        redirect_to root_url if @micropost.nil?
      end
    end
end
