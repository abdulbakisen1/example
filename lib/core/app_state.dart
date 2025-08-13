import 'package:example/services/notification._service.dart';
import 'package:flutter/material.dart';

// ✅ Göreli import: dosya bulunduğu klasöre göre yol veriyoruz
import '../services/auth_service.dart';

/// AppState: Uygulama genel merkezi state/sunum katmanı.
/// - Auth ve Notification servislerini tek yerden tutar.
/// - İsteyen widget AppState'e erişip bu servislere ulaşır.
class AppState extends ChangeNotifier {
  final AuthService auth = AuthService();                 // Giriş/çıkış yönetimi (demo)
  final NotificationService notifications = NotificationService(); // Bildirim yönetimi

  /// Köprü: AppState.of(context) yazabilmek için.
  /// Aslında AppStateProvider.of(context)'i çağırır.
  static AppState of(BuildContext context) => AppStateProvider.of(context);
}

/// InheritedNotifier: Alt ağaçtaki widget'ların AppState değişimlerini dinlemesini sağlar.
class _AppStateNotifier extends InheritedNotifier<AppState> {
  const _AppStateNotifier({
    required AppState notifier,
    required Widget child,
    super.key,
  }) : super(notifier: notifier, child: child);
}

/// AppStateProvider: Tek bir AppState örneğini tüm uygulama ağacına verir.
/// AppState.of(context) ile erişilir (yukarıdaki köprü sayesinde).
class AppStateProvider extends StatefulWidget {
  final Widget child;
  const AppStateProvider({super.key, required this.child});

  @override
  State<AppStateProvider> createState() => _AppStateProviderState();

  /// Asıl "of": Bu widget'a en yakın _AppStateNotifier'ı bulup AppState döndürür.
  static AppState of(BuildContext context) {
    final inherited =
        context.dependOnInheritedWidgetOfExactType<_AppStateNotifier>();
    assert(inherited != null, 'AppStateProvider bulunamadı (widget ağacını kontrol et)');
    return inherited!.notifier!;
  }
}

class _AppStateProviderState extends State<AppStateProvider> {
  final app = AppState(); // Tek AppState örneği

  @override
  Widget build(BuildContext context) {
    // Uygulamanın child'ını _AppStateNotifier ile sarıyoruz
    return _AppStateNotifier(notifier: app, child: widget.child);
  }
}
