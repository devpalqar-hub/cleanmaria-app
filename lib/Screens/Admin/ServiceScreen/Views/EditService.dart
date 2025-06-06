import 'package:cleanby_maria/Screens/Admin/ServiceScreen/Model/Service%20Model.dart';
import 'package:cleanby_maria/Screens/Admin/ServiceScreen/Service/ServiceController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cleanby_maria/Src/appButton.dart';

class EditServiceBottomSheet extends StatefulWidget {
  final ServiceModel service;
  const EditServiceBottomSheet({super.key, required this.service});

  @override
  State<EditServiceBottomSheet> createState() => _EditServiceBottomSheetState();
}

class _EditServiceBottomSheetState extends State<EditServiceBottomSheet> {
  @override
  void initState() {
    super.initState();
    final controller = Get.find<ServiceController>();
    controller.nameController.text = widget.service.name ?? '';
    controller.durationController.text = widget.service.durationMinutes?.toString() ?? '';
    controller.basePriceController.text = widget.service.basePrice?.toString() ?? '';
    controller.bathroomRateController.text = widget.service.bathroomRate?.toString() ?? '';
    controller.roomRateController.text = widget.service.roomRate?.toString() ?? '';
    controller.squareFootPriceController.text = widget.service.squareFootPrice?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceController>(
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 60.w,
                      height: 5.h,
                      margin: EdgeInsets.only(bottom: 20.h),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                  Text(
                    "Edit Service",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _buildInputField("Service Name", "Enter service name", _.nameController),
                  _buildInputField("Duration (minutes)", "Enter duration", _.durationController, isNumber: true),
                  _buildInputField("Base Price", "Enter base price", _.basePriceController, isNumber: true),
                  _buildInputField("Bathroom Rate", "Enter bathroom rate", _.bathroomRateController, isNumber: true),
                  _buildInputField("Room Rate", "Enter room rate", _.roomRateController, isNumber: true),
                  _buildInputField("Square Foot Price", "Enter square foot price", _.squareFootPriceController, isNumber: true),
                  SizedBox(height: 20.h),
                  _.isLoading
                      ? const CircularProgressIndicator()
                      : AppButton(
                          text: "Update Service",
                          onPressed: () {
                          _.updateService(widget.service.id, context); 
                          },
                        ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 14.sp, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputField(
    String label,
    String hint,
    TextEditingController controller, {
    bool isNumber = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 5.h),
        TextFormField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
