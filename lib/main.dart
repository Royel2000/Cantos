import 'package:cantosselectos/pages/info_canto_page.dart';
import 'package:cantosselectos/pages/main_page.dart';
import 'package:cantosselectos/providers/songs_provider.dart';
import 'package:cantosselectos/providers/theme_provider.dart';
import 'package:cantosselectos/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider()),
        Provider<SongsProvider>(create: (context) => SongsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cancionero',
          theme: lightTheme,
          darkTheme: lightTheme,
          themeMode:
              themeProvider.themeMode, // Aplica el tema basado en ThemeProvider
          home: const MainPage(),
          routes: {
            '/main': (BuildContext context) => const MainPage(),
            '/infocanto': (BuildContext context) => const InfoCantoPage(),
          },
        );
      },
    );
  }
}
