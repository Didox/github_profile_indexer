class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show edit update destroy rescan]

  def index
    @profiles = Profile.all
  end

  def show
  end

  def new
    @profile = Profile.new
  end

  def edit
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      scrape_and_update_profile(@profile)
      redirect_to @profile, notice: 'Perfil criado com sucesso.'
    else
      render :new
    end
  end

  def update
    if @profile.update(profile_params)
      scrape_and_update_profile(@profile)
      redirect_to @profile, notice: 'Perfil atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @profile.destroy
    redirect_to profiles_url, notice: 'Perfil excluído com sucesso.'
  end

  def rescan
    scrape_and_update_profile(@profile)
    redirect_to @profile, notice: 'Perfil rescanado com sucesso.'
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:name, :github_url)
  end


  def scrape_and_update_profile(profile)
    scraper = GithubScraper.new(profile.github_url)
    scraped_data = scraper.scrape
    if profile.profile_info.present?
      profile.profile_info.update(scraped_data)
    else
      profile.create_profile_info(scraped_data)
    end
  end
end
