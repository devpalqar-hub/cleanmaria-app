import 'package:cleanby_maria/Screens/Admin/RegionScreen/RegionScreen.dart';
import 'package:cleanby_maria/Screens/Admin/StaffScreen/Models/StaffModel.dart';
import 'package:cleanby_maria/Screens/Admin/StaffScreen/Service/Controller.dart';
import 'package:cleanby_maria/Screens/Admin/StaffScreen/Views/EditBottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Views/CreateBottomsheet.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  final StaffController stCtrl = Get.put(StaffController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        /// APP BAR
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: 16,
          title: Text(
            "Staff",
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          actions: [
            /// REGION
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: InkWell(
                onTap: () {
                  Get.to(
                    () => RegionScreen(),
                    transition: Transition.rightToLeft,
                  );
                },
                child: Icon(
                  Icons.location_on,
                  color: Colors.blue,
                  size: 22.sp,
                ),
              ),
            ),

            /// ADD STAFF
            Padding(
              padding: EdgeInsets.only(right: 16.w),
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
                child: Icon(
                  Icons.add,
                  color: Colors.blue,
                  size: 22.sp,
                ),
              ),
            ),
          ],
        ),

        /// BODY
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: GetBuilder<StaffController>(
            builder: (_) {
              if (_.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (_.staffList.isEmpty) {
                return Center(
                  child: Text(
                    "No staff available",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                );
              }

              return Column(
                children: [
                  SizedBox(height: 12.h),

                  /// HEADER ROW
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          "NAME",
                          style: _headerStyle(),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: Text(
                          "PRIORITY",
                          textAlign: TextAlign.center,
                          style: _headerStyle(),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: Text(
                          "STATUS",
                          textAlign: TextAlign.center,
                          style: _headerStyle(),
                        ),
                      ),

                      /// ACTION COLUMN
                      SizedBox(
                        width: 40.w,
                        child: Text(
                          "",
                          textAlign: TextAlign.center,
                          style: _headerStyle(),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  Divider(color: const Color(0xFFF1F1F1)),

                  /// LIST
                  Expanded(
                    child: ListView.builder(
                      itemCount: _.staffList.length,
                      itemBuilder: (context, index) {
                        final Staff staff = _.staffList[index];
                        final bool isActive =
                            staff.status.toLowerCase() == "active";

                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              child: Row(
                                children: [
                                  /// NAME COLUMN
                                  Expanded(
                                    flex: 4,
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 12.r,
                                          backgroundColor:
                                              const Color(0xFFF2F2F2),
                                          child: Text(
                                            staff.name.isNotEmpty
                                                ? staff.name[0].toUpperCase()
                                                : '',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: const Color(0xFF1F2937),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                staff.name,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(height: 2.h),
                                              Text(
                                                staff.email,
                                                style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color: Colors.grey,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  /// PRIORITY
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      staff.priority.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),

                                  /// STATUS
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 4.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isActive
                                              ? const Color(0xFFE6F4EA)
                                              : const Color(0xFFF1F1F1),
                                          borderRadius:
                                              BorderRadius.circular(14.r),
                                        ),
                                        child: Text(
                                          staff.status,
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: isActive
                                                ? const Color(0xFF2E7D32)
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  /// ACTION MENU (FIXED)
                                  SizedBox(
                                    width: 40.w,
                                    height: 40.h,
                                    child: PopupMenuButton<String>(
                                      icon: Icon(
                                        Icons.more_vert,
                                        size: 20.sp,
                                      ),
                                      onSelected: (value) {
                                        switch (value) {
                                          case "Edit":
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (_) =>
                                                  EditStaffBottomSheet(
                                                staff: staff,
                                              ),
                                            );
                                            break;

                                          case "Enable":
                                            stCtrl.enableStaff(staff.id);
                                            break;

                                          case "Disable":
                                            stCtrl.disableStaff(staff.id);
                                            break;

                                          case "Delete":
                                            stCtrl.deleteStaff(staff);
                                            break;
                                        }
                                      },
                                      itemBuilder: (_) => [
                                        const PopupMenuItem(
                                          value: "Edit",
                                          child: Text("Edit"),
                                        ),
                                        if (!isActive)
                                          const PopupMenuItem(
                                            value: "Enable",
                                            child: Text("Enable"),
                                          ),
                                        if (isActive)
                                          const PopupMenuItem(
                                            value: "Disable",
                                            child: Text("Disable"),
                                          ),
                                        const PopupMenuItem(
                                          value: "Delete",
                                          child: Text("Delete"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: const Color(0xFFF1F1F1),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  TextStyle _headerStyle() {
    return TextStyle(
      fontSize: 11.sp,
      color: Colors.grey,
      fontWeight: FontWeight.w500,
    );
  }
}
