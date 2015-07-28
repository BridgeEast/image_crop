class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def destroy
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(avatar_params)
      redirect_to users_path
    else
      render :new
    end
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html {
          if params[:user][:avatar].present?
            if @user.update_attributes(avatar_params)
              redirect_to users_path
            end  ## Render the view for cropping
          else
            redirect_to @user, notice: 'User was successfully created.'
          end
        }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h, :avatar)
  end
  def avatar_params
    params.require(:user).permit(:avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h)
  end
end
