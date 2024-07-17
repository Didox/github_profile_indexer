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
      redirect_to @profile, notice: 'Perfil criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if ProfileService.update(@profile, profile_params)
      redirect_to @profile, notice: 'Perfil atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @profile.destroy
    redirect_to profiles_url, notice: 'Perfil excluído com sucesso.'
  end

  def rescan
    ProfileService.new(@profile).scraper!
    redirect_to @profile, notice: 'Perfil rescanado com sucesso.'
  rescue StandardError => e
    @profile = ProfileService.error_profile(@profile, e)
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
