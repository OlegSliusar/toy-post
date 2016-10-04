class MicropostsController < ApplicationController
  before_action :set_micropost, only: [:show, :edit, :update, :destroy]

  def index
    @microposts = Micropost.all
    @micropost = Micropost.new
  end

  def show
    @users = User.all
    @user = User.find(@micropost.user_id)
  end

  def new
  end

  def edit
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    respond_to do |format|
      if @micropost.save
        flash[:success] = "Micropost was successfully created."
        format.html { redirect_to :back }
        format.json { render :show, status: :created,
          location: @micropost }
      else
        format.json { render json: @micropost.errors,
          status: :unprocessable_entity }
          format.html { redirect_to :back }
      end
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
    respond_to do |format|
      format.html { redirect_to User.find(@micropost.user_id),
        notice: 'Micropost was successfully destroyed.' }
      format.json { head :no_content }
    end
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
end
