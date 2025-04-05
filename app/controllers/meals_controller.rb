class MealsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meal, only: %i[ show edit update destroy ]

  def index
    @meals = current_user.meals
  end

  def show; end

  def new
    @meal = current_user.meals.new
  end

  def create
    @meal = current_user.meals.new(meal_params)

    respond_to do |format|
      if @meal.save
        format.html { redirect_to meals_path, notice: "Meal was successfully created." }
        format.json { render :show, status: :created, location: @meal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @meal.update(meal_params)
        format.html { redirect_to meals_path, notice: "Meal was successfully updated." }
        format.json { render :show, status: :ok, location: @meal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @meal.destroy
    respond_to do |format|
      format.html { redirect_to meals_path, notice: "Meal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_meal
    @meal = current_user.meals.find(params[:id])
  end

  def meal_params
    params.require(:meal).permit(:name, :calories, :protein, :added_sugars, :total_sugars, :carbs)
  end
end
