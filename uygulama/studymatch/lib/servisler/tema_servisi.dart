import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemaServisi {

  static ValueNotifier<bool> karanlikMod =
      ValueNotifier(false);

  static Future<void> yukle() async{
    final prefs = await SharedPreferences.getInstance();

    karanlikMod.value = prefs.getBool("karanlikMod") ?? false;
  }

  static void temaDegistir(bool durum) async {

    karanlikMod.value = durum;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("karanlikMod", durum,);

  }

}