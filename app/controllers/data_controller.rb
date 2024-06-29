class DataController < ApplicationController
  before_action :set_datum, only: [:show, :edit, :update, :destroy]

  def index
    @data = Datum.all
  end

  def new
  end

  def create
    file = params[:file]
    if file
      Datum.import(file)
      redirect_to data_index_path, notice: "Datos importados correctamente"
    else
      redirect_to new_data_path, alert: "Por favor, sube un archivo"
    end
  end

  def edit
  end

  def update
    if @datum.update(datum_params)
      redirect_to data_index_path, notice: "Dato actualizado correctamente"
    else
      render :edit
    end
  end

  def destroy
    @datum.destroy
    redirect_to data_index_path, notice: "Dato eliminado correctamente"
  end

  private

  def set_datum
    @datum = Datum.find(params[:id])
  end

  def datum_params
    params.require(:datum).permit(:name, :age, :email)
  end
end
