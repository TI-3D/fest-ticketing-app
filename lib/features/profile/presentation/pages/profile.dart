import 'package:fest_ticketing/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:fest_ticketing/features/event_organizer/presentation/pages/event_organizer.dart';
// import 'package:fest_ticketing/presentation/profile/screen/event_request_page.dart';
import 'package:fest_ticketing/presentation/profile/screen/help_support.dart';
import 'package:fest_ticketing/presentation/profile/screen/history.dart';
import 'package:fest_ticketing/presentation/profile/screen/mypayment.dart';
import 'package:fest_ticketing/presentation/profile/screen/term_and_condition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fest_ticketing/core/main_menu/bloc/main_menu_bloc.dart';
import 'package:fest_ticketing/common/helpers/navigator/app_navigator.dart';
import 'package:fest_ticketing/core/main_menu/screen/main_menu.dart';
// import 'package:fest_ticketing/presentation/eo/screen/event_organizer.dart';
import 'package:fest_ticketing/presentation/profile/screen/editprofile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState is AuthInitial) {
          // Logout successful
          context.read<MainMenuBloc>().add(const ChangeTabEvent(0));
          AppNavigator.pushReplacement(context, const MainMenuScreen());

          // Optionally, show a Snackbar to inform the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 8),
                  Text('Successfully logged out!'),
                ],
              ),
              backgroundColor: Colors.blue,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        } else if (authState is AuthFailure) {
          // Handle logout failure
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(child: Text("Logout Failed: ${authState.message}")),
                ],
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              // Background Gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.red.shade50,
                      Colors.red.shade100,
                    ],
                  ),
                ),
              ),

              // Main Content
              Column(
                children: [
                  // Header
                  _buildHeader(context),

                  // Profile Menu
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, -3),
                          ),
                        ],
                      ),
                      child: _buildProfileMenu(context),
                    ),
                  ),
                ],
              ),

              // Logout Button
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: _buildLogoutButton(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Profile',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade900,
                ),
              ),
              Text(
                'User Name', // Replace with actual user name from the state
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red.shade700,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                Icons.edit,
                color: Colors.red.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileMenu(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      children: [
        _buildProfileMenuItem(
          icon: Icons.theater_comedy,
          title: 'Event Organizer',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventOrganizerScreen()),
            );
          },
        ),
        SizedBox(height: 15),
        _buildProfileMenuItem(
          icon: Icons.history,
          title: 'History',
          onTap: () {
            // Navigate to History page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => History(),
              ),
            );
          },
        ),
        SizedBox(height: 15),
        _buildProfileMenuItem(
          icon: Icons.payment,
          title: 'Payment Methods',
          onTap: () {
            // Payment methods page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Mypayment(),
              ),
            );
          },
        ),
        SizedBox(height: 15),
        _buildProfileMenuItem(
          icon: Icons.description,
          title: 'Term & Condition',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TermsAndConditionsScreen()),
          ),
        ),
        SizedBox(height: 15),
        _buildProfileMenuItem(
          icon: Icons.help_outline,
          title: 'Help & Support',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const HelpSupportScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildProfileMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: Colors.red.shade700,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.red.shade900,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.red.shade700,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () {
          // Dispatch sign-out event
          BlocProvider.of<AuthBloc>(context).add(AuthSignOut());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade400,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Sign Out',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
