import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import '../../services/api.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: const Color.fromARGB(255, 81, 148, 182),
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
          child: Stack(
            children: [
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    child: Text('Menu'),
                  ),
                  ListTile(
                      title: const Text('Accueil'),
                      leading: Icon(Icons.home),
                      onTap: () {
                        Navigator.pushNamed(context, '/dashboard');
                      }),
                  ListTile(
                      title: const Text('Stocks'),
                      leading: Icon(Icons.store),
                      onTap: () {
                        Navigator.pushNamed(context, '/bobine');
                      }),
                      ListTile(
                      title: const Text('Imprimantes'),
                      leading: Icon(Icons.print_rounded),
                      onTap: () {
                        Navigator.pushNamed(context, '/imprimante');
                      }),
                  ListTile(
                      title: const Text('Ventes'),
                      leading: Icon(Icons.shopping_cart),
                      onTap: () {
                        Navigator.pushNamed(context, '/ventes');
                      }),
                  ListTile(
                      title: const Text('Déconnexion'),
                      leading: Icon(Icons.logout),
                      onTap: () {
                        Api apiInstance = Api();
                        apiInstance.logout(context);
                      }),
                ],
              ),
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Version: $version'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
