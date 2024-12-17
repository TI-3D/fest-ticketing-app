import 'package:fest_ticketing/common/helpers/navigator/app_navigator.dart';
import 'package:fest_ticketing/core/main_menu/bloc/main_menu_bloc.dart';
import 'package:fest_ticketing/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:fest_ticketing/features/authentication/presentation/pages/signin.dart';
import 'package:fest_ticketing/features/home/presentation/pages/home.dart';
import 'package:fest_ticketing/features/liveness_detection/presentation/pages/start_register.dart';
import 'package:fest_ticketing/presentation/notifications/screen/notifications.dart';
import 'package:fest_ticketing/presentation/orders/screen/orders.dart';
import 'package:fest_ticketing/features/profile/presentation/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

List<Widget> _bodyItems = [
  HomeScreen(),
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
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    return BlocBuilder<MainMenuBloc, MainMenuState>(
      builder: (context, state) {
        return Scaffold(
          body: _bodyItems[state.tabIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            //             showSelectedLabels: false,
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
                final state = BlocProvider.of<AuthBloc>(context).state;
                switch (state.runtimeType) {
                  case AuthLoading:
                    break;
                  case AuthSuccess:
                    BlocProvider.of<MainMenuBloc>(context)
                        .add(ChangeTabEvent(index));
                    break;
                  case AuthRegisteredUncompleted:
                    AppNavigator.push(context, StartRegister());
                    break;

                  default:
                    AppNavigator.push(context, SigninScreen());
                }
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
