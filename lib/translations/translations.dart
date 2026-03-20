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
          'Failed to load the calender data':
              'Error al cargar los datos del calendario',
          'Failed to load the schedules': 'Error al cargar los horarios',
          'Select Month & Year': 'Seleccionar mes y año',
          'Confirm': 'Confirmar',

          'January': 'Enero',
          'February': 'Febrero',
          'March': 'Marzo',
          'April': 'Abril',
          'May': 'Mayo',
          'June': 'Junio',
          'July': 'Julio',
          'August': 'Agosto',
          'September': 'Septiembre',
          'October': 'Octubre',
          'November': 'Noviembre',
          'December': 'Diciembre',
          'Service Charge': 'Cargo por servicio',
          'Payment Mode: ': 'Modo de pago: ',
          'Change': 'Cambiar',
          'Change Payment Method': 'Cambiar método de pago',
          'Current method:': 'Método actual:',
          'Change to Online': 'Cambiar a en línea',
          'Switch to online payment method':
              'Cambiar al método de pago en línea',
          'Change to Offline': 'Cambiar a fuera de línea',
          'Switch to offline payment method':
              'Cambiar al método de pago fuera de línea',
          'Change Bank': 'Cambiar banco',
          'Update bank account details':
              'Actualizar detalles de la cuenta bancaria',

          'Edit Service Charge': 'Editar cargo por servicio',
          'Enter new price:': 'Ingrese nuevo precio:',
          'Enter price': 'Ingrese precio',
          'Invalid Price': 'Precio inválido',
          'Please enter a valid price': 'Por favor ingrese un precio válido',
          'Update': 'Actualizar',
          'PROPERTY DETAILS': 'DETALLES DE LA PROPIEDAD',
          'Is Eco': 'Es ecológico',
          'Material Provided': 'Material proporcionado',
          'Rooms': 'Habitaciones',
          'Bathrooms': 'Baños',
          'Total Area': 'Área total',
          'Start': 'Inicio',
          'Location': 'Ubicación',
          'Instruction:': 'Instrucción:',
          'Starts in': 'Comienza en',
          'Schedule Details': 'Detalles del horario',
          'Booking Details': 'Detalles de la reserva',
          'No Instruction': 'Sin instrucciones',
          'ASSIGNED PROFESSIONAL': 'PROFESIONAL ASIGNADO',
          'CUSTOMER DETAILS': 'DETALLES DEL CLIENTE',
          'PAYMENT SUMMARY': 'RESUMEN DE PAGO',
          'Schedules': 'Horarios',
          'No bookings on this day': 'No hay reservas en este día',
          'Failed to fetch services': 'Error al obtener servicios',
          'Error fetching services': 'Error al obtener servicios',
          'Please fill all required fields':
              'Por favor complete todos los campos requeridos',
          'Service created successfully': 'Servicio creado exitosamente',
          'Error: Failed to create service':
              'Error: No se pudo crear el servicio',
          'Something went wrong': 'Algo salió mal',
          'Service updated successfully': 'Servicio actualizado exitosamente',
          'Failed to update service': 'Error al actualizar el servicio',
          'Error updating service': 'Error al actualizar el servicio',
          'Create Service': 'Crear servicio',
          'Service Name': 'Nombre del servicio',
          'Enter service name': 'Ingrese el nombre del servicio',
          'Duration (minutes)': 'Duración (minutos)',
          'Enter duration': 'Ingrese la duración',
          'Base Price': 'Precio base',
          'Enter base price': 'Ingrese el precio base',
          'Bathroom Rate': 'Tarifa de baño',
          'Enter bathroom rate': 'Ingrese la tarifa de baño',
          'Room Rate': 'Tarifa por habitación',
          'Enter room rate': 'Ingrese la tarifa por habitación',
          'Square Foot Price': 'Precio por pie cuadrado',
          'Enter square foot price': 'Ingrese el precio por pie cuadrado',
          'Get Back': 'Volver',
          'Edit Service': 'Editar servicio',
          'Base price': 'Precio base',
          'BATH': 'BAÑO',
          'ROOM': 'HAB',
          'SQFT': 'PIE²',
          'Services': 'Servicios',
          'No services available': 'No hay servicios disponibles',
          'Please fill all required fields':
              'Por favor complete todos los campos requeridos',
          'Staff created successfully': 'Personal creado exitosamente',
          'user already existed please retry with new id':
              'El usuario ya existe, intente con un nuevo ID',
          'Something went wrong': 'Algo salió mal',
          'Staff edited successfully': 'Personal actualizado exitosamente',
          'Update failed': 'Error al actualizar',
          'Error updating staff': 'Error al actualizar el personal',
          'Staff enabled successfully': 'Personal habilitado exitosamente',
          'Failed to enable staff': 'Error al habilitar el personal',
          'Error enabling staff': 'Error al habilitar el personal',
          'Staff disabled successfully': 'Personal deshabilitado exitosamente',
          'Failed to disable staff': 'Error al deshabilitar el personal',
          'Error disabling staff': 'Error al deshabilitar el personal',
          'Staff deleted successfully': 'Personal eliminado exitosamente',
          'Failed to delete staff': 'Error al eliminar el personal',
          'Create Staff': 'Crear personal',
          'Staff Name': 'Nombre del personal',
          'Enter Staff Name': 'Ingrese el nombre del personal',
          'Email': 'Correo electrónico',
          'Enter Staff Email': 'Ingrese el correo electrónico',
          'Phone': 'Teléfono',
          'Enter Staff Phone': 'Ingrese el teléfono',
          'Password': 'Contraseña',
          'Enter Password': 'Ingrese la contraseña',
          'Priority': 'Prioridad',
          'Enter Priority': 'Ingrese la prioridad',
          'Please enter priority': 'Por favor ingrese la prioridad',
          'Get Back': 'Volver',
          'Edit Staff': 'Editar personal',
          'Staff Name': 'Nombre del personal',
          'Email': 'Correo electrónico',
          'Phone': 'Teléfono',
          'Priority': 'Prioridad',
          'Enter priority (e.g. 1)': 'Ingrese prioridad (ej. 1)',
          'Update Staff': 'Actualizar personal',
          'Cancel': 'Cancelar',
          'Priority:': 'Prioridad:',
          'Active': 'Activo',
          'Disabled': 'Deshabilitado',
          'Edit': 'Editar',
          'Enable': 'Habilitar',
          'Disable': 'Deshabilitar',
          'Delete': 'Eliminar',
          'Enable Staff': 'Habilitar personal',
          'Disable Staff': 'Deshabilitar personal',
          'Delete Staff': 'Eliminar personal',
          'Are you sure you want to enable staff?':
              '¿Está seguro de que desea habilitar el personal?',
          'Are you sure you want to disable staff?':
              '¿Está seguro de que desea deshabilitar el personal?',
          'Are you sure you want to delete staff?':
              '¿Está seguro de que desea eliminar el personal?',
          'Cancel': 'Cancelar',
          'Confirm': 'Confirmar',
          'Staff': 'Personal',
          'No staff available': 'No hay personal disponible',
          'NAME': 'NOMBRE',
          'PRIORITY': 'PRIORIDAD',
          'STATUS': 'ESTADO',
          'Edit': 'Editar',
          'Enable': 'Habilitar',
          'Disable': 'Deshabilitar',
          'Delete': 'Eliminar',
           'Your clean home,\non demand.': 'Tu hogar limpio,\na demanda.',
          'Sign in to manage your bookings':
              'Inicia sesión para gestionar tus reservas',
          'Welcome back 👋': 'Bienvenido de nuevo 👋',
          'Enter your email to receive a one-time passcode.':
              'Ingrese su correo electrónico para recibir un código de acceso único.',
          'Email address': 'Correo electrónico',
          'Enter your email': 'Ingrese su correo electrónico',
          'Send OTP': 'Enviar OTP',
          'secure & private': 'seguro y privado',
          'By continuing you agree to our\nTerms of Service & Privacy Policy':
              'Al continuar, acepta nuestros\nTérminos de servicio y Política de privacidad',
              'Email cannot be empty': 'El correo electrónico no puede estar vacío',
          'Please enter a valid email':
              'Por favor ingrese un correo electrónico válido',
          'OTP sent to your email': 'OTP enviado a su correo electrónico',
          'Failed to send OTP': 'Error al enviar OTP',
          'An error occurred:': 'Ocurrió un error:',
          'OTP resent to your email': 'OTP reenviado a su correo electrónico',
          'Failed to resend OTP': 'Error al reenviar OTP',
          'Login successful': 'Inicio de sesión exitoso',
          'Invalid OTP': 'OTP inválido',
          'Invalid response from server': 'Respuesta inválida del servidor',
          'Email and password cannot be empty':
              'El correo y la contraseña no pueden estar vacíos',
          ' Invalid credentials ': 'Credenciales inválidas',
          'OTP sent successfully': 'OTP enviado con éxito',
           "Check your inbox": "Revisa tu bandeja de entrada",
          "We sent a 6-digit code to": "Hemos enviado un código de 6 dígitos a",
          "Enter your code": "Introduce tu código",
          "Type the 6-digit code sent to your email address.":
              "Escribe el código de 6 dígitos enviado a tu correo electrónico.",
          "Didn't receive the code? ": "¿No recibiste el código? ",
          "Resend now": "Reenviar ahora",
          "Resend in 30s": "Reenviar en 30s",
          "Verify OTP": "Verificar OTP",
          "This code expires in 10 minutes": "Este código expira en 10 minutos",
          "Please enter all 6 digits": "Por favor ingresa los 6 dígitos",
           "Settings": "Configuración",
          "language": "Idioma",
          "Estimate Service": "Servicio de estimación",
          "Help Center": "Centro de ayuda",
          "Logout": "Cerrar sesión",
          "Session Expired": "Sesión expirada",
          "select language": "Seleccionar idioma",
          "english": "Inglés",
          "spanish": "Español",
          "Welcome back": "Bienvenido de nuevo",
         'Select Staff *': 'Seleccionar personal *',
          
         

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
          'Add Zipcode': 'Agregar código postal',
          "Zipcode Required": "Código postal *",
          "Zipcode Hint": "ej., 10001",
          "Active": "Activo",
          "Cancel": "Cancelar",
          'Total Booking/Day': 'Reservas totales/día',
          'Allocation': 'Asignación',
          'Avg staff/Booking': 'Personal promedio/reserva',
          'Cancellation': 'Cancelación',
          'Cancelled/Booking': 'Canceladas/reserva',
          'Nice day, @name': 'Buen día, @name',
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
          'Total Clients': 'Clientes totales',
          'Total Revenue': 'Ingresos totales',
          'Total Staff': 'Personal total',

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

          "My Bookings": "Mis reservas",

          // Schedule Log Card
          "Start": "Inicio",
          "End": "Fin",

          // Uppercase Statuses (In case backend returns uppercase strings)
          "COMPLETED": "COMPLETADO",
          "SCHEDULED": "PROGRAMADO",
          "CANCELLED": "CANCELADO",
          "PENDING": "PENDIENTE",

          // Schedule History Screen
          "Schedule History": "Historial de horarios",
          "Reset": "Restablecer",
          "Date Range": "Rango de fechas",
          "Select date range": "Seleccionar rango de fechas",
          "Apply Filters": "Aplicar filtros",
          "Loading more...": "Cargando más...",
          "No Schedules Found": "No se encontraron horarios",
          "Try adjusting your filters\nor date range":
              "Intente ajustar sus filtros\no el rango de fechas",

          // Weekdays (3-letter)
          'sun': 'Dom',
          'mon': 'Lun',
          'tue': 'Mar',
          'wed': 'Mié',
          'thu': 'Jue',
          'fri': 'Vie',
          'sat': 'Sáb',

          // Months (3-letter)
          'jan': 'Ene',
          'feb': 'Feb',
          'mar': 'Mar',
          'apr': 'Abr',
          'may': 'May',
          'jun': 'Jun',
          'jul': 'Jul',
          'aug': 'Ago',
          'sep': 'Sep',
          'oct': 'Oct',
          'nov': 'Nov',
          'dec': 'Dic',

          // Time formatting
          "AM": "a. m.",
          "PM": "p. m.",

          // Service Types
          "Post Renovation / Construction":
              "Limpieza post-construcción / renovación",
          "Move In Out Cleaning": "Limpieza de mudanza (entrada/salida)",
          "Regular Cleaning": "Limpieza regular",
          "Deep Cleaning": "Limpieza profunda",

          // User Booking Card
          "Date not set": "Fecha no establecida",
          "Address not provided": "Dirección no proporcionada",
          "Service": "Servicio",

          // Full Weekdays
          'monday': 'Lunes',
          'tuesday': 'Martes',
          'wednesday': 'Miércoles',
          'thursday': 'Jueves',
          'friday': 'Viernes',
          'saturday': 'Sábado',
          'sunday': 'Domingo',
          // Bottom Navigation
          "Home": "Inicio",
          "Inbox": "Mensajes", // or "Bandeja de entrada" if you prefer
          "Subscription": "Suscripción",

          // Messages Screen
          "Messages": "Mensajes",
          "Search messages...": "Buscar mensajes...",

          // Message Title Card (Legacy/Commented)
          "Milk Donar": "Donante de leche",
          "Milk Recipient": "Receptor de leche",
          // Chat Screen
          "Enter Message": "Escribe un mensaje...",

          // Create Booking - Step 1
          "Continue": "Continuar",
          "New Booking": "Nueva reserva",
          "Loading services...": "Cargando servicios...",
          "Step 1 of 4": "Paso 1 de 4",
          "Choose a service": "Elige un servicio",
          "Property Details": "Detalles de la propiedad",
          "Number of Bedrooms": "Número de habitaciones",
          "Number of Bathrooms": "Número de baños",
          "Property Type": "Tipo de propiedad",
          "Apartment": "Apartamento",
          "Studio": "Estudio",
          "House": "Casa",
          "Size (Square Feet)": "Tamaño (Pies cuadrados)",
          "Additional Options": "Opciones adicionales",
          "Eco-Friendly Cleaning": "Limpieza ecológica",
          "Use environmentally friendly cleaning products":
              "Usar productos de limpieza amigables con el medio ambiente",
          "Material Provide": "Materiales proporcionados",
          "We provide all cleaning materials and equipment":
              "Proporcionamos todos los materiales y equipos de limpieza",
          // Create Booking - Step 2 (Plan Selection)
          "Plan Selection": "Selección de plan",
          "Calculating prices...": "Calculando precios...",
          "Step 2 of 4": "Paso 2 de 4",

          // Common Plan Titles (Modify if your backend sends different strings)
          "One-Time Cleaning": "Limpieza de una sola vez",
          "Weekly Cleaning": "Limpieza semanal",
          "Bi-Weekly Cleaning": "Limpieza quincenal",
          "Monthly Cleaning": "Limpieza mensual",

          // Create Booking - Step 3 (Location & Customer Info)
          "Step 3 of 4": "Paso 3 de 4",
          "Customer Information": "Información del cliente",
          "First Name*": "Nombre*",
          "Enter customer's first name": "Ingrese el nombre del cliente",
          "Please enter customer's first name":
              "Por favor ingrese el nombre del cliente",
          "Last Name*": "Apellido*",
          "Enter customer's last name": "Ingrese el apellido del cliente",
          "Please enter customer's last name":
              "Por favor ingrese el apellido del cliente",
          "Email*": "Correo electrónico*",
          "customer@example.com": "cliente@ejemplo.com",
          "Please enter customer's email":
              "Por favor ingrese el correo electrónico del cliente",
          "Please enter a valid email":
              "Por favor ingrese un correo electrónico válido",
          "Phone*": "Teléfono*",
          "Enter customer's phone number":
              "Ingrese el número de teléfono del cliente",
          "Please enter customer's phone number":
              "Por favor ingrese el número de teléfono del cliente",
          "Please enter a valid phone number":
              "Por favor ingrese un número de teléfono válido",
          "Address*": "Dirección*",
          "123 Main St, Apt 4B": "Calle Principal 123, Apt 4B",
          "Please enter your address": "Por favor ingrese su dirección",
          "City*": "Ciudad*",
          "Enter your city": "Ingrese su ciudad",
          "Please enter your city": "Por favor ingrese su ciudad",
          "Zipcode*": "Código postal*",
          "Please enter your zipcode": "Por favor ingrese su código postal",
          "Please enter a valid zipcode":
              "Por favor ingrese un código postal válido",
          "Special Instructions": "Instrucciones especiales",
          "Gate code, parking info, pet details, etc.":
              "Código de puerta, información de estacionamiento, detalles de mascotas, etc.",

          // Create Booking - Step 4 (Date & Time)
          "Step 4 of 4": "Paso 4 de 4",
          "Select date & time": "Seleccionar fecha y hora",
          "Reschedule Booking": "Reprogramar reserva",
          "reschedule your upcoming service date ":
              "reprogramar la próxima fecha de servicio ",
          "of the booking": "de la reserva",
          "Available slots": "Horarios disponibles",
          "Loading time slots...": "Cargando horarios...",
          "Please select timeslot": "Por favor seleccione un horario",
          " Reschedule": " Reprogramar",

          // Full Months
          'january': 'Enero',
          'february': 'Febrero',
          'march': 'Marzo',
          'april': 'Abril',
          'may': 'Mayo',
          'june': 'Junio',
          'july': 'Julio',
          'august': 'Agosto',
          'september': 'Septiembre',
          'october': 'Octubre',
          'november': 'Noviembre',
          'december': 'Diciembre',

          // Create Booking - Final Step (Review & Pay)
          "Confirm & Pay": "Confirmar y pagar",
          "Review & Pay": "Revisar y pagar",
          "Service Details": "Detalles del servicio",
          "Plan": "Plan",
          "BR": "Hab", // Bedrooms abbreviation
          "BA": "Baños", // Bathrooms abbreviation
          "Materials Provided": "Materiales proporcionados",
          "Schedule": "Horario",
          "Date & Time": "Fecha y hora",
          "Not selected": "No seleccionado",
          "at":
              "a las", // Joins the date and time (e.g. "January 1 at 10:00 AM")
          "Location": "Ubicación",
          "Address": "Dirección",
          "Payment Method": "Método de pago",
          "Card Payment": "Pago con tarjeta",
          "Pay securely with credit/debit card":
              "Pague de forma segura con tarjeta de crédito/débito",
          "Cash/Vellom": "Efectivo/Vellom",
          "Pay after service completion": "Pagar al finalizar el servicio",
          "Price Summary": "Resumen de precios",
          "ADMIN": "ADMINISTRADOR",
          "Base Price": "Precio base",
          "Custom Price (editable)*": "Precio personalizado (editable)*",
          "Enter custom price": "Ingrese el precio personalizado",
          "Total": "Total",
          "By confirming, you agree to our cancellation policy. You can cancel up to 24 hours before service for free.":
              "Al confirmar, aceptas nuestra política de cancelación. Puedes cancelar hasta 24 horas antes del servicio de forma gratuita.",
          // Home Screen
          "Have a good day,": "Que tengas un buen día,",
          "Book a cleaning": "Reserva una limpieza",
          "Schedule your next professional home cleaning in seconds.":
              "Programa tu próxima limpieza profesional del hogar en segundos.",
          "+ New Booking": "+ Nueva reserva",
          "Upcoming": "Próximos",
        },
      };
}
