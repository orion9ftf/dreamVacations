class Api::V1::VacationsController < ApplicationController
  before_action :set_vacation, only: %i[ show edit update destroy ]
  # before_action :authenticate_user!

  def import_csv
    file = params[:file]

    return redirect_to root_path, alert: 'no seleccionaste el archivo' unless file
    return redirect_to root_path, alert: 'seleccione un archivo csv' unless file.content_type == 'text/csv'

    csvImportService = CsvImportService.new(file)
  end

  def index
    @vacations = Vacation.all
    #vacations = Vacation.ransack(params[:q]).result.page(params[:page])
    #render json: vacations, status: :ok
  end

  def show
    vacation = Vacation.find(params[:id])
    render json: vacation, status: :ok
  end

  def new
    @vacation = Vacation.new
  end

  def edit
  end

  def create
    @vacation = Vacation.new(vacation_params)

    respond_to do |format|
      if @vacation.save
        format.html { redirect_to vacation_url(@vacation), notice: "Vacation was successfully created." }
        format.json { render :show, status: :created, location: @vacation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vacation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @vacation.update(vacation_params)
        format.html { redirect_to vacation_url(@vacation), notice: "Vacation was successfully updated." }
        format.json { render :show, status: :ok, location: @vacation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vacation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vacation.destroy

    respond_to do |format|
      format.html { redirect_to vacations_url, notice: "Vacation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_vacation
      @vacation = Vacation.find(params[:id])
    end

    def vacation_params
      params.require(:vacation).permit(:employee_name, :email, :leader, :start_date, :end_date, :type, :reason, :state)
    end
end
