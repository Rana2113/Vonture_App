import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/opportunity_view.dart';
import 'package:vonture_grad/features/place/presentation/views/palce_view.dart';
import 'package:vonture_grad/features/profile/presentation/views/profile_view.dart';

PersistentTabController _controller = PersistentTabController();

class HomeNavBarWidget extends StatelessWidget {
  const HomeNavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: kPrimaryColor, // Default is Colors.white.
    );
  }
}

List<Widget> _buildScreens() {
  return [
    const OpportunityView(),
    const PalceView(),
    const ProfileView(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.home,
        color: kLogoColor,
      ),
      activeColorPrimary: kShadowcColor,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        FontAwesomeIcons.plusCircle,
        color: kLogoColor,
      ),
      activeColorPrimary: kShadowcColor,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.person,
        color: kLogoColor,
      ),
      activeColorPrimary: kShadowcColor,
    ),
  ];
}
