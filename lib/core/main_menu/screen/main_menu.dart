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
  const BottomNavigationBarItem(icon: Icon(Iconsax.home_2), label: ""),
  const BottomNavigationBarItem(
      icon: Icon(Iconsax.notification_bing), label: ""),
  const BottomNavigationBarItem(icon: Icon(Iconsax.receipt), label: ""),
  const BottomNavigationBarItem(icon: Icon(Iconsax.user), label: ""),
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
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: _bottomNavbarItem,
            currentIndex: state.tabIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey,
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
