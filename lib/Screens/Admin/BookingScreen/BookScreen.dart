import 'package:cleanby_maria/Src/appButton.dart';
import 'package:cleanby_maria/Src/appTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientDetailsScreen extends StatefulWidget {
  const ClientDetailsScreen({super.key});

  @override
  State<ClientDetailsScreen> createState() => _ClientDetailsScreenState();
}

class _ClientDetailsScreenState extends State<ClientDetailsScreen> {
  String? selectedDay;
  String? selectedTime;

  final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final List<String> timeSlots = ['8-9 AM', '9-10 AM', '10-11 AM', '11-12 PM'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Client Details', style: TextStyle(fontWeight: FontWeight.w600)),
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
              Apptextfield.primary(label: "", hintText: 'Enter First Name', labelText: 'First Name'),
             Apptextfield.primary(labelText: "Last Name", hintText: "Enter Last Name", label: ''),
             Apptextfield.primary(labelText: "Email", hintText: "Enter Email", label: ''),
               Apptextfield.primary(labelText: "Phone", hintText: "Enter Phone", label: ''),
               Apptextfield.primary(labelText: "Address", hintText: "Enter Address", label: ''),
               Apptextfield.primary(labelText: "Address 2", hintText: "Enter Address Second Line", label: ''),
               Apptextfield.primary(labelText: "City", hintText: "Enter City", label: ''),
               Apptextfield.primary(labelText: "Zip Code", hintText: "Enter Zip Code", label: ''),
               Apptextfield.primary(labelText: "Landmark", hintText: "Enter Landmark", label: ''),
               Apptextfield.primary(labelText: "Payment Method", hintText: "Enter Payment Method", label: ''),
              SizedBox(height: 16.h),
              _buildServiceDateCard(context),
              if (selectedDay != null && selectedTime != null)
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: Text(
                    "Selected: $selectedDay, $selectedTime",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              SizedBox(height: 20.h),
             Center(child: AppButton(text: "Book", onPressed: (){}))
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
        width: 342 .w,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.calendar_month, size: 35, color:  Color(0xff19A4C6),),
            SizedBox(width: 30.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Service Date",
                    style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16)),
                Text("Tap to choose day & time",
                    style: TextStyle(color: Colors.grey.shade600,fontSize: 14)),
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
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          List<String> availableSlots = tempSelectedDay != null
              ? timeSlots 
              : [];

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
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 16.h),
                Text("Choose a day",
                    style:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                        });
                      },
                      selectedColor: Color(0xff19A4C6),
                      labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black),
                    );
                  }).toList(),
                ),
                if (showTimeSlots) ...[
                  SizedBox(height: 24.h),
                  Text("Choose a time",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16.h),
                  if (availableSlots.isEmpty)
                    const Text("No time slots available",
                        style: TextStyle(color: Colors.red)),
                  if (availableSlots.isNotEmpty)
                    Wrap(
                      spacing: 10.w,
                      children: availableSlots.map((time) {
                        final isSelected = time == tempSelectedTime;
                        return ChoiceChip(
                          label: Text(time),
                          selected: isSelected,
                          onSelected: (_) {
                            setModalState(() {
                              tempSelectedTime = time;
                            });
                          },
                          selectedColor: Color(0xff19A4C6),
                          labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.black),
                        );
                      }).toList(),
                    ),
                ],
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: tempSelectedDay != null &&
                          (availableSlots.isEmpty || tempSelectedTime != null)
                      ? () {
                          setState(() {
                            selectedDay = tempSelectedDay;
                            selectedTime = tempSelectedTime;
                          });
                          Navigator.pop(context);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color(0xff19A4C6),
                    padding:
                        EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Confirm", style: TextStyle(fontSize: 16,color: Colors.white)),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
}