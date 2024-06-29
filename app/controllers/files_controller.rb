class FilesController < ApplicationController
  def new
  end

  def create
    @file = params[:file]
    if @file
      @data = read_file(@file)
      render :new
    else
      redirect_to new_file_path, alert: "Por favor, sube un archivo"
    end
  end

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
end

