import 'package:example/core/app_constants.dart';
import 'package:example/core/app_state.dart';
import 'package:example/widget/app_drawer.dart';
import 'package:example/widget/tool_card.dart';
import 'package:flutter/material.dart';

/// Ana Sayfa:
/// - AppBar'da bildirim zili + okunmamış rozet (renkler sabitten)
/// - Hızlı araçlar (bildirim ekle/okundu/sil/çıkış)
/// - Kart örnekleri (ToolCard)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppState.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.titleHome),
        actions: [
          AnimatedBuilder(
            animation: app.notifications,
            builder: (_, __) {
              final count = app.notifications.unreadCount;
              return IconButton(
                tooltip: AppConstants.titleNotifications,
                onPressed: () => _showNotificationsBottomSheet(context),
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.notifications_outlined, color: AppConstants.primaryColor),
                    if (count > 0)
                      Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                          child: Center(
                            child: Text(
                              count.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.pagePadding),
        children: [
          const Text(
            'Hızlı Araçlar',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppConstants.textColor),
          ),
          const SizedBox(height: 8),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _ToolButton(
                icon: Icons.add_alert,
                label: 'Bildirim Ekle',
                onTap: () => app.notifications.add('Yeni Bildirim', 'Demo bildirimi oluşturuldu.'),
              ),
              _ToolButton(
                icon: Icons.done_all,
                label: 'Hepsini Okundu',
                onTap: () => app.notifications.markAllRead(),
              ),
              _ToolButton(
                icon: Icons.delete_sweep,
                label: 'Bildirimleri Sil',
                onTap: () => app.notifications.clear(),
              ),
              _ToolButton(
                icon: Icons.logout,
                label: 'Çıkış',
                onTap: () {
                  app.auth.logout();
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
                },
              ),
            ],
          ),

          const SizedBox(height: AppConstants.sectionGap),
          const Text(
            'Kartlar',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppConstants.textColor),
          ),
          const SizedBox(height: 8),

          ToolCard(
            icon: Icons.article_outlined,
            title: 'Duyuru',
            subtitle: 'Kısa bir duyuru metni. Kart yapısına örnek.',
            onTap: () {},
          ),
          ToolCard(
            icon: Icons.analytics_outlined,
            title: 'Rapor',
            subtitle: 'Basit rapor ekranı için placeholder.',
            onTap: () {},
          ),
          ToolCard(
            icon: Icons.settings_suggest_outlined,
            title: 'Hızlı Ayarlar',
            subtitle: 'Sık kullanılan ayarlara hızlı erişim.',
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Hızlı ayarlar tıklandı')),
            ),
          ),
        ],
      ),
    );
  }

  /// Bildirimler BottomSheet'i: Liste + "Hepsini okundu"
  void _showNotificationsBottomSheet(BuildContext context) {
    final app = AppState.of(context);
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: AppConstants.surfaceColor,
      builder: (_) {
        return AnimatedBuilder(
          animation: app.notifications,
          builder: (context, __) {
            final items = app.notifications.items;
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          AppConstants.titleNotifications,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppConstants.textColor),
                        ),
                      ),
                      TextButton(
                        onPressed: () => app.notifications.markAllRead(),
                        child: const Text('Hepsini okundu işaretle'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (items.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text('Hiç bildirim yok.', style: TextStyle(color: AppConstants.subTextColor)),
                    )
                  else
                    Flexible(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const Divider(height: 0),
                        itemBuilder: (_, i) {
                          final n = items[i];
                          return ListTile(
                            leading: Icon(
                              n.read ? Icons.notifications : Icons.notifications_active,
                              color: n.read ? AppConstants.subTextColor : AppConstants.primaryColor,
                            ),
                            title: Text(n.title, style: const TextStyle(color: AppConstants.textColor)),
                            subtitle: Text(n.body, style: const TextStyle(color: AppConstants.subTextColor)),
                            trailing: Text(
                              _fmtTime(n.date),
                              style: const TextStyle(fontSize: 12, color: AppConstants.subTextColor),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  String _fmtTime(DateTime d) {
    final two = (int v) => v.toString().padLeft(2, '0');
    return '${two(d.hour)}:${two(d.minute)}';
  }
}

/// Hızlı araç butonu: Renk/metinler sabitten; görsel tutarlılık sağlar.
class _ToolButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ToolButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 48,
      child: OutlinedButton.icon(
        icon: Icon(icon, color: AppConstants.primaryColor),
        label: Text(label, style: const TextStyle(color: AppConstants.textColor)),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppConstants.primaryColor),
        ),
        onPressed: onTap,
      ),
    );
  }
}
