import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final Color primaryGreen = const Color(0xFF2F7F6F);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔹 TITLE
            const Text(
              "Profile",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            /// 🔹 USER INFO
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                    "assets/images/profile_placeholder.png",
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Maria Gonzalez",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "maria.gonzalez@example.com",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Edit Profile",
                      style: TextStyle(
                        color: Color(0xFF2F7F6F),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// 🔹 OPTIONS CARD
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _item(Icons.person_outline, "Personal Information"),
                  _divider(),
                  _item(Icons.home_outlined, "Saved Addresses"),
                  _divider(),
                  _item(Icons.credit_card_outlined, "Payment Methods"),
                  _divider(),
                  _item(Icons.notifications_none, "Notifications"),
                  _divider(),
                  _item(Icons.lock_outline, "Privacy & Security"),
                  _divider(),
                  _item(Icons.settings_outlined, "App Settings"),
                  _divider(),
                  _item(Icons.help_outline, "Help & Support"),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// 🔹 LOG OUT
            Row(
              children: const [
                Icon(Icons.logout, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// 🔹 VERSION
            const Center(
              child: Text(
                "Version 1.0.0",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 ITEM ROW
  Widget _item(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(text),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }

  Widget _divider() {
    return const Divider(height: 1);
  }
}
