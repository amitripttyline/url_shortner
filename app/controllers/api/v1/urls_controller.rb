module Api
  module V1
    class UrlsController < ApplicationController
      before_action :authenticate_token!

      def create
        url = Url.new(original_url: params[:original_url])
        if url.save
          render json: { short_url: short_url(url.short_url) }, status: :created
        else
          render json: { errors: url.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def authenticate_token!
        token = request.headers['Authorization'].to_s.split(' ').last
        unless Url.exists?(token: token)
          render json: { error: "Unauthorized" }, status: :unauthorized
        end
      end

      def short_url(code)
        "#{request.base_url}/#{code}"
      end
    end
  end
end
