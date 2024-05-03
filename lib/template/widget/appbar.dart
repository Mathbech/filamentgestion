import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import '../../services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
        String version = snapshot.data?.version ?? 'Unknown';
        return FutureBuilder<String>(
          future: getUsername(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            String username = snapshot.data ?? 'Unknown';
            return Drawer(
              child: Stack(
                children: [
                  ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        child: Column(
                          children: [
                            Text('Menu'),
                            Text('Connecté en tant que : $username'),
                          ],
                        ),
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
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/imprimante');
                          }),
                      ListTile(
                        title: Text('Impressions'),
                        leading: Icon(Icons.local_print_shop_outlined),
                        onTap: () {
                          Navigator.pop(context); // ferme le tiroir
                          Navigator.pushNamed(context,
                              '/impressions'); // navigue vers la nouvelle page
                        },
                      ),
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
                      Positioned(
                        bottom: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('Version: $version'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
