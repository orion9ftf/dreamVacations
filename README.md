## Gestor de Vacaciones:

* Configurar las gemas necesarias

Agrega las siguientes gemas a tu Gemfile:

```sh
gem 'roo'
gem 'csv'
```

Explicación del código (en su mayoría este código representa las maneras que se utilizaron para de llegar a la solución):

Controlador FilesController:

* new: Renderiza el formulario para cargar el archivo.

* create: Maneja la carga del archivo, lee el archivo y asigna los datos a @data para que se muestren en la vista.

* read_file: Determina el tipo de archivo y llama al método correspondiente (read_xlsx o read_csv).

* read_xlsx: Lee el archivo XLSX usando la gema roo y devuelve los datos en una matriz.

* read_csv: Lee el archivo CSV usando la clase CSV y devuelve los datos en una matriz.

Vista new.html.erb:

* Muestra un formulario para cargar el archivo.
* Muestra los datos del archivo cargado si @data está presente.


Controlador Vacations -> método index, el cual nos devuelve la respuesta en dos formatos: json para trabajarlo en API y  formato html:

```rb
def index
    @vacations = Vacation.all
    render json: @vacations
  end
```


Link de subida de archivos: http://localhost:3000/api/v1/vacations/new

Ver información en formato JSON:

Link: http://localhost:3000/


### Proceso Seguro de Ciberseguridad en Ruby on Rails

1. Mantener Rails y Gemas Actualizadas:

* Actualizaciones regulares: Mantén Rails y todas las gemas actualizadas a sus últimas versiones estables para proteger contra vulnerabilidades conocidas.

* Dependabot/Snyk: Utiliza herramientas como Dependabot o Snyk para recibir alertas de seguridad y aplicar parches automáticamente.

2. Configuración de Seguridad de Rails:

* Configuración de secreto: Mantén las claves secretas (config/secrets.yml o Rails.application.secrets) seguras y no las expongas en el repositorio.

* Protección CSRF: Rails tiene protección contra CSRF (Cross-Site Request Forgery) habilitada por defecto. Asegúrate de que esta configuración no esté deshabilitada.

3. Validación y Sanitización de Entradas:

* Strong Parameters: Usa strong_parameters para controlar qué atributos pueden ser asignados masivamente.

* Sanitización de datos: Utiliza la gem sanitize para limpiar datos ingresados por los usuarios y evitar ataques XSS (Cross-Site Scripting).

4. Autenticación y Autorización:

* Devise: Usa gemas robustas como devise para manejar la autenticación de usuarios.

* Pundit/Cancancan: Implementa gemas como pundit o cancancan para gestionar la autorización basada en roles.

5. Cifrado y Seguridad de Datos:

* Encriptación de datos sensibles: Usa gemas como attr_encrypted para cifrar datos sensibles antes de almacenarlos en la base de datos.

* HTTPS/TLS: Asegura la comunicación entre el cliente y el servidor mediante HTTPS.


6. Configuración de Seguridad de Servidor y Base de Datos:

* Despliegue seguro: Usa herramientas como Capistrano para automatizar y asegurar el proceso de despliegue.

* Firewalls y políticas de red: Configura firewalls y políticas de red para restringir el acceso no autorizado a los servidores y la base de datos.


7. Logging y Monitoreo:

* Registro de actividades: Configura logs detallados para registrar actividades y accesos a la aplicación.

* Herramientas de monitoreo: Usa herramientas como New Relic o Datadog para monitorear el rendimiento y detectar posibles problemas de seguridad.


### Ventajas del Proceso de Seguridad en Ruby on Rails

1. Ecosistema Rico en Herramientas de Seguridad:

Rails y su ecosistema proporcionan muchas gemas y configuraciones predeterminadas que ayudan a implementar prácticas de seguridad de manera efectiva.

2. Protecciones Predeterminadas:

Rails viene con protecciones contra ataques comunes como CSRF, XSS y SQL Injection habilitadas por defecto, lo que reduce el riesgo de vulnerabilidades de seguridad.

3. Facilidad de Implementación:

Gracias a las gemas y las configuraciones predeterminadas, es relativamente fácil implementar y mantener prácticas de seguridad robustas.

4. Comunidad Activa:

La comunidad de Rails es activa y responde rápidamente a nuevas amenazas de seguridad, proporcionando actualizaciones y parches oportunamente.


### Desventajas del Proceso de Seguridad en Ruby on Rails

1. Dependencia de Gemas Externas:

Confiar en muchas gemas externas puede introducir vulnerabilidades si estas no se actualizan o mantienen correctamente.

2. Configuraciones Predeterminadas:

Aunque las configuraciones predeterminadas son útiles, pueden dar una falsa sensación de seguridad si no se revisan y ajustan según las necesidades específicas de la aplicación.

3. Actualizaciones Frecuentes:

Rails y sus gemas se actualizan con frecuencia, lo que puede requerir un esfuerzo continuo para mantenerse al día y asegurar que todas las dependencias están seguras.

4. Curva de Aprendizaje:

Implementar todas las mejores prácticas de seguridad puede ser complejo y requiere conocimiento especializado, lo que puede ser una barrera para desarrolladores menos experimentados.

***Conclusión***

Implementar un proceso seguro de ciberseguridad en una aplicación Ruby on Rails es crucial para proteger contra amenazas y vulnerabilidades. Aunque hay algunas desventajas, las ventajas de usar Rails, junto con las prácticas de seguridad adecuadas, proporcionan una base sólida para desarrollar aplicaciones seguras. Mantenerse informado y proactivo en la actualización y configuración de seguridad es esencial para mantener la integridad y seguridad de la aplicación. El proceso de seguridad es primordial en cualquier aplicativo, ya que en variadas ocasiones manejamos datos sencibles de las/los usuarios.

