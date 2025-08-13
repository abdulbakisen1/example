import 'package:flutter/material.dart';
import '../../core/app_state.dart';
import '../../core/app_constants.dart';

/// Ayarlar:
/// - Bildirimler anahtarı (dummy)
/// - Hakkında
/// - Çıkış
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true; // Demo anahtar

  @override
  Widget build(BuildContext context) {
    final app = AppState.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.titleSettings)),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Bildirimler', style: TextStyle(color: AppConstants.textColor)),
            subtitle: const Text('Uygulama içi bildirimleri aç/kapat', style: TextStyle(color: AppConstants.subTextColor)),
            value: notificationsEnabled,
            activeColor: AppConstants.primaryColor,
            onChanged: (v) => setState(() => notificationsEnabled = v),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline, color: AppConstants.primaryColor),
            title: const Text('Hakkında', style: TextStyle(color: AppConstants.textColor)),
            subtitle: const Text('Basit Flutter örneği', style: TextStyle(color: AppConstants.subTextColor)),
            onTap: () => showAboutDialog(
              context: context,
              applicationName: AppConstants.appName,
              applicationVersion: '1.0.0',
              applicationIcon: const FlutterLogo(),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: AppConstants.errorColor),
            title: const Text('Çıkış Yap', style: TextStyle(color: AppConstants.textColor)),
            onTap: () {
              app.auth.logout();
              Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
            },
          ),
        ],
      ),
    );
  }
}
