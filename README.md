

Configurar las gemas necesarias
Agrega las siguientes gemas a tu Gemfile:

```sh
gem 'roo'
gem 'csv'
```

Generar el controlador y la vista
Genera un controlador llamado Files con acciones new y create:

```sh
rails generate controller Files new create
```

Configurar el controlador
Modifica el archivo `app/controllers/files_controller.rb` para que se vea así:

```rb
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

```

Configurar las vistas
Crea las vistas necesarias:

app/views/files/new.html.erb

```html
<h1>Upload File</h1>

<%= form_with url: files_path, local: true, method: :post, multipart: true do |form| %>
  <div class="field">
    <%= form.label :file %>
    <%= form.file_field :file %>
  </div>

  <div class="actions">
    <%= form.submit 'Upload' %>
  </div>
<% end %>

<% if @data.present? %>
  <h2>Uploaded Data</h2>
  <table>
    <thead>
      <tr>
        <% @data.first.each do |header| %>
          <th><%= header %></th>
        <% end %>
      </tr>
    </thead>
    <tbody>
      <% @data[1..].each do |row| %>
        <tr>
          <% row.each do |cell| %>
            <td><%= cell %></td>
          <% end %>
        </tr>
      <% end %>
    </tbody>
  </table>
<% end %>

<%= link_to 'Back', new_file_path %>
```

Configurar las rutas
Modifica el archivo config/routes.rb para que se vea así:

```rb
Rails.application.routes.draw do
  resources :files, only: [:new, :create]
  root 'files#new'
end

```


Explicación del código
Controlador FilesController:

new: Renderiza el formulario para cargar el archivo.

create: Maneja la carga del archivo, lee el archivo y asigna los datos a @data para que se muestren en la vista.

read_file: Determina el tipo de archivo y llama al método correspondiente (read_xlsx o read_csv).

read_xlsx: Lee el archivo XLSX usando la gema roo y devuelve los datos en una matriz.

read_csv: Lee el archivo CSV usando la clase CSV y devuelve los datos en una matriz.
Vista new.html.erb:

Muestra un formulario para cargar el archivo.
Muestra los datos del archivo cargado si @data está presente.




<img width="485" alt="json-format" src="https://github.com/orion9ftf/dreamVacations/assets/104280123/a550a97c-6cd4-468a-808a-34855a8840fb">


