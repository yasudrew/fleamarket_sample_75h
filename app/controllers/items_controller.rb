class ItemsController < ApplicationController
  def index
  end

  def new
    render layout: 'sub_application'
  end

  def show
  end

  def parchase_confirmation
    render layout: 'sub_application'
  end
end
