import 'package:cleanby_maria/Screens/Admin/RegionScreen/Controllers/RegionDetailsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddStaffBottomSheet extends StatefulWidget {
  final String zoneId;
  final List<dynamic> staffList;

  const AddStaffBottomSheet({
    super.key,
    required this.zoneId,
    required this.staffList,
  });

  @override
  State<AddStaffBottomSheet> createState() => _AddStaffBottomSheetState();
}

class _AddStaffBottomSheetState extends State<AddStaffBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: GetBuilder<RegionDetailsController>(
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Assign Staff',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Staff *',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (controller.isStaffLoading)
                      const SizedBox(
                        height: 48,
                        child: Center(
                          child: SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          underline: const SizedBox(),
                          hint: Text(
                            widget.staffList.isEmpty
                                ? 'No staff available'
                                : 'Choose a staff member',
                            style: GoogleFonts.inter(
                              color: Colors.grey.shade400,
                              fontSize: 14,
                            ),
                          ),
                          value: controller.selectedStaffId,
                          onChanged: (controller.isLoading ||
                                  widget.staffList.isEmpty)
                              ? null
                              : (value) {
                                  setState(() {
                                    controller.selectedStaffId = value;
                                    if (value != null) {
                                      final staff = widget.staffList.firstWhere(
                                        (s) => s['id'] == value,
                                        orElse: () => null,
                                      );
                                      if (staff != null) {
                                        controller.selectedStaffName =
                                            staff['name'] ?? 'Unknown';
                                      }
                                    }
                                  });
                                },
                          items: widget.staffList
                              .map<DropdownMenuItem<String>>((staff) {
                            return DropdownMenuItem<String>(
                              value: staff['id'],
                              child: Text(
                                '${staff['name'] ?? 'Unknown'} (${staff['email'] ?? 'N/A'})',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: (controller.isLoading ||
                            controller.selectedStaffId == null ||
                            widget.staffList.isEmpty)
                        ? null
                        : () async {
                            final success = await controller.assignStaff(
                              widget.zoneId,
                              controller.selectedStaffId!,
                            );
                            if (success) {
                              Navigator.pop(context, true);
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF17A5C6),
                      disabledBackgroundColor: Colors.grey.shade300,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: controller.isLoading
                        ? SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white.withOpacity(0.8),
                              ),
                            ),
                          )
                        : Text(
                            'Assign Staff',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: controller.isLoading
                        ? null
                        : () {
                            controller.selectedStaffId = null;
                            controller.selectedStaffName = null;
                            Navigator.pop(context);
                          },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
