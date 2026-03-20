import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'es_ES': {
          // Errors
          'failed to load services': 'Error al cargar los servicios',
          'failed to calculate estimate': 'Error al calcular la estimación',
          'failed to fetch time slots': 'Error al obtener los horarios',
          'failed to load bookings':
              'No se pudieron cargar las reservas ({{code}})',
          'access token missing': 'Falta el token de acceso',
          'something went wrong': 'Algo salió mal',
          "Something Went Wrong": "Algo salió mal",

          // Common
          "Unknown": "Desconocido",
          "na": "N/D",
          "one time": "Una vez",

          // Home
          "Bookings": "Reservas",
          "logout_successful": "Cierre de sesión exitoso",
          "Last Week": "Última semana",
          "Last Month": "Último mes",
          "Last Year": "Último año",
          "Name": "nombre",
          "Email": "correo",
          "Search": "Buscar",
          'Zone updated successfully': 'Zona actualizada correctamente',
          'Failed to update zone': 'Error al actualizar la zona',
          'Staff assigned successfully': 'Personal asignado correctamente',
          'Failed to assign staff': 'Error al asignar el personal',
          'Please enter a pincode': 'Por favor ingrese un código postal',
          'Pincode assigned successfully':
              'Código postal asignado correctamente',
          'Failed to assign pincode': 'Error al asignar el código postal',
          'Pincode deleted successfully':
              'Código postal eliminado correctamente',
          'Failed to delete pincode': 'Error al eliminar el código postal',
          'Zone deleted successfully': 'Zona eliminada correctamente',
          'Failed to delete zone': 'Error al eliminar la zona',
          'Failed to fetch staff': 'Error al obtener el personal',
          'Failed to fetch zone details':
              'Error al obtener los detalles de la zona',
          'Error': 'Error',
          'Zone Details': 'Detalles de la zona',
          'Code:': 'Código:',
          'Zipcodes': 'Códigos postales',
          'Add': 'Agregar',
          'No zipcode available': 'No hay códigos postales disponibles',
          'Staff': 'Personal',
          'No staff assigned': 'No hay personal asignado',
          'Bookings:': 'Reservas:',
          'Disable Zone': 'Desactivar zona',
          'Enable Zone': 'Activar zona',
          'Delete Zipcode?': '¿Eliminar código postal?',
          'Are you sure you want to delete zipcode':
              '¿Está seguro de que desea eliminar el código postal',
          'from this zone?': 'de esta zona?',
          'Cancel': 'Cancelar',
          'Delete': 'Eliminar',
          'Disable Zone?': '¿Desactivar zona?',
          'Enable Zone?': '¿Activar zona?',
          'This zone will be disabled and no longer available for new bookings. You can enable it later.':
              'Esta zona será desactivada y ya no estará disponible para nuevas reservas. Puede activarla más tarde.',
          'This zone will be enabled and available for new bookings.':
              'Esta zona será activada y estará disponible para nuevas reservas.',
          'Disable': 'Desactivar',
          'Enable': 'Activar',
          'Regions': 'Regiones',
          'Active': 'Activo',
          'Inactive': 'Inactivo',
          'zipcodes': 'códigos postales',
          'staff': 'personal',
          'bookings': 'reservas',
          'No regions yet': 'No hay regiones aún',
          'Tap the + button to create your first region':
              'Toque el botón + para crear su primera región',
               'Completed': 'Completado',
          'Booking canceled successfully': 'Reserva cancelada con éxito',
          'Failed to cancel booking': 'Error al cancelar la reserva',
          'Price updated successfully': 'Precio actualizado correctamente',
          'Failed to update price': 'Error al actualizar el precio',
          'Payment method updated successfully':
              'Método de pago actualizado correctamente',
          'Failed to update payment method':
              'Error al actualizar el método de pago',
               'Failed to load schedules': 'Error al cargar los horarios',
          
         

          // Tabs
          "SUBSCRIPTION": "SUSCRIPCIÓN",
          "ONE-TIME": "UNA VEZ",
          "N/A": "N/D",
          "NA": "NA",

          // Dashboard cards
          "Booking": "Reserva",
          "Allocation": "Asignación",
          "Cancellation": "Cancelación",
          "Totalbooking/Day": "Total Reserva/Día",
          "Avgstaff/Booking": "Prom staff/Reserva",
          "Cancelled/Booking": "Cancelado/Reserva",

          // Status bottom sheet
          "Change Status": "Cambiar estado",
          "Save Changes": "Guardar cambios",
          "Update Failed": "Error al actualizar",

          // History
          "Cleaning History": "Historial de limpieza",
          "Cleaned By": "Limpiado por",

          // Status
          "Scheduled": "Programado",
          "Missed": "Perdido",
          "Cancelled": "Cancelado",
          "Refunded": "Reembolsado",
          "Completed": "Completado",
          "Payment Success": "Pago exitoso",
          "Payment Failed": "Pago fallido",
          "Nice day": "Buen día, {{name}}",

  
  "From date": "Desde fecha",
  "To date": "Hasta fecha",
  "Today": "Hoy",
  "Settings": "Configuraciones",
  "Logout": "Cerrar sesión",
  "Total Clients": "Total Clientes",
  "Total Revenue": "Total Ingresos",
  "Total Staff": "Total Personal",
  "Add Zipcode": "Agregar código postal",
  "Zipcode Required": "Código postal *",
  "Zipcode Hint": "ej., 10001",
  "Active": "Activo",
  "Cancel": "Cancelar",
 "Create New Region": "Crear nueva región",
  "Region Name Required": "Nombre de región *",
  "Region Code Required": "Código de región *",
  "Create Region": "Crear región",
  "Region Name Hint": "ej., Downtown Manhattan",
  "Region Code Hint": "ej., NYC-DT-001",
  "Assign Staff": "Asignar personal",
  "Select Staff Required": "Seleccionar personal *",
  "No Staff Available": "No hay personal disponible",
  "Choose Staff Member": "Elegir un miembro del personal",
  

  "language": "Idioma",
  "select_language": "Seleccionar idioma",
  "english": "Inglés",
  "spanish": "Español",

 
  "Estimate Service": "Servicio de estimación",
  "Help Center": "Centro de ayuda",
  "logout": "Cerrar sesión",
  "Session Expired": "Sesión expirada",

 

  
  "Performance Analysis": "Análisis de rendimiento",

  
  "Unknown": "Desconocido",
 

 

          // Booking UI
          'price': 'Precio',
          'payment': 'Pago',
          'offline': 'Fuera de línea',
          'booking cancelled': 'Reserva cancelada con éxito',

          "booking_details": "Detalles de la reserva",
          "cancel": "Cancelar",
          "reschedule": "Reprogramar",
          "cancel booking": "Cancelar reserva",
          "confirm cancel booking":
              "¿Estás seguro de que deseas cancelar esta reserva?",
          "yes cancel": "Sí, cancelar",
          "no": "No",

          "start date": "Fecha de inicio",
          "service day": "Día del servicio",
          "service time": "Hora del servicio",
          "service type": "Tipo de servicio",
          "recurring type": "Tipo de recurrencia",
          "no of rooms": "Número de habitaciones",
          "no of bathrooms": "Número de baños",
          "total area": "Área total",
          "address": "Dirección",
          "add ons": "Extras",
          "service price": "Precio del servicio",

          "eco cleaning": "Limpieza ecológica",
          "material provided": "Material proporcionado",
          "no add ons": "Sin extras",
          "bi weekly": "Quincenal",
          "sqft": "pies²",

          // Payment
          'cash': 'Efectivo',
          'card': 'Tarjeta',
          'upi': 'UPI',
          'weekly': 'Semanal',
          'monthly': 'Mensual',

          // Weekdays
          'sun': 'Dom',
          'mon': 'Lun',
          'tue': 'Mar',
          'wed': 'Mié',
          'thu': 'Jue',
          'fri': 'Vie',
          'sat': 'Sáb',
        },
      };
}
