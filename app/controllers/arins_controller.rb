class ArinsController < ApplicationController

  def index
    @arin = Arin.new
  end

  def create
    @arin = Arin.new(params[:arin])
    render :index
  end

end
