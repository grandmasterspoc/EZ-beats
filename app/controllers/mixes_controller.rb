 class MixesController < ApplicationController

  layout "application"

  def new
    @mix = Mix.new
  end

  def index
    @user = current_user
    @mixes = Mix.all
  end

  def create
    @mix = Mix.create(mix_params)
    parse_songs(@mix)
    if @mix.save && user_signed_in?
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  private

  def parse_songs(mix)
    params[:mix].each do |key, value|
        mix.songs << key if value == '1'
    end
  end


  def mix_params
    params.require(:mix).permit(:name, :checked, :songs, :user_id)
  end

end
