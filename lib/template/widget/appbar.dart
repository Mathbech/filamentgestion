import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(AppBar().preferredSize.height);
}

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
        String version = snapshot.data?.version ?? 'Unknown';
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: Text('Menu'),
              ),
              ListTile(
                  title: const Text('Stocks'),
                  leading: Icon(Icons.store),
                  onTap: () {
                    Navigator.pushNamed(context, '/bobine');
                  }),
              ListTile(
                  title: const Text('Ventes'),
                  leading: Icon(Icons.shopping_cart),
                  onTap: () {
                    Navigator.pushNamed(context, '/ventes');
                  }),
              AboutListTile(
                child: Text('Version'),
                applicationVersion: version,
              ),
            ],
          ),
        );
      },
    );
  }
}
