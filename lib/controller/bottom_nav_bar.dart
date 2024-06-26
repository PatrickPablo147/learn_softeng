import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering/const/colors.dart';
import 'package:software_engineering/screen/add_new_quiz.dart';
import 'package:software_engineering/screen/history_screen.dart';
import 'package:software_engineering/screen/home_screen.dart';
import 'package:software_engineering/screen/quiz_screen.dart';
import 'package:software_engineering/screen/settings_screen.dart';
import 'package:software_engineering/screen/teacher_panel_screen.dart';
import 'package:software_engineering/services/auth_service.dart';
import 'package:software_engineering/services/firestore_service.dart';
import '../database/data_manager.dart';
/* PATTY DEVS
* Summary:
* This handles the state of App Navigation
* Switching to: Home Page
*               Quiz Page
*               History Page
*             & Settings Page
* */


class MyBottomNavBar extends StatelessWidget {
  static final PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  static PersistentTabController get controller => _controller;
  final FirestoreService firestoreService = FirestoreService();
  final AuthService authService = AuthService();

  MyBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> buildScreens() {
      return const [
        HomeScreen(),
        QuizScreen(),
        HistoryScreen(),
        SettingsScreen()
      ];
    }
    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Image.asset(
            "lib/assets/home.png",
            width: 16, height: 16,
            color: Colors.white,
          ),
          title: ("Home"),
          activeColorPrimary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset(
            "lib/assets/quiz.png",
            width: 17, height: 17,
            color: Colors.white,
          ),
          title: ("Quiz"),
          activeColorPrimary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset(
            "lib/assets/folder.png",
            width: 20, height: 20,
            color: Colors.white,
          ),
          title: ("History"),
          activeColorPrimary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset(
            "lib/assets/settings.png",
            width: 20, height: 20,
            color: Colors.white,
          ),
          title: ("Settings"),
          activeColorPrimary: Colors.white,
        ),
      ];
    }


    List<Widget> teacherBuildScreens() {
      return const [
        TeacherPanelScreen(),
        QuizScreen(),
        AddNewQuiz(),
        HistoryScreen(),
        SettingsScreen()
      ];
    }
    List<PersistentBottomNavBarItem> teacherNavBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Image.asset(
            "lib/assets/home.png",
            width: 16, height: 16,
            color: Colors.white,
          ),
          title: ("Home"),
          activeColorPrimary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset(
            "lib/assets/quiz.png",
            width: 17, height: 17,
            color: Colors.white,
          ),
          title: ("Quiz"),
          activeColorPrimary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.add),
          title: ("Add"),
          activeColorPrimary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset(
            "lib/assets/folder.png",
            width: 20, height: 20,
            color: Colors.white,
          ),
          title: ("History"),
          activeColorPrimary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset(
            "lib/assets/settings.png",
            width: 20, height: 20,
            color: Colors.white,
          ),
          title: ("Settings"),
          activeColorPrimary: Colors.white,
        ),
      ];
    }

    return Consumer<DataManager>(
      builder: (context, value, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: StreamBuilder(
            stream: firestoreService.getCurrentUser(),
            builder: (context, snapshot) {
              // Check if data is available
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading indicator while waiting for data
                return const Center(
                  child: CircularProgressIndicator(), // Or any other loading indicator widget
                );
              }
              else if (!snapshot.hasData) {
                // If there's no data, display a message
                return const Center(
                  child: Text('No data available'),
                );
              }

              List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
              final bool isTeacher = documents.first['status'];

              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: PersistentTabView(
                  context,
                  controller: _controller,
                  screens: isTeacher ? teacherBuildScreens() : buildScreens(),
                  items: isTeacher ? teacherNavBarsItems() : navBarsItems(),
                  confineInSafeArea: true,
                  backgroundColor: primaryColor, // Default is Colors.white.
                  handleAndroidBackButtonPress: true, // Default is true.
                  resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
                  stateManagement: true, // Default is true.
                  hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
                  decoration: NavBarDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    colorBehindNavBar: Colors.transparent,
                  ),
                  popAllScreensOnTapOfSelectedTab: true,
                  popActionScreens: PopActionScreensType.all,
                  itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
                    duration: Duration(milliseconds: 200),
                    curve: Curves.ease,
                  ),
                  screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
                    animateTabTransition: true,
                    curve: Curves.ease,
                    duration: Duration(milliseconds: 200),
                  ),
                  navBarStyle: NavBarStyle.style13, // Choose the nav bar style with this property.
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
