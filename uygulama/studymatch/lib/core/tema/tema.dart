import 'package:flutter/material.dart';
import 'renkler.dart';

class UygulamaTemasi{
  static ThemeData acikTema= ThemeData
  (useMaterial3: true,
   scaffoldBackgroundColor: UygulamaRenkleri.arkaPlan,
   colorScheme: ColorScheme.fromSeed(seedColor: UygulamaRenkleri.anaRenk),

   appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
    backgroundColor: UygulamaRenkleri.anaRenk,
    foregroundColor: Colors.white,
   ),



   cardTheme: const CardThemeData(
    color: UygulamaRenkleri.kartRengi,
    elevation: 2,
    margin: EdgeInsets.all(8),
   ),

   elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: UygulamaRenkleri.anaRenk,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 55),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      )
    )
   )
   );
     static ThemeData koyuTema =ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      colorScheme: ColorScheme.fromSeed(
        seedColor:UygulamaRenkleri.anaRenk,
        brightness: Brightness.dark,
        ),

        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xFF1E1E1E),
          foregroundColor: Colors.white,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: UygulamaRenkleri.anaRenk,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity,55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            )
          )
        )
    
  );

}