import 'package:cleanby_maria/Screens/Admin/ServiceScreen/Model/Service%20Model.dart';
import 'package:cleanby_maria/Screens/Admin/ServiceScreen/Service/ServiceController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cleanby_maria/Src/appButton.dart';

class CreateService extends StatefulWidget {
  const CreateService({super.key});

  @override
  State<CreateService> createState() => _CreateServiceState();
}

class _CreateServiceState extends State<CreateService> {
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceController>(
      builder: (_) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                    "Create Service".tr,
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _buildInputField("Service Name".tr, "Enter service name".tr,
                      _.nameController),
                  _buildInputField("Duration (minutes)".tr, "Enter duration".tr,
                      _.durationController,
                      isNumber: true),
                  _buildInputField("Base Price".tr, "Enter base price".tr,
                      _.basePriceController,
                      isNumber: true),
                  _buildInputField("Bathroom Rate".tr, "Enter bathroom rate".tr,
                      _.bathroomRateController,
                      isNumber: true),
                  _buildInputField("Room Rate".tr, "Enter room rate".tr,
                      _.roomRateController,
                      isNumber: true),
                  _buildInputField("Square Foot Price".tr,
                      "Enter square foot price".tr, _.squareFootPriceController,
                      isNumber: true),
                  SizedBox(height: 20.h),
                  _.isLoading
                      ? const CircularProgressIndicator()
                      : AppButton(
                          text: "Create Service".tr,
                          onPressed: () {
                            // final service = ServiceModel(
                            // name: _.nameController.text,
                            // durationMinutes: int.tryParse(_.durationController.text) ?? 0,
                            // basePrice: double.tryParse(_.basePriceController.text) ?? 0.0,
                            //bathroomRate: double.tryParse(_.bathroomRateController.text) ?? 0.0,
                            // roomRate: double.tryParse(_.roomRateController.text) ?? 0.0,
                            //squareFootPrice: double.tryParse(_.squareFootPriceController.text) ?? 0.0,
                            // durationMinutes: null,
                            //  );

                            _.createService(
                              context,
                            );
                          },
                        ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Center(
                        child: Text("Get Back".tr,
                            style: TextStyle(
                                fontSize: 14.sp, color: Colors.black))),
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
          style:
              GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w600),
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
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
