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
   bool isLoading = true;
ServiceController sRCtrl = Get.put(ServiceController());
  final TextEditingController searchController = TextEditingController();
   @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Services",
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
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                  ),
                  builder: (context) => const CreateService(),
                );
              },
              child: const Icon(Icons.add_box_rounded, color: Colors.blue, size: 30),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: GetBuilder<ServiceController>(builder: (_) {
            return Column(
              children: [
                SizedBox(height: 15.h),
                Expanded(
                  child: _.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _.services.isEmpty
                          ? const Center(child: Text("No services available"))
                          : ListView.builder(
                              itemCount: sRCtrl.services.length,
                              itemBuilder: (context, index) {
                                final service = sRCtrl.services[index];
                                return   (searchController.text.isEmpty ||
                                        service.name
                                            .toLowerCase()
                                            .contains(searchController.text))
                                    ? ServiceCard(service: service):SizedBox.shrink();
                              },
                            ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
