// import 'package:fest_ticketing/common/bloc/authentication/authentication_event.dart';
// import 'package:fest_ticketing/common/bloc/authentication/authentication_state.dart';
// import 'package:fest_ticketing/common/helpers/navigator/app_navigator.dart';
// import 'package:fest_ticketing/core/main_menu/bloc/main_menu_bloc.dart';
// import 'package:fest_ticketing/core/main_menu/screen/main_menu.dart';
// import 'package:fest_ticketing/domain/authentication/enities/user.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fest_ticketing/common/bloc/authentication/authentication_bloc.dart';
// import 'package:fest_ticketing/presentation/eo/screen/event_organizer.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, authState) {
//         if (authState is Authenticated) {
//           final user = authState.user;

//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.white,
//               elevation: 0,
//               actions: [
//                 TextButton(
//                   onPressed: () {},
//                   child: const Text(
//                     'Edit',
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontSize: 16,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             body: SingleChildScrollView(
//                 child: Column(
//               children: [
//                 const SizedBox(height: 20),
//                 // Profile Image
//                 Center(
//                   child: Stack(
//                     children: [
//                       CircleAvatar(
//                         radius: 50,
//                         backgroundColor: Colors.grey[200],
//                         backgroundImage: AssetImage(
//                             // user.profileImageUrl ??
//                             'assets/images/profile.png'), // Use user image or fallback
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 // Name
//                 Text(
//                   user.fullName ?? 'No Name',
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 // Email
//                 Text(
//                   user.email ?? 'No Email',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 // Phone
//                 Text(
//                   user.phoneNumber ?? 'No Phone',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 // Menu items
//                 _buildMenuItem(
//                   icon: Icons.theater_comedy,
//                   title: 'Event Organizer',
//                   onTap: () {
//                     // Navigate to Event Organizer page
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => EventOrganizerScreen(),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 24),
//                 // Additional Menu items
//                 _buildMenuItem(
//                   icon: Icons.list,
//                   title: 'History',
//                   onTap: () {
//                     // Navigate to History page
//                   },
//                 ),
//                 _buildMenuItem(
//                     icon: Icons.payment,
//                     title: 'Payment',
//                     onTap: () {
//                       // Payment tap
//                     }),
//                 _buildMenuItem(
//                     icon: Icons.help_outline,
//                     title: 'Help',
//                     onTap: () {
//                       // Help tap
//                     }),
//                 _buildMenuItem(
//                     icon: Icons.support_agent,
//                     title: 'Support',
//                     onTap: () {
//                       // Support tap
//                     }),
//                 const SizedBox(height: 24),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: TextButton(
//                     onPressed: () {
//                       BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
//                       context.read<MainMenuBloc>().add(const ChangeTabEvent(0));
//                       AppNavigator.pushReplacement(
//                           context, const MainMenuScreen());
//                     },
//                     child: const Text(
//                       'Sign Out',
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             )),
//           );
//         } else {
//           // If not authenticated, show a loading screen or sign-in button
//           return Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//       },
//     );
//   }

//   Widget _buildMenuItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.grey[600]),
//       title: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//       trailing: const Icon(
//         Icons.chevron_right,
//         color: Colors.grey,
//       ),
//       onTap: onTap,
//     );
//   }
// }

import 'package:fest_ticketing/presentation/profile/screen/help_support.dart';
import 'package:fest_ticketing/presentation/profile/screen/history.dart';
import 'package:fest_ticketing/presentation/profile/screen/mypayment.dart';
import 'package:fest_ticketing/presentation/profile/screen/term_and_condition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fest_ticketing/common/bloc/authentication/authentication_bloc.dart';
import 'package:fest_ticketing/common/bloc/authentication/authentication_state.dart';
import 'package:fest_ticketing/common/bloc/authentication/authentication_event.dart';
import 'package:fest_ticketing/core/main_menu/bloc/main_menu_bloc.dart';
import 'package:fest_ticketing/common/helpers/navigator/app_navigator.dart';
import 'package:fest_ticketing/core/main_menu/screen/main_menu.dart';
import 'package:fest_ticketing/presentation/eo/screen/event_organizer.dart';
import 'package:fest_ticketing/presentation/profile/screen/editprofile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is Authenticated) {
          final user = authState.user;

          return Scaffold(
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
                      _buildHeader(context, user),

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
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _buildHeader(BuildContext context, dynamic user) {
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
                user.fullName ?? 'No Name',
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
              MaterialPageRoute(
                builder: (context) => EventOrganizerScreen(),
              ),
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
          BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
          context.read<MainMenuBloc>().add(const ChangeTabEvent(0));
          AppNavigator.pushReplacement(context, const MainMenuScreen());
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
