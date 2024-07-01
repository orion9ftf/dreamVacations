import gspread
from google.auth.transport.requests import Request
from google.oauth2.service_account import Credentials

# Configuración de las credenciales y autorización
SCOPES = ['https://www.googleapis.com/auth/spreadsheets']
SERVICE_ACCOUNT_FILE = 'ruta/al/archivo/credenciales.json'

def get_gsheet_service():
    creds = Credentials.from_service_account_file(
        SERVICE_ACCOUNT_FILE, scopes=SCOPES)
    client = gspread.authorize(creds)
    return client

# Consultar datos de una hoja
def consultar_hoja(spreadsheet_id, sheet_name):
    client = get_gsheet_service()
    sheet = client.open_by_key(spreadsheet_id).worksheet(sheet_name)
    data = sheet.get_all_records()
    return data

# Modificar datos de una celda
def modificar_celda(spreadsheet_id, sheet_name, cell, valor):
    client = get_gsheet_service()
    sheet = client.open_by_key(spreadsheet_id).worksheet(sheet_name)
    sheet.update(cell, valor)

# Ingresar nuevos datos
def ingresar_datos(spreadsheet_id, sheet_name, fila):
    client = get_gsheet_service()
    sheet = client.open_by_key(spreadsheet_id).worksheet(sheet_name)
    sheet.append_row(fila)

# Ejemplo de uso
if __name__ == "__main__":
    SPREADSHEET_ID = 'tu_spreadsheet_id'
    SHEET_NAME = 'nombre_de_tu_hoja'

    # Consultar datos
    datos = consultar_hoja(SPREADSHEET_ID, SHEET_NAME)
    print(datos)

    # Modificar una celda
    modificar_celda(SPREADSHEET_ID, SHEET_NAME, 'A1', 'Nuevo Valor')

    # Ingresar nuevos datos
    ingresar_datos(SPREADSHEET_ID, SHEET_NAME, ['Nuevo', 'Dato', 123])
