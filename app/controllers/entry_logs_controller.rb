class EntryLogsController < ApplicationController
  before_action :set_entry_log, only: %i[ show edit update destroy ]

  # GET /entry_logs or /entry_logs.json
  def index
    @entry_logs = EntryLog.all
  end

  # GET /entry_logs/1 or /entry_logs/1.json
  def show
  end

  # GET /entry_logs/new
  def new
    @entry_log = EntryLog.new
  end

  # GET /entry_logs/1/edit
  def edit
  end

  # POST /entry_logs or /entry_logs.json
  def create
    @entry_log = EntryLog.new(entry_log_params)

    respond_to do |format|
      if @entry_log.save
        format.html { redirect_to @entry_log, notice: "Entry log was successfully created." }
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
        format.html { redirect_to @entry_log, notice: "Entry log was successfully updated." }
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
      params.expect(entry_log: [ :date, :type, :name, :calories, :protein, :added_sugars, :total_sugars, :carbs ])
    end
end
