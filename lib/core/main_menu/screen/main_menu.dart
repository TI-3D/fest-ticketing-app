import 'package:fest_ticketing/core/main_menu/bloc/main_menu_bloc.dart';
import 'package:fest_ticketing/presentation/home/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

List<Widget> _bodyItems = [
  HomeScreen(),
  const Center(
    child: Text("Notification"),
  ),
  const Center(
    child: Text("Order"),
  ),
  const Center(
    child: Text("Profile"),
  ),
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
              BlocProvider.of<MainMenuBloc>(context).add(ChangeTabEvent(index));
            },
          ),
        );
      },
    );
  }
}
