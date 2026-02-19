// import 'dart:convert';
// import 'package:cleanby_maria/Screens/Admin/BookingScreen/Controller/EstimateController.dart';
// import 'package:cleanby_maria/Screens/Admin/ClientScreen/Service/BookingController.dart';
// import 'package:cleanby_maria/Screens/Admin/HomeScreen/Services/homeController.dart';
// import 'package:cleanby_maria/Src/appButton.dart';
// import 'package:cleanby_maria/Src/appTextField.dart';
// import 'package:cleanby_maria/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';

// class ClientDetailsScreen extends StatefulWidget {
//   const ClientDetailsScreen({
//     super.key,
//     required this.Serviceid,
//     required this.noofrooms,
//     required this.recurringDuration,
//     required this.noofbathrooms,
//     required this.sizeofhome,
//     required this.propertytype,
//     required this.isMaterialprovided,
//     required this.iseEo,
//     required this.recurringType,
//     required this.recurringTypeId,
//     required this.price,
//     required this.totalDuration,
//   });

//   final String Serviceid;
//   final int noofrooms;
//   final int noofbathrooms;
//   final int recurringDuration;
//   final int sizeofhome;
//   final String propertytype;
//   final bool isMaterialprovided;
//   final bool iseEo;
//   final String recurringTypeId;
//   final String recurringType;
//   final String price;
//   final int totalDuration;

//   @override
//   State<ClientDetailsScreen> createState() => _ClientDetailsScreenState();
// }

// class _ClientDetailsScreenState extends State<ClientDetailsScreen> {
//   String? selectedDate;
//   String? selectedTime;
//   DateTime? pickedDate;
//   List timeSlots = [];
//   bool _isSubmitting = false;

//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _addressController = TextEditingController();
//   final _address2Controller = TextEditingController();
//   final _cityController = TextEditingController();
//   final _zipCodeController = TextEditingController();
//   final _landmarkController = TextEditingController();
//   final _amountController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _amountController.text = widget.price;
//   }

//   bool validateFields() {
//     // List of all the controllers
//     final fields = {
//       'Name': _nameController,
//       'Email': _emailController,
//       'Phone': _phoneController,
//       'Address': _addressController,
//      // 'Address Line 2': _address2Controller,
//       'City': _cityController,
//       'Zip Code': _zipCodeController,
//      // 'Landmark': _landmarkController,
//       'Amount': _amountController,
//     };

//     for (final entry in fields.entries) {
//       if (entry.value.text.trim().isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('${entry.key} cannot be empty')),
//         );
//         return false; // Stop on first empty field
//       }
//     }

//     return true; // All fields are non-empty
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('>>> BaseDate: $pickedDate, SelectedDate: $selectedDate');
//     print('>>> NextRecurringDate: ${_getNextRecurringDate()}');

//     final nextRecurringDate = _getNextRecurringDate();
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Client Details',
//               style: TextStyle(fontWeight: FontWeight.w600)),
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//           elevation: 0.5,
//         ),
//         backgroundColor: Colors.white,
//         body: Padding(
//           padding: EdgeInsets.all(16.w),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Apptextfield.primary(
//                     labelText: 'First Name',
//                     hintText: 'Enter Name',
//                     label: '',
//                     controller: _nameController),
//                 Apptextfield.primary(
//                     labelText: 'Email',
//                     hintText: 'Enter Email',
//                     label: '',
//                     controller: _emailController),
//                 Apptextfield.primary(
//                     labelText: 'Phone',
//                     hintText: 'Enter Phone',
//                     label: '',
//                     controller: _phoneController),
//                 Apptextfield.primary(
//                     labelText: 'Address',
//                     hintText: 'Enter Address',
//                     label: '',
//                     controller: _addressController),
//                 Apptextfield.primary(
//                     labelText: 'Address 2',
//                     hintText: 'Enter Address Line 2 (optional)',
//                     label: '',
//                     controller: _address2Controller),
//                 Apptextfield.primary(
//                     labelText: 'City',
//                     hintText: 'Enter City',
//                     label: '',
//                     controller: _cityController),
//                 Apptextfield.primary(
//                     labelText: 'Zip Code',
//                     hintText: 'Enter Zip Code',
//                     label: '',
//                     controller: _zipCodeController),
//                 Apptextfield.primary(
//                     labelText: 'Landmark',
//                     hintText: 'Enter Landmark (optional)',
//                     label: '',
//                     controller: _landmarkController),
//                 SizedBox(height: 16.h),
//                 _buildServiceDateCard(),
//                 if (selectedDate != null && selectedTime != null) ...[
//                   Padding(
//                     padding: EdgeInsets.only(top: 12.h),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Center(
//                           child: Text(
//                             "Selected Date: ${DateFormat('EEEE, MM-dd-yyyy').format(DateTime.parse(selectedDate!))}, $selectedTime",
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         if (_getNextRecurringDate().isNotEmpty)
//                           SizedBox(height: 10.h),
//                         Center(
//                           child: Text(
//                             "Next will be on: $nextRecurringDate",
//                             style: TextStyle(
//                                 color: Colors.green,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//                 SizedBox(height: 20.h),
//                 Apptextfield.primary(
//                   labelText: "Estimate Price",
//                   hintText: "Current Price",
//                   label: '',
//                   controller: _amountController,
//                 ),
//                 SizedBox(height: 20.h),
//                 AppButton(
//                   text: "Book",
//                   isLoading: isLoading,
//                   onPressed: () {
//                     if (!validateFields()) {
//                       return;
//                     } else {
//                       _bookService();
//                     }
//                   },
//                 ),
//                 if (_isSubmitting)
//                   Padding(
//                     padding: EdgeInsets.only(top: 12.h),
//                     child: const CircularProgressIndicator(
//                         color: Color(0xff19A4C6)),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildServiceDateCard() {
//     return GestureDetector(
//       onTap: () => _showDaySelectionSheet(),
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 20.h),
//         decoration: BoxDecoration(
//           color: Colors.grey.shade100,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: Colors.grey.shade300),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.calendar_month,
//                 size: 35, color: Color(0xff19A4C6)),
//             SizedBox(width: 30.w),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text("Choose Day 1",
//                     style:
//                         TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
//                 Text("Tap to choose day & time",
//                     style: TextStyle(color: Colors.grey.shade600)),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showDaySelectionSheet() {
//     DateTime now = DateTime.now();
//     DateTime firstDate = now.add(const Duration(days: 1));
//     DateTime lastDate = now.add(const Duration(days: 22));
//     DateTime initialDate = firstDate;
//     DateTime tempPickedDate = initialDate;

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
//           child: StatefulBuilder(
//             builder: (context, setModalState) {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(height: 15.h),
//                   Text(
//                     "Select Service Day",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                   ),
//                   SizedBox(height: 15.h),
//                   const Text(
//                     "* This selected date determines the fixed day of the week for recurring plans.",
//                     style: TextStyle(color: Colors.red, fontSize: 16),
//                   ),
//                   SizedBox(height: 16.h),
//                   Theme(
//                     data: Theme.of(context).copyWith(
//                       colorScheme: ColorScheme.light(
//                         primary: Color(0xff19A4C6),
//                         onPrimary: Colors.white,
//                         surface: Colors.white,
//                         onSurface: Colors.black,
//                       ),
//                     ),
//                     child: CalendarDatePicker(
//                       initialDate: tempPickedDate,
//                       firstDate: firstDate,
//                       lastDate: lastDate,
//                       onDateChanged: (picked) {
//                         setModalState(() {
//                           tempPickedDate = picked;
//                         });
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 20.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xff19A4C6),
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 24.w, vertical: 10.h),
//                         ),
//                         onPressed: () => Navigator.pop(context),
//                         child: const Text("Cancel",
//                             style: TextStyle(color: Colors.white)),
//                       ),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xff19A4C6),
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 24.w, vertical: 10.h),
//                         ),
//                         onPressed: () async {
//                           setState(() {
//                             pickedDate = tempPickedDate;
//                             selectedDate =
//                                 DateFormat('yyyy-MM-dd').format(tempPickedDate);
//                             selectedTime = null;
//                             timeSlots = [];
//                           });

//                           final slots = await AppController().fetchTimeSlots(
//                             date: tempPickedDate,
//                             totalDuration: widget.totalDuration,
//                             recurringTypeId: widget.recurringTypeId,
//                           );

//                           setState(() {
//                             timeSlots = slots;
//                           });

//                           Navigator.pop(context);
//                           _showTimeSelectionSheet(tempPickedDate);
//                         },
//                         child: const Text("OK",
//                             style: TextStyle(color: Colors.white)),
//                       ),
//                     ],
//                   )
//                 ],
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   void _showTimeSelectionSheet(DateTime pickedDate) {
//     String? tempSelectedTime;

//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       isScrollControlled: true,
//       builder: (_) {
//         return StatefulBuilder(
//           builder: (context, setModalState) {
//             return Padding(
//               padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Text("Choose Time",
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                   SizedBox(height: 20.h),
//                   if (timeSlots.isEmpty)
//                     const Text("No time slots available",
//                         style: TextStyle(color: Colors.red))
//                   else
//                     Wrap(
//                       spacing: 10.w,
//                       children: timeSlots.map((slot) {
//                         final isSelected = slot["time"] == tempSelectedTime;
//                         return ChoiceChip(
//                           label: Text(slot["time"]),
//                           selected: isSelected,
//                           onSelected: (_) {
//                             setModalState(() {
//                               tempSelectedTime = slot["time"];
//                             });
//                           },
//                           selectedColor: const Color(0xff19A4C6),
//                           labelStyle: TextStyle(
//                             color: isSelected ? Colors.white : Colors.black,
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   SizedBox(height: 24.h),
//                   ElevatedButton(
//                     onPressed: tempSelectedTime != null
//                         ? () {
//                             setState(() {
//                               selectedTime = tempSelectedTime;
//                             });
//                             Future.delayed(const Duration(milliseconds: 100),
//                                 () {
//                               Navigator.pop(context);
//                             });
//                           }
//                         : null,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xff19A4C6),
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 32.w, vertical: 12.h),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)),
//                     ),
//                     child: const Text("Confirm",
//                         style: TextStyle(color: Colors.white)),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   bool isLoading = false;

//   void _bookService() async {
//     if (selectedDate == null || selectedTime == null) {
//       Fluttertoast.showToast(msg: "Please select a date and time");
//       return;
//     }

//     setState(() {
//       _isSubmitting = true;
//     });
//     final bookingData = {
//       "serviceId": widget.Serviceid,
//       "type": "recurring",
//       "paymentMethod": "offline",
//       "recurringTypeId": widget.recurringTypeId,
//       "no_of_rooms": widget.noofrooms,
//       "no_of_bathrooms": widget.noofbathrooms,
//       "propertyType": widget.propertytype,
//       "materialProvided": widget.isMaterialprovided,
//       "areaSize": widget.sizeofhome,
//       "isEco": widget.iseEo,
//       "price": double.tryParse(_amountController.text) ?? 0.0,
//       "address": {
//         "street": _addressController.text,
//         "landmark": _landmarkController.text,
//         "addressLine1": _addressController.text,
//         "addressLine2": _address2Controller.text,
//         "city": _cityController.text,
//         "state": "Unknown",
//         "zip": _zipCodeController.text,
//         "specialInstructions": ""
//       },
//       "name": _nameController.text,
//       "email": _emailController.text,
//       "phone": _phoneController.text,
//       "date": selectedDate!,
//       "time": selectedTime,
//     };

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/bookings?status=&type'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(bookingData),
//       );

//       if (response.statusCode == 201) {
//         Fluttertoast.showToast(msg: "Booking successful!");
//         await Future.delayed(const Duration(seconds: 1));
//         await Get.find<HomeController>().fetchBusinessSummary(
//           DateFormat('yyyy-MM-dd').format(DateTime.now()),
//           DateFormat('yyyy-MM-dd')
//               .format(DateTime.now().subtract(Duration(days: 7))),
//         );
//         Navigator.of(context).popUntil((route) => route.isFirst);
//         Get.find<BookingsController>().fetchBookings("booked", "recurring");
//       } else if (response.statusCode == 409) {
//         final error = jsonDecode(response.body);
//         Fluttertoast.showToast(
//             msg: "Conflict: ${error['message'] ?? 'Slot already booked'}");
//       } else {
//         Fluttertoast.showToast(msg: "Failed to book: ${response.statusCode}");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error: $e");
//     } finally {
//       setState(() {
//         _isSubmitting = false;
//       });
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   String _getNextRecurringDate() {
//     DateTime? baseDate;

//     // Determine the base date either from pickedDate or selectedDate
//     if (pickedDate != null) {
//       baseDate = pickedDate;
//     } else if (selectedDate != null) {
//       try {
//         baseDate = DateFormat('yyyy-MM-dd').parse(selectedDate!);
//       } catch (e) {
//         print("Date parsing error: $e");
//       }
//     }

//     // If baseDate still null, return empty
//     if (baseDate == null) {
//       print(
//           "baseDate is null: pickedDate=$pickedDate, selectedDate=$selectedDate");
//       return "";
//     }

//     // Determine intervalDays using recurringType
//     final recurringType = widget.recurringType.trim().toLowerCase();
//     int intervalDays;

//     // FIX: Reverse logic as you intended
//     if (recurringType == 'recurring') {
//       intervalDays = 14; // Treat 'recurring' as biweekly
//     } else if (recurringType == 'biweekly') {
//       intervalDays = 7; // Treat 'biweekly' as weekly
//     } else {
//       intervalDays = widget.recurringDuration;
//     }

//     print(">>> Raw recurringType: '$recurringType'");
//     print(">>> Interval Days set to: $intervalDays");

//     if (intervalDays == 0) return "";

//     final nextDate = baseDate.add(Duration(days: intervalDays));
//     final formattedNextDate = DateFormat('EEEE, MM-dd-yyyy').format(nextDate);

//     print(">>> NextRecurringDate: $formattedNextDate");
//     return formattedNextDate;
//   }
// }
