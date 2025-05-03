import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yemak_app/store/layout_change_tap.dart';
import 'package:yemak_app/ui/pages/home/home.dart';
import 'package:yemak_app/ui/pages/profile/profile.dart';
import 'package:yemak_app/ui/pages/search/search.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    StatefulWidget body() {
      switch (context.watch<LayoutChangeTap>().tap) {
        case 0:
          return Home();
        case 1:
          return Search();
        case 2:
          return Profile();
        default:
          return Home();
      }
    }

    return Scaffold(
      body: body(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        onTap: (index) {
          context.read<LayoutChangeTap>().changeTap(index);
        },
        items: [
          BottomNavigationBarItem(
            icon:
                context.watch<LayoutChangeTap>().tap == 0
                    ? Icon(Icons.home, color: Colors.greenAccent)
                    : Icon(Icons.home),
            label: "Asosiy",
          ),
          BottomNavigationBarItem(
            icon:
                context.watch<LayoutChangeTap>().tap == 1
                    ? Icon(Icons.search, color: Colors.greenAccent)
                    : Icon(Icons.search),
            label: "Qidiruv",
            activeIcon: Icon(Icons.search, color: Colors.greenAccent),
          ),
          BottomNavigationBarItem(
            icon:
                context.watch<LayoutChangeTap>().tap == 2
                    ? Icon(
                      Icons.account_circle_outlined,
                      color: Colors.greenAccent,
                    )
                    : Icon(Icons.account_circle_outlined),
            label: "Profile",
            activeIcon: Icon(
              Icons.account_circle_outlined,
              color: Colors.greenAccent,
            ),
          ),
        ],
      ),
    );
  }
}
