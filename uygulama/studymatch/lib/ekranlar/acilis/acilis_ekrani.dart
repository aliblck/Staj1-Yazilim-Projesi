import 'dart:async';

import 'package:flutter/material.dart';
import 'package:studymatch/ekranlar/ana_menu/ana_menu.dart';

class AcilisEkrani extends StatefulWidget {
  const AcilisEkrani({super.key});

  @override
  State<AcilisEkrani> createState() => _AcilisEkraniState();
}
//uygulamada açılış ekranı kısa süreliğine gelir ve giriş ekranına yönlendirme yapılır

class _AcilisEkraniState extends State<AcilisEkrani> {
  @override
  void initState() {
    // TODO: implement initState  --- ekranı bir kez çalıştıran metotlar
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(  // ekranı depiştir arka ekranı kitle
        context,
        MaterialPageRoute(builder: (context) => const AnaMenu()),// animasyon ve yönlendirme
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_balance_wallet_rounded, size: 100),

            const SizedBox(height: 20),

            const Text(
              'Bütçem',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Paranı yönet, geleceğini planla',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
