import 'package:cleanby_maria/Screens/Admin/BookingScreen/BookScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectPlanScreen extends StatefulWidget {
  final List<Map<String, dynamic>> plans;
  final int totalDuration;
  final String Serviceid;
  final int noofrooms;
  final int noofbathrooms;
  final int sizeofhome;
  final String propertytype;
  final bool isMaterialprovided;
  final bool iseEo;

  const SelectPlanScreen({
    Key? key,
    required this.plans,
    required this.Serviceid,
    required this.noofrooms,
    required this.noofbathrooms,
    required this.sizeofhome,
    required this.propertytype,
    required this.isMaterialprovided,
    required this.iseEo,
    required this.totalDuration,
  }) : super(key: key);

  @override
  _SelectPlanScreenState createState() => _SelectPlanScreenState();
}

class _SelectPlanScreenState extends State<SelectPlanScreen> {
  int? selectedPlanIndex;

  @override
  Widget build(BuildContext context) {
    // final filteredPlans = widget.plans
    //   .where((plan) => plan['recurringTypeId'] != null)
    // .toList();
    final filteredPlans = widget.plans
        .where((plan) => plan['recurringTypeId'] != "notASubcriptionTypeId")
        .toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select Plan',
              style: TextStyle(fontWeight: FontWeight.w600)),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0.5,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredPlans.length,
                itemBuilder: (context, index) {
                  final plan = filteredPlans[index];
                  final isSelected = selectedPlanIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPlanIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.blue.shade50
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plan['title'] ?? '',
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$ ${plan['finalPrice']}",
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                "/Cleaning",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            plan['description'] ??
                                'Instant booking for a single date/time',
                            style: TextStyle(
                                fontSize: 14.sp, color: Colors.grey.shade800),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (selectedPlanIndex != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final selectedPlan = filteredPlans[selectedPlanIndex!];
                      //  final int duration = selectedPlan['totalDuration'] ?? selectedPlan['durationInMinutes'] ?? 60;
                      print(selectedPlan);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClientDetailsScreen(
                            Serviceid: widget.Serviceid,
                            sizeofhome: widget.sizeofhome,
                            noofbathrooms: widget.noofbathrooms,
                            noofrooms: widget.noofrooms,
                            propertytype: widget.propertytype,
                            iseEo: widget.iseEo,
                            recurringDuration:
                                ("Bi-Weekly" == selectedPlan["title"])
                                    ? 7
                                    : 14, //selectedPlan["day_frequency"],
                            isMaterialprovided: widget.isMaterialprovided,
                            price: selectedPlan["finalPrice"].toString(),
                            recurringTypeId: selectedPlan["recurringTypeId"],
                            recurringType: selectedPlan["recurringTypeId"] ==
                                    "notASubcriptionTypeId"
                                ? "instant"
                                : "recurring",
                            totalDuration: widget.totalDuration,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
