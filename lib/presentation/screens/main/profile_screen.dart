import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isLargeScreen ? 300 : 20,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                "assets/profile_placeholder.png",
              ), // Placeholder image
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 12),

            // User Info
            Text(
              "John Doe", // Replace with actual user data
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "john.doe@example.com", // Replace with actual user data
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),

            // User Details
            ProfileInfoTile(
              icon: Icons.phone,
              label: "Phone",
              value: "1234567890",
            ),
            ProfileInfoTile(
              icon: Icons.location_on,
              label: "Address",
              value: "Downtown street 5, New York, USA",
            ),

            const SizedBox(height: 20),

            // Your Bookings Button
            SizedBox(
              width: 150,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to bookings page
                },
                icon: const Icon(Icons.bookmark, color: Colors.white),
                label: const Text("Your Bookings"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Logout Button
            SizedBox(
              width: 150,
              child: OutlinedButton.icon(
                onPressed: () {
                  // Implement logout functionality
                },
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.red),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Profile Info Tile Widget
class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileInfoTile({
    required this.icon,
    required this.label,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: TextStyle(color: Colors.grey[600])),
      ),
    );
  }
}
