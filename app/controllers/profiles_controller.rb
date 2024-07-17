class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show edit update destroy rescan]

  def index
    @profiles = Profile.page(params[:page]).per(5)
  end

  def search
    @profiles = Profile.where('name LIKE ?', "%#{params[:q]}%").page(params[:page]).per(5)
    render :index
  end

  def show
  end

  def new
    @profile = Profile.new
  end

  def edit
  end

  def create
    @profile = ProfileService.save(profile_params)
    if @profile.errors.blank?
      redirect_to @profile, notice: t('flash.profiles.create.success')
    else
      flash.now[:alert] = t('flash.profiles.create.error')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if ProfileService.update(@profile, profile_params)
      redirect_to @profile, notice: t('flash.profiles.update.success')
    else
      flash.now[:alert] = t('flash.profiles.update.error')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @profile.destroy
    redirect_to profiles_url, notice: t('flash.profiles.destroy.success')
  end

  def rescan
    ProfileService.new(@profile).scraper!
    redirect_to @profile, notice: t('flash.profiles.rescan.success')
  rescue StandardError => e
    @profile = ProfileService.error_profile(@profile, e)
    flash.now[:alert] = t('flash.profiles.rescan.error')
    render :edit, status: :unprocessable_entity
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:name, :github_url)
  end
end
