import 'package:flutter/material.dart';

import 'package:studymatch/ekranlar/anasayfa/anasayfa_ekrani.dart';
import 'package:studymatch/ekranlar/grafikler/grafik_ekrani.dart';
import 'package:studymatch/ekranlar/profil/profil_ekrani.dart';
import 'package:studymatch/ekranlar/gelir_gider/gelir_gider_ekrani.dart';


class AnaMenu extends StatefulWidget {
  const AnaMenu({super.key});

  @override
  State<AnaMenu> createState() => _AnaMenuState();
}


class _AnaMenuState extends State<AnaMenu> {

  int seciliIndex = 0;


  late List<Widget> sayfalar;


  // Profil sekmesine geçiş
  void profilAc() {

    setState(() {

      seciliIndex = 2;

    });

  }



  @override
  void initState() {

    super.initState();


    sayfalar = [

      AnaSayfa(
        profilAc: profilAc,
      ),


      const GrafikEkrani(),


      const ProfilEkrani(),

    ];

  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(


      body: sayfalar[seciliIndex],



      bottomNavigationBar: BottomNavigationBar(


        currentIndex: seciliIndex,


        type: BottomNavigationBarType.fixed,


        selectedItemColor: Colors.indigo,


        unselectedItemColor: Colors.grey,



        onTap: (index) {


          // Ekle butonu

          if(index == 3){


            Navigator.push(

              context,

              MaterialPageRoute(

                builder: (context)=> 
                    const GelirGiderEkrani(),

              ),

            ).then((_) {


              setState(() {});


            });


            return;

          }



          setState(() {


            seciliIndex = index;


          });


        },



        items: const [


          BottomNavigationBarItem(

            icon: Icon(Icons.home),

            label: "Ana Sayfa",

          ),



          BottomNavigationBarItem(

            icon: Icon(Icons.bar_chart),

            label: "Grafik",

          ),



          BottomNavigationBarItem(

            icon: Icon(Icons.person),

            label: "Profil",

          ),



          BottomNavigationBarItem(

            icon: Icon(Icons.add_circle),

            label: "Ekle",

          ),


        ],


      ),


    );

  }

}