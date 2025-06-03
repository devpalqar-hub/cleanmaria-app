import 'dart:convert';

import 'package:cleanby_maria/Screens/Admin/HistoryScreen/Controller/HistoryController.dart';
import 'package:cleanby_maria/Screens/staff/Controller/SHomeController.dart';
import 'package:cleanby_maria/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/instance_manager.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A professional bottom sheet for changing booking status.
class BookingStatusBottomSheet extends StatefulWidget {
  final String currentStatus;
  String sheduleID;
  final Function(String) onStatusChanged;
  bool isStaff;

  BookingStatusBottomSheet(
      {Key? key,
      required this.currentStatus,
      required this.onStatusChanged,
      required this.sheduleID,
      this.isStaff = false})
      : super(key: key);

  @override
  State<BookingStatusBottomSheet> createState() =>
      _BookingStatusBottomSheetState();
}

class _BookingStatusBottomSheetState extends State<BookingStatusBottomSheet> {
  late String selectedStatus;

  // Status options

  bool isLoading = false;
  List<Map<String, dynamic>> _statusOptions = [];

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.currentStatus;

    _statusOptions = [
      if (!widget.isStaff)
        {
          'status': 'scheduled',
          'icon': Icons.event_note,
          'color': Colors.blueAccent,
        },
      {
        'status': 'missed',
        'icon': Icons.event_busy,
        'color': Colors.red,
      },
      if (!widget.isStaff)
        {
          'status': 'refunded',
          'icon': Icons.money_off,
          'color': Colors.amber,
        },
      {
        'status': 'completed',
        'icon': Icons.event_available_rounded,
        'color': Colors.green,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

        
          Text('Change  Status',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),

          const SizedBox(height: 24),
          ...(_statusOptions.map((option) => _buildStatusOption(
                option['status'],
                option['icon'],
                option['color'],
              ))),
          const SizedBox(height: 24),

          // Save button
          ElevatedButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              final token = prefs.getString("access_token");
              setState(() {
                isLoading = true;
              });
              final response = await patch(
                  Uri.parse(baseUrl +
                      "/scheduler/schedules/${widget.sheduleID}/change-status"),
                  headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer $token',
                  },
                  body: json.encode({"status": selectedStatus}));

              setState(() {
                isLoading = false;
              });
              print(response.body);
              print(response.statusCode);
              if (response.statusCode == 200) {
                widget.onStatusChanged(selectedStatus);

                Navigator.pop(context);
              } else {
                Fluttertoast.showToast(msg: 'Update Failed');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2196F3),
              padding: EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: (isLoading)
                ? LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.blue, size: 25)
                : Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 15.sp, color: Colors.white),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusOption(String status, IconData icon, Color color) {
    final isSelected = selectedStatus == status;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedStatus = status;
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? color : Colors.grey.shade300,
              width: 1.5,
            ),
            color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
          ),
          child: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 16),
              Text(status.toString().capitalize ?? "",
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500)),
              const Spacer(),
              if (isSelected)
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
