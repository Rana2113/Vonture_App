import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/features/application/presentation/managers/cubit/application_cubit.dart';
import 'package:vonture_grad/features/application/presentation/views/application_view.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/opportunity_view.dart';
import 'package:vonture_grad/features/place/presentation/views/place_view.dart';
import 'package:vonture_grad/features/profile/presentation/views/profile.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vonture_grad/core/constants.dart/api_constants.dart';

PersistentTabController _controller = PersistentTabController();

class HomeNavBarWidget extends StatefulWidget {
  const HomeNavBarWidget({Key? key}) : super(key: key);

  @override
  _HomeNavBarWidgetState createState() => _HomeNavBarWidgetState();
}

class _HomeNavBarWidgetState extends State<HomeNavBarWidget> {
  List<Widget> _screens = [];
  List<PersistentBottomNavBarItem> _items = [];

  @override
  void initState() {
    super.initState();
    _updateScreensAndItems();
  }

  void _updateScreensAndItems() {
    final userRoleBox = Hive.box(kRoleBoxString);
    String? role = userRoleBox.get(kRoleBoxString);

    setState(() {
      _screens = _buildScreens(role);
      _items = _navBarsItems(role);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _screens,
      items: _items,
      confineInSafeArea: true,
      backgroundColor: kPrimaryColor, // Default is Colors.white.
    );
  }

  List<Widget> _buildScreens(String? role) {
    final List<Widget> screens = [
      const OpportunityView(),
      const ProfileView(),
    ];

    if (role == 'TOURIST') {
      screens.insert(1, const ApplicationView());
    } else if (role == 'HOST') {
      screens.insert(1, const PalceView());
    }

    return screens;
  }

  List<PersistentBottomNavBarItem> _navBarsItems(String? role) {
    final List<PersistentBottomNavBarItem> items = [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.home,
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

    if (role == 'TOURIST') {
      items.insert(
        1,
        PersistentBottomNavBarItem(
          icon: const Icon(
            FontAwesomeIcons.plusCircle,
            color: kLogoColor,
          ),
          onPressed: (context) {
            _controller.jumpToTab(1); // Navigate to the ApplicationView tab
            context?.read<ApplicationCubit>().getallopportunity();
          },
          activeColorPrimary: kShadowcColor,
        ),
      );
    } else if (role == 'HOST') {
      items.insert(
        1,
        PersistentBottomNavBarItem(
          icon: const Icon(
            FontAwesomeIcons.plusSquare,
            color: kLogoColor,
          ),
          activeColorPrimary: kShadowcColor,
        ),
      );
    }

    return items;
  }
}
