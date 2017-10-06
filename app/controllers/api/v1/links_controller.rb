module Api
  module V1
    class LinksController < ApplicationController
      def index
        links = Link.order('created_at DESC');
        render json: {status: 'SUCCESS', message: 'Loaded coupons', data: links}, status: :ok
      end

      def show
        link = Link.find(params[:id]);
        if link.nil?
          render json: { error: true, reason: "Coupon not in database" }, status: 404
        else
          render json: {status: 'SUCCESS', message: 'Loaded coupon', data: link}, status: :ok
        end
      end

      def create
        link = Link.new(link_params);
        if link.save
          render json: {status: 'SUCCESS', message: 'Saved coupon', data: link}, status: :ok
        else
          render json: {status: 'ERROR', message: 'Coupon not saved', data: link.errors}, status: :unprocessable_entity
        end
      end

      def destroy
        link = Link.find(params[:id]);
        link.destroy
        render json: {status: 'SUCCESS', message: 'Deleted coupon', data: link}, status: :ok
      end

      def update
        link = Link.find(params[:id]);
        if link.update_attributes(link_params)
          render json: {status: 'SUCCESS', message: 'Updated coupon', data: link}, status: :ok
        else
          render json: {status: 'ERROR', message: 'Coupon not updated', data: link.errors}, status: :unprocessable_entity
        end
      end

      private
        def link_params
          params.permit(:title, :url, :user_id)
        end

    end
  end
end
