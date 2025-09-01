module Api
  module V1
      class MoviesController < ApplicationController
        before_action :set_movie, only: [ :show, :update, :destroy ]

        def index
          movies = Movie.all
          render json: { "message": "Movies fetched successfully", "data": movies }, status: :ok
        end

        def show
          render json: { "message": "Movie fetched successfully", "data": @movie }, status: :ok
        end

        def create
          movie = Movie.new(movie_params)

          if movie.save
            render json: {message: "Movie created successfully", data: movie}, status: :created
          else
            render json: { errors: movie.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def update
          if @movie.update(movie_params)
            render json: movie
          else
            render json: { errors: @movie.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def destroy
          @movie.destroy
          head :no_content
        end

        private

        def set_movie
          @movie = Movie.find(params[:id])
        end

        def movie_params
          params.permit(:title, :language, :duration, :user_id, :movie_id)
        end
      end
  end
end