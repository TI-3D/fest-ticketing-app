import 'package:fest_ticketing/common/bloc/authentication/authentication_bloc.dart';
import 'package:fest_ticketing/common/bloc/authentication/authentication_state.dart';
import 'package:fest_ticketing/core/main_menu/bloc/main_menu_bloc.dart';
import 'package:fest_ticketing/presentation/authentication/screen/signin.dart';
import 'package:fest_ticketing/presentation/home/screen/home.dart';
import 'package:fest_ticketing/presentation/notifications/screen/notifications.dart';
import 'package:fest_ticketing/presentation/orders/screen/orders.dart';
import 'package:fest_ticketing/presentation/profile/screen/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

List<Widget> _bodyItems = [
  const HomeScreen(),
  NotificationPage(),
  OrdersPage(),
  ProfileScreen(),
];

List<BottomNavigationBarItem> _bottomNavbarItem = [
  BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home_rounded),
      label: 'Home'),
  BottomNavigationBarItem(
      icon: Stack(
        children: [
          Icon(Icons.notifications_outlined),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              child: Text(
                '3', // Example badge count
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      activeIcon: Icon(Icons.notifications),
      label: 'Notifications'),
  BottomNavigationBarItem(
    icon: Icon(Icons.confirmation_number_outlined),
    activeIcon: Icon(Icons.confirmation_number),
    label: 'Order',
  ),
  BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'Profile'),
];

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainMenuBloc, MainMenuState>(
      builder: (context, state) {
        return Scaffold(
          body: _bodyItems[state.tabIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            // showSelectedLabels: false,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: _bottomNavbarItem,
            currentIndex: state.tabIndex,
            // selectedItemColor: Theme.of(context).primaryColor,
            selectedItemColor: Colors.redAccent,
            unselectedItemColor: Colors.grey,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            onTap: (index) {
              if (index == 3) {
                BlocProvider.of<AuthBloc>(context).state is Unauthenticated
                    ? Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SigninScreen()))
                    : BlocProvider.of<MainMenuBloc>(context)
                        .add(ChangeTabEvent(index));
              } else {
                BlocProvider.of<MainMenuBloc>(context)
                    .add(ChangeTabEvent(index));
              }
            },
          ),
        );
      },
    );
  }
}
