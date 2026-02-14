import 'package:flutter/material.dart';
import 'RegionDetailsScreen.dart';

class RegionScreen extends StatelessWidget {
  const RegionScreen({super.key});

  @override
  Widget build(BuildContext context) {

    
    final List<Map<String, dynamic>> zones = [
      {
        "id": "0eabb91b-2c43-41f5-9fd6-a77789cc772f",
        "name": "Downtown Manhattan",
        "code": "NYC-DT-001",
        "isActive": true,
        "createdAt": "2026-01-29T05:49:35.580Z",
        "updatedAt": "2026-01-29T05:49:35.580Z",
        "_count": {"pincodes": 1, "staff": 0, "bookings": 6}
      },
      {
        "id": "5c4f9b98-1df0-4524-93e3-28417fe1a629",
        "name": "SONA-ZONE",
        "code": "SONA-001",
        "isActive": true,
        "createdAt": "2026-02-03T05:19:10.991Z",
        "updatedAt": "2026-02-03T05:19:10.991Z",
        "_count": {"pincodes": 1, "staff": 1, "bookings": 0}
      },
      {
        "id": "7aca1b75-d387-4365-973d-137c4856c6a2",
        "name": "testzone4",
        "code": "TS04",
        "isActive": false,
        "createdAt": "2026-02-03T10:32:43.774Z",
        "updatedAt": "2026-02-03T13:35:03.115Z",
        "_count": {"pincodes": 0, "staff": 0, "bookings": 0}
      },
    ];

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
              onTap: () {},
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
            itemCount: zones.length,
            itemBuilder: (context, index) {
              final zone = zones[index];

              return _zoneCard(context, zone);
            },
          ),
        ),
      ),
    );
  }

  Widget _zoneCard(BuildContext context, Map<String, dynamic> zone) {
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
                    zone["name"],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: zone["isActive"]
                        ? const Color(0xFFE6F4EA)
                        : const Color(0xFFFDECEA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    zone["isActive"] ? "Active" : "Inactive",
                    style: TextStyle(
                      fontSize: 12,
                      color: zone["isActive"]
                          ? const Color(0xFF2E7D32)
                          : Colors.red,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              "Code: ${zone["code"]}",
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "${zone["_count"]["pincodes"]} pincodes · "
                  "${zone["_count"]["staff"]} staff · "
                  "${zone["_count"]["bookings"]} bookings",
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
}
