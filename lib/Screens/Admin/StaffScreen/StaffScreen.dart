import 'package:cleanby_maria/Screens/Admin/StaffScreen/Models/StaffModel.dart';
import 'package:cleanby_maria/Screens/Admin/StaffScreen/Service/Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'StaffCard.dart';
import 'Views/CreateBottomsheet.dart';
import 'Views/EditBottomsheet.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  bool isLoading = true;
  StaffController stCtrl = Get.put(StaffController());
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Staffs",
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20.r)),
                      ),
                      builder: (context) => CreateStaffBottomSheet(),
                    );
                  },
                  //  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.add_box_rounded,
                    color: Colors.blue,
                    size: 30,
                  ),
                )
                //  ElevatedButton.icon(
                //   icon: Icon(Icons.add, color: Colors.white, size: 16.sp),
                //   label: Text(
                //     "Create Staff",
                //     style: TextStyle(
                //       fontSize: 10.sp,
                //       fontWeight: FontWeight.w600,
                //       color: Colors.white,
                //     ),
                //   ),
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.blue,
                //     minimumSize: Size(105.w, 27.h),
                //   ),
                //   onPressed: () {

                // ),
                ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: GetBuilder<StaffController>(builder: (_) {
              return Column(
                children: [
                  SizedBox(height: 15.h),
                  Expanded(
                    child: _.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : _.staffList.isEmpty
                            ? Center(
                                child: Text(
                                  "No staff available",
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              )
                            : ListView.builder(
                                itemCount: stCtrl.staffList.length,
                                itemBuilder: (context, index) {
                                  final staff = stCtrl.staffList[index];
                                  return (searchController.text.isEmpty ||
                                          staff.name
                                              .toLowerCase()
                                              .contains(searchController.text))
                                      ? StaffCard(
                                          staff: staff,
                                        )
                                      : null;
                                },
                              ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
