class RecipesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    before_action :authorize
    ####skip_before_action only: [:index, :create] --- to ignore before_action

    def index
        render json: Recipe.all, include: [:user], status: :created
    end

    def create
        recipe = Recipe.create!(create_recipe_params)
        render json: recipe, include: [:user], status: :created
    end


    private

    def render_unprocessable_entity(invalid)
        render json:{errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def create_recipe_params
        params.permit(:title, :instructions, :minutes_to_complete).with_defaults(user_id: session[:user_id])
    end

    def authorize
        render json: {errors: ["Not authorized"]}, status: :unauthorized unless session.include? :user_id
    end
end