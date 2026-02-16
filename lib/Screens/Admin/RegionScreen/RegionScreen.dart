import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'RegionDetailsScreen.dart';
import 'Components/AddRegionBottomSheet.dart';
import 'Controllers/RegionController.dart';

class RegionScreen extends StatelessWidget {
  RegionScreen({super.key});
  RegionController ctrl = Get.put(RegionController());

  void _showAddRegionBottomSheet(BuildContext context, RegionController ctrl) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (context) => const AddRegionBottomSheet(),
    ).then((result) {
      if (result != null) {
        ctrl.fetchZones();
      }
    });
  }

  Widget _zoneCard(BuildContext context, dynamic zone) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RegionDetailsScreen(zone: zone),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F9FC),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    zone.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: zone.isActive
                        ? const Color(0xFFE6F4EA)
                        : const Color(0xFFFDECEA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    zone.isActive ? "Active" : "Inactive",
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          zone.isActive ? const Color(0xFF2E7D32) : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Code: ${zone.code}",
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "${zone.count.pincodes} pincodes · "
              "${zone.count.staff} staff · "
              "${zone.count.bookings} bookings",
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ctrl.fetchZones();
    return GetBuilder<RegionController>(
      builder: (ctrl) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              "Regions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: InkWell(
                  onTap: () => _showAddRegionBottomSheet(context, ctrl),
                  child: const Icon(
                    Icons.add,
                    color: Colors.blue,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: ctrl.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF17A5C6),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ctrl.zones.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.map_outlined,
                                  size: 64,
                                  color: Colors.grey.shade300,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No regions yet',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Tap the + button to create your first region',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: ctrl.zones.length,
                            itemBuilder: (context, index) {
                              final zone = ctrl.zones[index];
                              return _zoneCard(context, zone);
                            },
                          ),
                  ),
          ),
        );
      },
    );
  }
}
