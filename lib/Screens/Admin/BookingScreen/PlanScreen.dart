import 'package:cleanby_maria/Screens/Admin/BookingScreen/BookScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Estimate.dart';

class SelectPlanScreen extends StatefulWidget {
  final List<Map<String, dynamic>> plans;

  const SelectPlanScreen({Key? key, required this.plans}) : super(key: key);

  @override
  _SelectPlanScreenState createState() => _SelectPlanScreenState();
}

class _SelectPlanScreenState extends State<SelectPlanScreen> {
  int? selectedPlanIndex;

  void _continueToBooking() {
    if (selectedPlanIndex != null) {
      final selectedPlan = widget.plans[selectedPlanIndex!];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClientDetailsScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Plan', style: TextStyle(fontWeight: FontWeight.w600)),
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
              itemCount: widget.plans.length,
              itemBuilder: (context, index) {
                final plan = widget.plans[index];
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
                      color: isSelected ? Colors.blue.shade50 : Colors.grey.shade200,
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
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$ ${plan['finalPrice']}",
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              "/Cleaning",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          plan['description'] ?? 'Instant booking for a single date/time',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade800,
                          ),
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
                  onPressed: _continueToBooking,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
