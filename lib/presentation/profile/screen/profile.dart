import 'package:fest_ticketing/presentation/eo/screen/event_organizer.dart';
import 'package:fest_ticketing/presentation/profile/screen/history.dart';
import 'package:fest_ticketing/presentation/profile/screen/editprofile.dart';
import 'package:fest_ticketing/presentation/profile/screen/mypayment.dart';
import 'package:fest_ticketing/presentation/profile/screen/help.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              // Navigasi ke halaman Edit Profile
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(),
                ),
              );
            },
            child: const Text(
              'Edit',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 20),
          // profile image
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  backgroundImage:
                      const AssetImage('assets/images/profile.png'),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          // name
          const Text(
            'Muhamad Anang',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // email
          Text(
            'anang123@gmail.com',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          // phone
          Text(
            '081234567890',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          // Menu item
          _buildMenuItem(
            icon: Icons.theater_comedy,
            title: 'Event Organizer',
            onTap: () {
              // Navigasi ke halaman EventRequestPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventOrganizerScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          // Menu item untuk Melihat History
          _buildMenuItem(
            icon: Icons.list,
            title: 'History',
            onTap: () {
              // Navigasi ke halaman History
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => History(),
                ),
              );
            },
          ),
          _buildMenuItem(
              icon: Icons.payment,
              title: 'Paymemt',
              onTap: () {
                // Payment tap
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Mypayment(),
                  ),
                );
              }),
          _buildMenuItem(
            icon: Icons.help_outline,
            title: 'Help',
            onTap: () {
              // Help tap
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HelpScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Sign Out',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[600]),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
