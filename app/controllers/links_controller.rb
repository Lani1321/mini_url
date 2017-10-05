class LinksController < ApplicationController
  before_action :set_link, only: [:show, :shortened]
  
  def index
    @link = Link.new
    @links = Link.order(clicks: :desc).first(100)
  end

  def show
    # binding.pry
    @link.clicks += 1
    @link.save
    redirect_to @link.sanitized_url
  end

  def create
    @link = Link.new(link_params)
    @links = Link.all
    @link.sanitize
    if @link.find_duplicate.nil? 
      if @link.save
        @link.clicks += 1
        @link.save
        flash[:notice] = "Here is your shortened link:"
        render :index
      end
    else

      # TODO: should a click be added here?
      flash[:notice] = "A short link already exsists for this URL, search the 'Top 100' table below:"
      render :index
      # redirect_to shortened_path(@link.find_duplicate.short_url)
    end
  end

  private

  def set_link
    @link = Link.find_by_short_url(params[:short_url])
  end

  def link_params
    params.require(:link).permit(:full_url)
  end
end
