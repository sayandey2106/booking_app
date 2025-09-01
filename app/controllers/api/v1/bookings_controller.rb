module Api
  module V1
    class BookingsController < ApplicationController
      before_action :set_booking, only: [ :show, :update, :destroy ]

      def index
        bookings = Booking.all
        render json: { message: "Bookings fetched successfully", data: bookings }, status: :ok
      end

      def show
        render json: { message: "Booking fetched successfully", data: @booking }, status: :ok
      end

      def create
        user = User.find_by(id: booking_params[:user_id])

        if user.nil?
          render json: { error: "User not found" }, status: :not_found and return
        end

        movie = Movie.find_by(id: booking_params[:movie_id])

        if movie.nil?
          render json: { error: "Movie not found" }, status: :not_found and return
        end

        booking = Booking.new(booking_params)
        if booking.save
          BookingConfirmationJob.perform_later(booking.id)
          render json: { message: "Booking created successfully", data: booking }, status: :created
        else
          render json: { errors: booking.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @booking.update(booking_params)
          render json: { message: "Booking updated successfully", data: @booking }, status: :ok
        else
          render json: { errors: @booking.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @booking.destroy
        head :no_content
      end

      def user_bookings
        user = User.find(params[:id])

      rescue
        render json: { error: "User not found" }, status: :not_found and return
      else
        bookings = user.bookings
        render json: { message: "User bookings fetched successfully", data: bookings }, status: :ok
      end

      private

      def set_booking
        @booking = Booking.find(params[:id])
      end

      def booking_params
        params.permit(:user_id, :movie_id, :show_time, :seat_number)
      end
    end
  end
end
