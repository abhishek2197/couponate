module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.order('created_at DESC');
        render json: {status: 'SUCCESS', message: 'Loaded coupons', data: users}, status: :ok
      end

      def show
        user = User.find(params[:id]);
        if user.nil?
          render json: { error: true, reason: "Coupon not in database" }, status: 404
        else
          render json: {status: 'SUCCESS', message: 'Loaded coupon', data: user}, status: :ok
        end
      end

      def create
        user = User.new(user_params);
        if user.save
          render json: {status: 'SUCCESS', message: 'Saved coupon', data: user}, status: :ok
        else
          render json: {status: 'ERROR', message: 'Coupon not saved', data: user.errors}, status: :unprocessable_entity
        end
      end

      def destroy
        user = User.find(params[:id]);
        user.destroy
        render json: {status: 'SUCCESS', message: 'Deleted coupon', data: user}, status: :ok
      end

      def update
        user = User.find(params[:id]);
        if user.update_attributes(user_params)
          render json: {status: 'SUCCESS', message: 'Updated coupon', data: user}, status: :ok
        else
          render json: {status: 'ERROR', message: 'Coupon not updated', data: user.errors}, status: :unprocessable_entity
        end
      end

      private
        def user_params
          params.permit(:id, :name, :email)
        end

    end
  end
end
