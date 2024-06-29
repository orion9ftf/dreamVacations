class Api::V1::VacationsController < ApplicationController
  before_action :set_vacation, only: %i[ show edit update destroy ]
  # before_action :authenticate_user!

  # def import
  #   file = params[:file]
  #   if file
  #     xlsx = Roo::Spreadsheet.open(file.path)
  #     xlsx.each_row_streaming(offset: 1) do |row|
  #       Vacation.create(
  #         employee_name: row[0].cell_value,
  #         email: row[2].cell_value,
  #         leader: row[3].cell_value,
  #         start_date: row[4].cell_value,
  #         end_date: row[5].cell_value,
  #         type_vacation: row[6].cell_value,
  #         reason: row[7].cell_value,
  #         state: row[8].cell_value
  #       )
  #     end
  #     redirect_to vacations_path, notice: 'Datos importados exitosamente.'
  #   else
  #     redirect_to import_vacations_path, alert: 'Por favor, selecciona un archivo.'
  #   end
  # end


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
  end

  def create
    # @file = params[:file]
    # if @file
    #   @data = read_file(@file)
    #   render :new
    # else
    #   redirect_to new_file_path, alert: "Por favor, sube un archivo"
    # end

    file = params[:file]
    if file
      xlsx = Roo::Spreadsheet.open(file.path)
      xlsx.each_row_streaming(offset: 1) do |row|
        Vacation.create(
          employee_name: row[0]&.cell_value,
          email: row[2]&.cell_value,
          leader: row[3]&.cell_value,
          start_date: row[4]&.cell_value,
          end_date: row[5]&.cell_value,
          type_vacation: row[6]&.cell_value,
          reason: row[7]&.cell_value,
          state: row[8]&.cell_value
        )
      end
      #redirect_to vacations_path, notice: 'Datos importados exitosamente.'
      render json: { message: 'Datos importados exitosamente.' }, status: :ok

    else
      #redirect_to import_vacations_path, alert: 'Por favor, selecciona un archivo.'
      render json: { error: 'Por favor, selecciona un archivo.' }, status: :unprocessable_entity

    end

  end

  def update
    if @datum.update(datum_params)
      redirect_to files_path, notice: "Dato actualizado correctamente"
    else
      render :edit
    end
  end

  def destroy
    @datum.destroy
    redirect_to files_path, notice: "Dato eliminado correctamente"
  end
  

  # def new
  #   @vacation = Vacation.new
  # end

  # def edit
  # end

  # def create
  #   @vacation = Vacation.new(vacation_params)

  #   respond_to do |format|
  #     if @vacation.save
  #       format.html { redirect_to vacation_url(@vacation), notice: "Vacation was successfully created." }
  #       format.json { render :show, status: :created, location: @vacation }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @vacation.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end


  # def update
  #   respond_to do |format|
  #     if @vacation.update(vacation_params)
  #       format.html { redirect_to vacation_url(@vacation), notice: "Vacation was successfully updated." }
  #       format.json { render :show, status: :ok, location: @vacation }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @vacation.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end


  # def destroy
  #   @vacation.destroy

  #   respond_to do |format|
  #     format.html { redirect_to vacations_url, notice: "Vacation was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private

    def read_file(file)
      case File.extname(file.original_filename)
      when ".xlsx"
        read_xlsx(file)
      when ".csv"
        read_csv(file)
      else
        raise "Formato de archivo no soportado"
      end
    end

    def read_xlsx(file)
      xlsx = Roo::Spreadsheet.open(file.path)
      sheet = xlsx.sheet(0)
      data = []
      sheet.each_row_streaming do |row|
        data << row.map(&:value)
      end
      data
    end

    def read_csv(file)
      data = []
      CSV.foreach(file.path) do |row|
        data << row
      end
      data
    end

    def set_vacation
      @vacation = Vacation.find(params[:id])
    end

    def save_data(data)
      headers = data.first
      data[1..].each do |row|
        datum = Datum.new
        headers.each_with_index do |header, index|
          datum[header.downcase] = row[index]
        end
        datum.save!
      end
    end
    
    def vacation_params
      params.require(:vacation).permit(:employee_name, 
                                      :email, :leader, 
                                      :start_date, 
                                      :end_date, :type, 
                                      :reason, :state)
    end
end
