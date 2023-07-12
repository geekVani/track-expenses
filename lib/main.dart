import 'package:daily_expense_app/widgets/expenses.dart';
import 'package:flutter/material.dart';

// to lock screen orientation
import 'package:flutter/services.dart';

// set up color scheme
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

// set up dark color scheme
var kDarkColorScheme = ColorScheme.fromSeed(
  //optimize for dark mode
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  /*WidgetsFlutterBinding.ensureInitialized(); // ensures screen locking first, then starts application
  // set screen orientation
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ).then(
    (function) => */
        runApp(
      // set up app theme here, in your root widget
      MaterialApp(
        debugShowCheckedModeBanner: false,

        // setting up dark theme
        darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kDarkColorScheme,
          cardTheme: const CardTheme().copyWith(
            color: kDarkColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kDarkColorScheme.primaryContainer,
                foregroundColor: kDarkColorScheme.onPrimaryContainer),
          ),
        ),
        // override selected aspects in theme using copywith property
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColorScheme.onPrimaryContainer,
              foregroundColor: kColorScheme.primaryContainer),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.primaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kColorScheme.primary,
                  fontSize: 16,
                ),
              ),
        ),

        // control which theme to be used
        themeMode: ThemeMode.system,
        // by default adapts to system theme
        home: const Expenses(),
      ),
    );
}
