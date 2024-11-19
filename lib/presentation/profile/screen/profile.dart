import 'package:fest_ticketing/common/bloc/authentication/authentication_event.dart';
import 'package:fest_ticketing/common/bloc/authentication/authentication_state.dart';
import 'package:fest_ticketing/common/helpers/navigator/app_navigator.dart';
import 'package:fest_ticketing/core/main_menu/bloc/main_menu_bloc.dart';
import 'package:fest_ticketing/core/main_menu/screen/main_menu.dart';
import 'package:fest_ticketing/domain/authentication/enities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fest_ticketing/common/bloc/authentication/authentication_bloc.dart';
import 'package:fest_ticketing/presentation/eo/screen/event_organizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is Authenticated) {
          final user = authState.user;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                TextButton(
                  onPressed: () {},
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
                // Profile Image
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: AssetImage(
                            // user.profileImageUrl ??
                            'assets/images/profile.png'), // Use user image or fallback
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Name
                Text(
                  user.fullName ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Email
                Text(
                  user.email ?? 'No Email',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),
                // Phone
                Text(
                  user.phoneNumber ?? 'No Phone',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                // Menu items
                _buildMenuItem(
                  icon: Icons.theater_comedy,
                  title: 'Event Organizer',
                  onTap: () {
                    // Navigate to Event Organizer page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventOrganizerScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                // Additional Menu items
                _buildMenuItem(
                  icon: Icons.list,
                  title: 'History',
                  onTap: () {
                    // Navigate to History page
                  },
                ),
                _buildMenuItem(
                    icon: Icons.payment,
                    title: 'Payment',
                    onTap: () {
                      // Payment tap
                    }),
                _buildMenuItem(
                    icon: Icons.help_outline,
                    title: 'Help',
                    onTap: () {
                      // Help tap
                    }),
                _buildMenuItem(
                    icon: Icons.support_agent,
                    title: 'Support',
                    onTap: () {
                      // Support tap
                    }),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
                      context.read<MainMenuBloc>().add(const ChangeTabEvent(0));
                      AppNavigator.pushReplacement(
                          context, const MainMenuScreen());
                    },
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
        } else {
          // If not authenticated, show a loading screen or sign-in button
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
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
