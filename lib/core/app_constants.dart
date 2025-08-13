import 'package:flutter/material.dart';

/// AppConstants:
/// Uygulama genelinde tekrar kullanılan SABİTLERİN tek adresi.
/// - Renkler
/// - Metin sabitleri
/// - (Gerektiğinde) asset yolları, sayısal sabitler, padding vs.
class AppConstants {
  // ---- Renk Paleti (Kurumsal) ----
  static const Color primaryColor = Color(0xFF3949AB); // Ana renk (indigo 600 civarı)
  static const Color secondaryColor = Color(0xFF00ACC1); // İkincil renk (cyan ton)
  static const Color backgroundColor = Color(0xFFF5F5F5); // Genel arka plan
  static const Color surfaceColor = Colors.white; // Kart/Sheet arka planı
  static const Color textColor = Colors.black87; // Ana metin
  static const Color subTextColor = Colors.black54; // İkincil metin
  static const Color errorColor = Colors.redAccent; // Hata
  static const Color successColor = Colors.green; // Başarı

  // ---- Metin Sabitleri ----
  static const String appName = 'Flutter Demo';
  static const String titleHome = 'Ana Sayfa';
  static const String titleLogin = 'Giriş Yap';
  static const String titleRegister = 'Kayıt Ol';
  static const String titleSettings = 'Ayarlar';
  static const String titleNotifications = 'Bildirimler';

  // ---- Layout Sabitleri (örnek) ----
  static const double pagePadding = 16.0;
  static const double sectionGap = 16.0;

  // ---- Asset Sabitleri (istersen kullan) ----
  static const String logoPath = 'assets/images/logo.png';
}
