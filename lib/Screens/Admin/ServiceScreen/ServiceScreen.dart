import 'package:cleanby_maria/Screens/Admin/ServiceScreen/Service/ServiceController.dart';
import 'package:cleanby_maria/Screens/Admin/ServiceScreen/Views/CreateService.dart';
import 'package:cleanby_maria/Screens/Admin/ServiceScreen/Views/ServiceCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final ServiceController sRCtrl = Get.put(ServiceController());
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
        backgroundColor: const Color(0xFFF3F4F6), // exact grey background
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 16, // exact left alignment
          title: Text(
            "Services",
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2C2C2C),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: InkWell(
                onTap: () {
                  sRCtrl.clearText();

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.r)),
                    ),
                    builder: (context) => CreateService(),
                  );
                },
                child: Icon(
                  Icons.add,
                  color: const Color(0xFF19A4C6),
                  size: 22.sp,
                ),
              ),
            ),
          ],
        ),

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: GetBuilder<ServiceController>(
            builder: (_) {
              return Column(
                children: [
                  SizedBox(height: 12.h),
                  Expanded(
                    child: _.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _.services.isEmpty
                            ? const Center(child: Text("No services available"))
                            : ListView.builder(
                                padding:
                                    EdgeInsets.only(bottom: 100.h, top: 4.h),
                                itemCount: _.services.length,
                                itemBuilder: (context, index) {
                                  final service = _.services[index];

                                  return (searchController.text.isEmpty ||
                                          service.name
                                              .toLowerCase()
                                              .contains(searchController.text))
                                      ? ServiceCard(service: service)
                                      : const SizedBox.shrink();
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
}
