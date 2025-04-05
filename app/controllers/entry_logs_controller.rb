class EntryLogsController < ApplicationController
  before_action :set_entry_log, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /entry_logs or /entry_logs.json
  def index
    @entry_logs = current_user.entry_logs.newest_first
  end

  # GET /entry_logs/1 or /entry_logs/1.json
  def show; end

  # GET /entry_logs/new
  def new
    @entry_log = current_user.entry_logs.new
  end

  # GET /entry_logs/1/edit
  def edit; end

  # POST /entry_logs or /entry_logs.json
  def create
    # @entry_log = EntryLog.new(entry_log_params)
    @entry_log = current_user.entry_logs.new(entry_log_params)

    if params[:entry_log][:meal].present?
      meal = Meal.find(params[:entry_log][:meal])
      @entry_log.assign_attributes(
        name: meal.name,
        calories: meal.calories,
        protein: meal.protein,
        added_sugars: meal.added_sugars,
        total_sugars: meal.total_sugars,
        carbs: meal.carbs
      )
    end

    respond_to do |format|
      if @entry_log.save
        format.html { redirect_to entry_logs_path, notice: "Entry log was successfully created." }
        format.json { render :show, status: :created, location: @entry_log }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entry_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entry_logs/1 or /entry_logs/1.json
  def update
    respond_to do |format|
      if @entry_log.update(entry_log_params)
        format.html { redirect_to entry_logs_path, notice: "Entry log was successfully updated." }
        format.json { render :show, status: :ok, location: @entry_log }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entry_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entry_logs/1 or /entry_logs/1.json
  def destroy
    @entry_log.destroy!

    respond_to do |format|
      format.html { redirect_to entry_logs_path, status: :see_other, notice: "Entry log was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry_log
      @entry_log = EntryLog.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def entry_log_params
      params.require(:entry_log).permit(:date, :meal_type, :name, :calories, :protein, :added_sugars, :total_sugars, :carbs)
    end
end
