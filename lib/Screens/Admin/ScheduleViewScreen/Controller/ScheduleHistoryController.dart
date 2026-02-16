import 'dart:convert';
import 'dart:developer';

import 'package:cleanby_maria/Screens/Admin/ScheduleViewScreen/Models/ScheduleItemModel.dart';
import 'package:cleanby_maria/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ScheduleHistoryController extends GetxController {
  // Data
  List<ScheduleItemModel> schedules = [];

  // Filters
  String? selectedBookingId;
  String? selectedStaffId;
  DateTime? startDate;
  DateTime? endDate;

  // Pagination
  int currentPage = 1;
  int pageLimit = 10;
  int totalPages = 1;

  // Loading states
  bool isLoading = false;
  bool isPaginationLoading = false;
  bool hasMoreData = false;

  // Scroll controller
  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
    // Set default date range: tomorrow to 45 days from today
    startDate = DateTime.now().add(const Duration(days: 1));
    endDate = DateTime.now().add(const Duration(days: 45));
    // Load initial data
    fetchSchedules();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isPaginationLoading &&
        hasMoreData) {
      loadMoreSchedules();
    }
  }

  Future<void> fetchSchedules({bool reset = true}) async {
    if (reset) {
      schedules.clear();
      currentPage = 1;
      isLoading = true;
    } else {
      isPaginationLoading = true;
    }
    update();

    try {
      // Format dates as YYYY-MM-DD
      String startDateStr =
          "${startDate!.year}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}";
      String endDateStr =
          "${endDate!.year}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}";

      // Build query parameters
      String query = '/scheduler/schedules?';
      if (selectedBookingId != null && selectedBookingId!.isNotEmpty) {
        query += 'bookingId=$selectedBookingId&';
      }
      if (selectedStaffId != null && selectedStaffId!.isNotEmpty) {
        query += 'staffId=$selectedStaffId&';
      }
      query +=
          'startDate=$startDateStr&endDate=$endDateStr&page=$currentPage&limit=$pageLimit';

      final response = await http.get(
        Uri.parse(baseUrl + query),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        final schedulesData = data['data']['data'] ?? [];
        final meta = data['data']['meta'];

        if (schedulesData is List) {
          for (var item in schedulesData) {
            schedules.add(ScheduleItemModel.fromJson(item));
          }
        }

        // Update pagination info
        if (meta != null) {
          totalPages = meta['totalPages'] ?? 1;
          hasMoreData = currentPage < totalPages;
        }

        log('Fetched ${schedulesData.length} schedules, page $currentPage of $totalPages');
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to load schedules',
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        log('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error: ${e.toString()}',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      log('Exception: $e');
    } finally {
      isLoading = false;
      isPaginationLoading = false;
      update();
    }
  }

  Future<void> loadMoreSchedules() async {
    if (hasMoreData && !isPaginationLoading) {
      currentPage++;
      await fetchSchedules(reset: false);
    }
  }

  void setBookingId(String? id) {
    selectedBookingId = id;
    update();
  }

  void setStaffId(String? id) {
    selectedStaffId = id;
    update();
  }

  void setDateRange(DateTime start, DateTime end) {
    startDate = start;
    endDate = end;
    update();
  }

  void resetFilters() {
    selectedBookingId = null;
    selectedStaffId = null;
    startDate = null;
    endDate = null;
    schedules.clear();
    currentPage = 1;
    update();
  }

  String get formattedStartDate =>
      "${startDate!.year}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}";

  String get formattedEndDate =>
      "${endDate!.year}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}";
}
