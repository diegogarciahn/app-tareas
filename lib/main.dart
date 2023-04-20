import 'package:app_tareas/providers/etiqueta.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'providers/providers.dart';
import 'screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CategoriaProvider()),
        ChangeNotifierProvider(create: (_) => EtiquetaProvider()),
      ],
      child: MaterialApp(
          title: 'Material App',
          scaffoldMessengerKey: snackbarKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
                elevation: 0,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Color(0xff243dd6)),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 23, 22, 71),
                      onPrimary: Colors.white)),
              colorScheme: const ColorScheme(
                  brightness: Brightness.light,
                  primary: Color(0xff243dd6),
                  onPrimary: Colors.white,
                  secondary: Color.fromARGB(255, 34, 33, 109),
                  onSecondary: Colors.white,
                  error: Colors.red,
                  onError: Colors.white,
                  background: Color.fromARGB(255, 231, 236, 240),
                  onBackground: Colors.black87,
                  surface: Colors.white,
                  onSurface: Color.fromARGB(255, 86, 92, 133),
                  primaryContainer: Color.fromARGB(193, 69, 83, 175))),
          home: const LoginScreen()),
    );
  }
}
