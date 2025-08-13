import 'package:flutter/foundation.dart';

/// Tek bildirim modeli: başlık, içerik, tarih, okundu mu?
class AppNotification {
  final String title;
  final String body;
  final DateTime date;
  bool read;

  AppNotification({
    required this.title,
    required this.body,
    required this.date,
    this.read = false,
  });
}

/// Basit bildirim yönetimi: listeyi bellekte tutar.
/// Ekle, hepsini okundu yap, temizle gibi işlemler sağlar.
class NotificationService extends ChangeNotifier {
  final List<AppNotification> _items = [
    AppNotification(
      title: 'Hoş geldin',
      body: 'Uygulamaya giriş yaptın.',
      date: DateTime.now(),
    ),
  ];

  List<AppNotification> get items => List.unmodifiable(_items);
  int get unreadCount => _items.where((e) => !e.read).length;

  void add(String title, String body) {
    _items.insert(0, AppNotification(title: title, body: body, date: DateTime.now()));
    notifyListeners();
  }

  void markAllRead() {
    for (final n in _items) {
      n.read = true;
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
