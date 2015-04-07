class IpsController < ApplicationController
  def index
    @ip = Ip.new(os: 'debian')
    render :debian
  end

  def create
    @ip = Ip.new(params[:ip])
    render @ip.os
  end

  def debian
    @ip = Ip.new(os: 'debian')
  end

  def centos
    @ip = Ip.new(os: 'centos')
  end

end
