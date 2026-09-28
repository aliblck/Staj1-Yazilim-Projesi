import 'package:flutter/material.dart';
import 'package:studymatch/ekranlar/acilis/acilis_ekrani.dart';
import 'core/tema/tema.dart';
import 'package:studymatch/servisler/tema_servisi.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await TemaServisi.yukle();

  runApp(const Studymatch());

}
class Studymatch extends StatelessWidget {
  const Studymatch({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
       valueListenable:TemaServisi.karanlikMod,
       builder: (context,karanlik,child){
          return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bütçem',
      theme: UygulamaTemasi.acikTema,

      darkTheme: UygulamaTemasi.koyuTema,
      
      themeMode: karanlik? ThemeMode.dark : ThemeMode.light,

      home: const AcilisEkrani(),
    );

       }
       );
  
  }
}