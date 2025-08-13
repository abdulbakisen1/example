import 'package:flutter/material.dart';
import '../core/app_state.dart';
import '../core/app_constants.dart';
import '../pages/settings/settings_page.dart';

/// Drawer (yan menü):
/// - Kullanıcı e-postası
/// - Ana Sayfa
/// - Ayarlar
/// - Çıkış
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppState.of(context);

    return Drawer(
      backgroundColor: AppConstants.surfaceColor, // Kart/arka plan rengi sabitten
      child: SafeArea(
        child: Column(
          children: [
            // Profil kısmı
            UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              decoration: const BoxDecoration(color: AppConstants.primaryColor),
              accountName: const Text('Kullanıcı'),
              accountEmail: Text(app.auth.email ?? 'misafir@demo.app'),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: AppConstants.primaryColor),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home_outlined, color: AppConstants.primaryColor),
              title: const Text(AppConstants.titleHome),
              onTap: () => Navigator.pushReplacementNamed(context, '/home'),
            ),

            ListTile(
              leading: const Icon(Icons.settings_outlined, color: AppConstants.primaryColor),
              title: const Text(AppConstants.titleSettings),
              onTap: () {
                Navigator.pop(context); // Drawer'ı kapat
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              },
            ),

            const Spacer(),
            const Divider(height: 0),

            ListTile(
              leading: const Icon(Icons.logout, color: AppConstants.errorColor),
              title: const Text('Çıkış Yap'),
              onTap: () {
                app.auth.logout();
                Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
