import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/features/application/presentation/managers/cubit/application_cubit.dart';
import 'package:vonture_grad/features/application/presentation/views/application_view.dart';
import 'package:vonture_grad/features/opportunity/presentation/managers/cubit/opportunity_cubit.dart';
import 'package:vonture_grad/features/opportunity/presentation/views/opportunity_view.dart';
import 'package:vonture_grad/features/place/presentation/manager/cubit/place_cubit.dart';
import 'package:vonture_grad/features/place/presentation/views/place_view.dart';
import 'package:vonture_grad/features/profile/presentation/views/profile.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vonture_grad/core/constants.dart/api_constants.dart';

PersistentTabController _controller = PersistentTabController();

class HomeNavBarWidget extends StatefulWidget {
  const HomeNavBarWidget({super.key});

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
      backgroundColor: white,
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
      screens.insert(1, const MyPalceView());
    }

    return screens;
  }

  List<PersistentBottomNavBarItem> _navBarsItems(String? role) {
    final List<PersistentBottomNavBarItem> items = [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.home,
          color: PrimaryColor,
        ),
        onPressed: (context) {
          _controller.jumpToTab(0);
          context?.read<OpportunityCubit>().getallopportunity();
        },
        activeColorPrimary: PrimaryColor.withOpacity(0.3),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.person,
          color: PrimaryColor,
        ),
        onPressed: (context) {
          _controller.jumpToTab(2);
          context?.read<PlaceCubit>().getUserData();
        },
        activeColorPrimary: PrimaryColor.withOpacity(0.3),
      ),
    ];

    if (role == 'TOURIST') {
      items.insert(
        1,
        PersistentBottomNavBarItem(
          icon: const Icon(
            FontAwesomeIcons.fileCircleCheck,
            color: PrimaryColor,
          ),
          onPressed: (context) {
            _controller.jumpToTab(1);
            context?.read<ApplicationCubit>().getMyApplications();
          },
          activeColorPrimary: PrimaryColor.withOpacity(0.3),
        ),
      );
    } else if (role == 'HOST') {
      items.insert(
        1,
        PersistentBottomNavBarItem(
          icon: const Icon(
            FontAwesomeIcons.mapLocationDot,
            color: PrimaryColor,
          ),
          onPressed: (context) {
            final userid = Hive.box(kidBoxString).get(kidBoxString);
            _controller.jumpToTab(1);
            context?.read<PlaceCubit>().getmyplace(userid);
          },
          activeColorPrimary: PrimaryColor.withOpacity(0.3),
        ),
      );
    }

    return items;
  }
}
