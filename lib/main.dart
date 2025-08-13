import 'package:example/pages/auth/home/home_page.dart';
import 'package:flutter/material.dart';
import 'core/app_state.dart';
import 'core/app_constants.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/register_page.dart';

void main() {
  // Uygulamanın giriş noktası
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // AppStateProvider: Uygulama genel state erişimi (auth, bildirim vs.)
    return AppStateProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.appName, // Uygulama adı sabitten
        theme: ThemeData(
          useMaterial3: true,
          // Tema rengi: tek noktadan yönetim
          colorSchemeSeed: AppConstants.primaryColor,
          scaffoldBackgroundColor: AppConstants.backgroundColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppConstants.surfaceColor,
            foregroundColor: AppConstants.textColor,
            elevation: 0,
            centerTitle: false,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => const RootGate(),
          '/login': (_) => const LoginPage(),
          '/register': (_) => const RegisterPage(),
          '/home': (_) =>  HomePage(),
        },
      ),
    );
  }
}

/// RootGate: Login durumuna göre Login/Home yönlendirmesi.
/// isLoggedInListenable değişince otomatik rebuild olur.
class RootGate extends StatelessWidget {
  const RootGate({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppState.of(context);

    return ValueListenableBuilder<bool>(
      valueListenable: app.auth.isLoggedInListenable,
      builder: (_, loggedIn, __) {
        if (loggedIn) return  HomePage();
        return const LoginPage();
      },
    );
  }
}
