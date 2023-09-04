import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {

  int _page = 0;

  @override
  Widget build(BuildContext context) {

    PageController pageController = PageController();

    void navigationTapped(int page) {
      pageController.jumpToPage(page);
    }

    void onPageChanged(int page) {
      setState(() {
        _page = page;
      });
    }

    //model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: CupertinoTabBar(
          backgroundColor: mobileBackgroundColor,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: _page == 0 ? primaryColor : secondaryColor),
                label: '', backgroundColor:primaryColor
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search, color: _page == 1 ? primaryColor : secondaryColor),
                label: '', backgroundColor:primaryColor
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle, color: _page == 2 ? primaryColor : secondaryColor),
                label: '', backgroundColor:primaryColor
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite, color: _page == 3 ? primaryColor : secondaryColor),
                label: '', backgroundColor:primaryColor
            ),
            BottomNavigationBarItem(
                icon: Icon
                  (Icons.person, color: _page == 4 ? primaryColor : secondaryColor),
                label: '', backgroundColor:primaryColor
            ),
          ],
          onTap: navigationTapped,
      ),
    );
  }
}
