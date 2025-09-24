class UrlsController < ApplicationController
  def index
    @urls = Url.all
  end

  def new
  @url = Url.new
  @urls = Url.all
  end

  def create
    @url = Url.new(url_params)
    if @url.save
      redirect_to @url, notice: "Short URL created!"
    else
      redirect_to new_url_path, alert: @url.errors.full_messages.to_sentence
    end
  end

  def show
    @url = Url.find(params[:id])
  end

  def redirect
    url = Url.find_by(short_url: params[:short_url])
    if url.nil?
      render plain: "URL not found", status: :not_found
      return
    end
    if url.can_be_clicked?
      url.increment!(:click_count)
      redirect_to url.original_url, allow_other_host: true
    else
      render plain: "This short URL has reached its maximum allowed clicks.", status: :forbidden
    end
  end

  def sample
    # This is a sample view for the long route
  end

  private

  def url_params
    params.require(:url).permit(:original_url, :max_click)
  end
end
