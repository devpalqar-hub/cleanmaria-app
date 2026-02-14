import 'package:flutter/material.dart';

class RegionDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> zone;

  const RegionDetailsScreen({super.key, required this.zone});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> pincodes = zone["pincodes"] ?? [];
    final List<dynamic> staff = zone["staff"] ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(zone["name"]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              zone["name"],
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),

            Text(
              zone["code"],
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pincodes",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: const [
                      Icon(Icons.add, size: 18),
                      SizedBox(width: 4),
                      Text("Add Pincode"),
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: 12),

            ...pincodes.map((p) => _cardItem(
              title: p["code"],
            )),

            if (pincodes.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text("No pincodes available"),
              ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Staff",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: const [
                      Icon(Icons.add, size: 18),
                      SizedBox(width: 4),
                      Text("Add Staff"),
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: 12),

            ...staff.map((s) => _cardItem(
              title: s["name"],
              subtitle: s["email"],
            )),

            if (staff.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text("No staff assigned"),
              ),

            const SizedBox(height: 30),

            Text(
              "Bookings ${zone["_count"]?["bookings"] ?? 0}",
              style: const TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 30),

            Container(
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFFDECEA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Delete Zone",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardItem({
    required String title,
    String? subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
          horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight:
                      FontWeight.w500),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey),
                  ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit, size: 18),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete,
                  size: 18,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
