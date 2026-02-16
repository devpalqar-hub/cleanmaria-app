import 'package:cleanby_maria/Screens/Admin/RegionScreen/Components/AddPincodeBottomSheet.dart';
import 'package:cleanby_maria/Screens/Admin/RegionScreen/Components/AddStaffBottomSheet.dart';
import 'package:cleanby_maria/Screens/Admin/RegionScreen/Controllers/RegionDetailsController.dart';
import 'package:cleanby_maria/Screens/Admin/RegionScreen/Models/ZoneModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegionDetailsScreen extends StatelessWidget {
  final ZoneModel zone;

  const RegionDetailsScreen({
    super.key,
    required this.zone,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegionDetailsController>(
      init: RegionDetailsController(),
      builder: (ctrl) {
        if (!ctrl.isZoneLoading && ctrl.currentZoneId != zone.id) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ctrl.fetchZoneDetails(zone.id);
          });
        }

        final zoneData =
            ctrl.zoneDetails.isNotEmpty ? ctrl.zoneDetails : zone.toMap();
        final isActive = zoneData['isActive'] ?? zone.isActive;
        final pincodes = (zoneData['pincodes'] as List<dynamic>?) ?? [];
        final staff = (zoneData['staff'] as List<dynamic>?) ?? [];
        final assignedStaffIds = staff
            .map((s) => s['staffId'] ?? s['id'] ?? s['staff']?['id'])
            .whereType<String>()
            .toSet();
        final availableStaffList = ctrl.staffList
            .where((s) => !assignedStaffIds.contains(s['id']))
            .toList();

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: Text(
              "Zone Details",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                if (ctrl.isZoneLoading)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: LinearProgressIndicator(minHeight: 2),
                  ),
                Text(
                  zoneData['name'] ?? zone.name,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Code: ${zoneData['code'] ?? zone.code}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                // Pincodes Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pincodes",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          builder: (_) =>
                              AddPincodeBottomSheet(zoneId: zone.id),
                        ).then((result) {
                          if (result == true) {
                            ctrl.fetchZoneDetails(zone.id);
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.add, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            "Add",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                if (pincodes.isNotEmpty)
                  ...pincodes.map((p) => _cardItem(
                        context: context,
                        title: p["code"] ?? "",
                        onDelete: () {
                          // Delete pincode logic
                        },
                      ))
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "No pincodes available",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
                // Staff Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Staff",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (ctrl.isStaffLoading) {
                          return;
                        }
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          builder: (_) => AddStaffBottomSheet(
                            zoneId: zone.id,
                            staffList: availableStaffList,
                          ),
                        ).then((result) {
                          if (result == true) {
                            ctrl.fetchZoneDetails(zone.id);
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.add, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            "Add",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                if (staff.isNotEmpty)
                  ...staff.map((s) => _cardItem(
                        context: context,
                        title: s["staff"]?['name'] ?? s["name"] ?? "Unknown",
                        subtitle: s["staff"]?['email'] ?? s["email"] ?? "",
                        onDelete: () {
                          // Delete staff logic
                        },
                      ))
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "No staff assigned",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
                // Bookings Count
                Text(
                  "Bookings: ${zoneData["_count"]?['bookings'] ?? zone.count.bookings}",
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 28),
                // Delete Button
                GestureDetector(
                  onTap: ctrl.isLoading
                      ? null
                      : () {
                          _showStatusConfirmation(
                            context,
                            zone.id,
                            zoneData['name'] ?? zone.name,
                            isActive == true,
                            ctrl,
                          );
                        },
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isActive == true
                          ? const Color(0xFFFDECEA)
                          : const Color(0xFFE6F4EA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ctrl.isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                isActive == true ? Colors.red : Colors.green,
                              ),
                            ),
                          )
                        : Text(
                            isActive == true ? "Disable Zone" : "Enable Zone",
                            style: GoogleFonts.inter(
                              color:
                                  isActive == true ? Colors.red : Colors.green,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showStatusConfirmation(
    BuildContext context,
    String zoneId,
    String zoneName,
    bool isActive,
    RegionDetailsController ctrl,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          isActive ? "Disable Zone?" : "Enable Zone?",
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          isActive
              ? "This zone will be disabled and no longer available for new bookings. You can enable it later."
              : "This zone will be enabled and available for new bookings.",
          style: GoogleFonts.inter(
            fontSize: 12,
            color: Colors.grey.shade700,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              "Cancel",
              style: GoogleFonts.inter(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await ctrl.updateZone(zoneId, zoneName, !isActive);
            },
            child: Text(
              isActive ? "Disable" : "Enable",
              style: GoogleFonts.inter(
                color: isActive ? Colors.red : Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardItem({
    required BuildContext context,
    required String title,
    String? subtitle,
    required VoidCallback onDelete,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onDelete,
                icon: const Icon(
                  Icons.delete,
                  size: 16,
                  color: Colors.red,
                ),
                padding: const EdgeInsets.all(6),
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
