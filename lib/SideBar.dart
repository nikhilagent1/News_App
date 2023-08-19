import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});
  //-----------------------------------------------------------------------------variables
  final List drawerMenuListname = const [
    {
      "leading": Icon(
        Icons.favorite,
        color: Colors.deepPurple,
      ),
      "title": "Favorite",
      "trailing": Icon(
        Icons.chevron_right,
      ),
      "action_id": 1,
    },
  ];
  //------------------------------------------------------------------------------variables end
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: 280,
        child: Drawer(
          child: ListView(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('Images/N circle.jpg'),
                ),
                title: Text('Hello Nikhil',
                    style: TextStyle(fontSize: 30, color: Colors.deepPurple)),
              ),
              const SizedBox(
                height: 1,
              ),
              ...drawerMenuListname.map((sideMenuData) {
                return ListTile(
                  leading: sideMenuData['leading'],
                  title: Text(
                    sideMenuData['title'],
                  ),
                  trailing: sideMenuData['trailing'],
                  onTap: () {
                    // Navigator.pop(context);
                    // if (sideMenuData['action_id'] == 1) {
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (context) => const FavoriteScreen(),
                    //     ),
                    //   );
                    // }
                    // else if (sideMenuData['action_id'] == 4) {
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (context) => const SettingScreen(),
                    //     ),
                    //   );
                    // }
                  },
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
