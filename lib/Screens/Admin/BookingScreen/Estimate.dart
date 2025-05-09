import 'package:cleanby_maria/Screens/Admin/BookingScreen/Controller/EstimateController.dart';
import 'package:cleanby_maria/Screens/Admin/BookingScreen/PlanScreen.dart';
import 'package:cleanby_maria/Src/appButton.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EstimateScreen extends StatefulWidget {
  @override
  _EstimateScreenState createState() => _EstimateScreenState();
}

class _EstimateScreenState extends State<EstimateScreen> {
  final EstimationController _controller = EstimationController();

  List<Map<String, dynamic>> services = [];
  String? selectedServiceName;
  String? selectedServiceId;

  final List<String> sizeOfHomeOptions = List.generate(
    ((6000 - 500) ~/ 500),
    (index) {
      int start = 500 + (index * 500);
      int end = start + 500;
      return '$start-$end';
    },
  );

  final List<String> roomCountOptions = ['1', '2', '3', '4', '5+'];
  final List<String> bathRoomCountOptions = ['1', '2', '3', '4+'];
  final List<String> typeOptions = ['House', 'Studio', 'Apartment'];

  String? selectedSizeOfHome;
  String? selectedNoOfRooms;
  String? selectedNoOfBathRooms;
  String? selectedTypeOfProperty;

  bool isMaterialProvided = false;
  bool isEco = false;

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    try {
      final fetchedServices = await _controller.fetchServices();
      setState(() {
        services = fetchedServices;
      });
    } catch (e) {
      print(e);
    }
  }

  void _calculateEstimate() async {
    if (selectedServiceId == null ||
        selectedNoOfRooms == null ||
        selectedNoOfBathRooms == null ||
        selectedTypeOfProperty == null ||
        selectedSizeOfHome == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final squareFeet = int.parse(selectedSizeOfHome!.split('-')[1]);
    final noOfRooms = int.parse(selectedNoOfRooms!);
    final noOfBathrooms = int.parse(selectedNoOfBathRooms!);

    try {
      final estimates = await _controller.calculateEstimate(
        serviceId: selectedServiceId!,
        noOfRooms: noOfRooms,
        noOfBathrooms: noOfBathrooms,
        squareFeet: squareFeet,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectPlanScreen(plans: estimates),
        ),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch estimate')),
      );
    }
  }

  Widget _buildDropdownContainer({required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
 Widget _buildCircularCheckbox({
  required String label,
  required bool value,
  required Function(bool?) onChanged,
}) {
  return Row(
    children: [
      Checkbox(
        value: value,
        onChanged: onChanged,
        shape: CircleBorder(),
        side: BorderSide(color: Colors.grey), 
        activeColor: Colors.blue, 
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      SizedBox(width: 10),
      Text(label, style: TextStyle(fontSize: 14.sp)),
    ],
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Estimate",
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Size of Home", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
              _buildDropdownContainer(
                child: DropdownButtonFormField<String>(
                  value: selectedSizeOfHome,
                  decoration: InputDecoration(border: InputBorder.none),
                  hint: Text('Select Size of Home'),
                  items: sizeOfHomeOptions.map((size) {
                    return DropdownMenuItem<String>(
                      value: size,
                      child: Text(size),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSizeOfHome = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 12.h),
              Text("Type of Cleaning", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
              _buildDropdownContainer(
                child: DropdownButtonFormField<String>(
                  value: selectedServiceName,
                  decoration: InputDecoration(border: InputBorder.none),
                  hint: Text('Select Service'),
                  items: services.map((service) {
                    return DropdownMenuItem<String>(
                      value: service['name'],
                      child: Text(service['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedServiceName = value;
                      selectedServiceId = services.firstWhere((service) => service['name'] == value)['id'];
                    });
                  },
                ),
              ),
              SizedBox(height: 12.h),
              Text("Type of Property", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
              _buildDropdownContainer(
                child: DropdownButtonFormField<String>(
                  value: selectedTypeOfProperty,
                  decoration: InputDecoration(border: InputBorder.none),
                  hint: Text('Select Type of Property'),
                  items: typeOptions.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedTypeOfProperty = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 12.h),
              Text("Select Number of Rooms", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
              _buildDropdownContainer(
                child: DropdownButtonFormField<String>(
                  value: selectedNoOfRooms,
                  decoration: InputDecoration(border: InputBorder.none),
                  hint: Text('Select Number of Rooms'),
                  items: roomCountOptions.map((room) {
                    return DropdownMenuItem<String>(
                      value: room,
                      child: Text(room),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedNoOfRooms = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 12.h),
              Text("Select Number of Bathrooms", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
              _buildDropdownContainer(
                child: DropdownButtonFormField<String>(
                  value: selectedNoOfBathRooms,
                  decoration: InputDecoration(border: InputBorder.none),
                  hint: Text('Select Number of Bathrooms'),
                  items: bathRoomCountOptions.map((bathroom) {
                    return DropdownMenuItem<String>(
                      value: bathroom,
                      child: Text(bathroom),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedNoOfBathRooms = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 24.h),
              Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    _buildCircularCheckbox(
      label: "Material Provided",
      value: isMaterialProvided,
      onChanged: (val) => setState(() => isMaterialProvided = val ?? false),
    ),
    _buildCircularCheckbox(
      label: "Is Eco",
      value: isEco,
      onChanged: (val) => setState(() => isEco = val ?? false),
    ),
  ],
),    
              SizedBox(height: 60.h),
              Center(
                child: AppButton(
                  text: "Calculate",
                  onPressed: _calculateEstimate,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
