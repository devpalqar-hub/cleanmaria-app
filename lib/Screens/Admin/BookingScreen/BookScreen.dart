import 'dart:convert';
import 'package:cleanby_maria/Screens/Admin/ClientScreen/Service/BookingController.dart';
import 'package:cleanby_maria/Src/appButton.dart';
import 'package:cleanby_maria/Src/appTextField.dart';
import 'package:cleanby_maria/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

class ClientDetailsScreen extends StatefulWidget {
  ClientDetailsScreen({
    super.key,
    required this.Serviceid,
    required this.noofrooms,
    required this.noofbathrooms,
    required this.sizeofhome,
    required this.propertytype,
    required this.isMaterialprovided,
    required this.iseEo,
    required this.recurringType,
    required this.recurringTypeId,
    required this.price,
  });

  final String Serviceid;
  final int noofrooms;
  final int noofbathrooms;
  final int sizeofhome;
  final String propertytype;
  final bool isMaterialprovided;
  final bool iseEo;
  final String recurringTypeId;
  final String recurringType;
  final String price;
  
   

  @override
  State<ClientDetailsScreen> createState() => _ClientDetailsScreenState();
}

class _ClientDetailsScreenState extends State<ClientDetailsScreen> {
  String? selectedDay;
  String? selectedTime;
  List timeSlots = [];
  final List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
   bool isLoading = true;
@override
void initState() {
  super.initState();
  _amountController.text = widget.price;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Details',
            style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Apptextfield.primary(
                  labelText: 'First Name',
                  hintText: 'Enter First Name',
                  label: '',
                  controller: _nameController),
              Apptextfield.primary(
                  labelText: "Email",
                  hintText: "Enter Email",
                  label: '',
                  controller: _emailController),
              Apptextfield.primary(
                  labelText: "Phone",
                  hintText: "Enter Phone",
                  label: '',
                  controller: _phoneController),
              Apptextfield.primary(
                  labelText: "Address",
                  hintText: "Enter Address",
                  label: '',
                  controller: _addressController),
              Apptextfield.primary(
                  labelText: "Address 2",
                  hintText: "Enter Address Second Line",
                  label: '',
                  controller: _address2Controller),
              Apptextfield.primary(
                  labelText: "City",
                  hintText: "Enter City",
                  label: '',
                  controller: _cityController),
              Apptextfield.primary(
                  labelText: "Zip Code",
                  hintText: "Enter Zip Code",
                  label: '',
                  controller: _zipCodeController),
              Apptextfield.primary(
                  labelText: "Landmark",
                  hintText: "Enter Landmark",
                  label: '',
                  controller: _landmarkController),
              SizedBox(height: 16.h),
              _buildServiceDateCard(context),
              if (selectedDay != null && selectedTime != null)
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: Text("Selected: $selectedDay, $selectedTime",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              SizedBox(height: 20.h),
              Apptextfield.primary(
                  labelText: "Estimate Price",
                  hintText: "Current Price",
                  label: '',
                  controller: _amountController),
             SizedBox(height: 20.h),
              Center(
                child: AppButton(
                  text: "Book",
                  onPressed: _bookService,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceDateCard(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDaySelectionSheet(context),
      child: Container(
        width: 342.w,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.calendar_month,
                size: 35, color: Color(0xff19A4C6)),
            SizedBox(width: 30.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Service Date",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                Text("Tap to choose day & time",
                    style:
                        TextStyle(color: Colors.grey.shade600, fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDaySelectionSheet(BuildContext context) {
    String? tempSelectedDay;
    String? tempSelectedTime;
    bool showTimeSlots = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10))),
                  SizedBox(height: 16.h),
                  const Text("Choose a day",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16.h),
                  Wrap(
                    spacing: 10.w,
                    children: days.map((day) {
                      final isSelected = day == tempSelectedDay;
                      return ChoiceChip(
                        label: Text(day),
                        selected: isSelected,
                        onSelected: (_) {
                          setModalState(() {
                            tempSelectedDay = day;
                            showTimeSlots = true;
                            tempSelectedTime = null;
                            _fetchTimeSlots(day, setModalState);
                          });
                        },
                        selectedColor: const Color(0xff19A4C6),
                        labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black),
                      );
                    }).toList(),
                  ),
                  if (showTimeSlots) ...[
  SizedBox(height: 24.h),
  const Text("Choose a time",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  SizedBox(height: 16.h),
  if (isLoading)
    const Center(child: CircularProgressIndicator())
  else if (timeSlots.isEmpty)
    const Text("No time slots available",
        style: TextStyle(color: Colors.red))
  else
    Wrap(
      spacing: 10.w,
      children: timeSlots.map((slot) {
        final isSelected = slot["time"] == tempSelectedTime;
        return ChoiceChip(
          label: Text(slot["time"]),
          selected: isSelected,
          onSelected: (_) {
            setModalState(() {
              tempSelectedTime = slot["time"];
            });
          },
          selectedColor: const Color(0xff19A4C6),
          labelStyle:
              TextStyle(color: isSelected ? Colors.white : Colors.black),
        );
      }).toList(),
    ),
],

                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: tempSelectedDay != null &&
                            (timeSlots.isEmpty || tempSelectedTime != null)
                        ? () {
                            setState(() {
                              selectedDay = tempSelectedDay;
                              selectedTime = tempSelectedTime;
                            });
                            Navigator.pop(context);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff19A4C6),
                      padding: EdgeInsets.symmetric(
                          horizontal: 32.w, vertical: 12.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("Confirm",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _fetchTimeSlots(
      String day, void Function(void Function()) setModalState) async {
      final int dayOfWeek = days.indexOf(day);
      setModalState(() {
    isLoading = true;
    timeSlots.clear();
  });

    final uri =
        Uri.parse('${baseUrl}/scheduler/time-slots?dayOfWeek=$dayOfWeek');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setModalState(() {
          timeSlots = data['data']
              .where((slot) => slot['isAvailable'] == true)
              .toList();
               setModalState(() {
        timeSlots = timeSlots;
        isLoading = false;
      });
        });
      } else {
        setModalState(() {
        timeSlots = [];
        isLoading = false;
      });
      }
    } catch (e) {
      setModalState(() {
      timeSlots = [];
      isLoading = false;
    });
    }
     
   
  }

  void _bookService() async {
    if (selectedDay == null || selectedTime == null) {
      Fluttertoast.showToast(msg: "Please select a day and time");
      return;
    }

    final bookingData = {
      "serviceId": widget.Serviceid,
      "type": widget.recurringType,
      "paymentMethod": "offline",
      "recurringTypeId": widget.recurringTypeId,
      "no_of_rooms": widget.noofrooms,
      "no_of_bathrooms": widget.noofbathrooms,
      "propertyType": widget.propertytype,
      "materialProvided": widget.isMaterialprovided,
      "areaSize": widget.sizeofhome,
      "isEco": widget.iseEo,
    "price": double.tryParse(_amountController.text) ?? 0.0,

      "address": {
        "street": _addressController.text,
        "landmark": _landmarkController.text,
        "addressLine1": _addressController.text,
        "addressLine2": _address2Controller.text,
        "city": _cityController.text,
        "state": "Unknown",
        "zip": _zipCodeController.text,
        "specialInstructions": ""
      },
      "name": _nameController.text,
      "email": _emailController.text,
      "phone": _phoneController.text,
      "schedule": {
        "dayOfWeek": days.indexOf(selectedDay!),
        "time": selectedTime,
      }
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/bookings?status=&type'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(bookingData),
      );

      if (response.statusCode == 201) {
        Fluttertoast.showToast(msg: "Booking successful!");

        print("Booking Payload: ${jsonEncode(bookingData)}");
        await Future.delayed(const Duration(seconds: 1));

        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        BookingsController ctrl = Get.find();
        ctrl.fetchBookings("booked", "recurring");
      } else {
        print("Booking Failed - Status Code: ${response.statusCode}");
        print("Booking Failed - Response Body: ${response.body}");
        Fluttertoast.showToast(msg: "Failed to book: ${response.statusCode}");
      }
    } catch (e) {
      print("Booking Error: $e");
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }
}
