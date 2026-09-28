import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:studymatch/servisler/kullanici_servisi.dart';
import 'package:studymatch/servisler/tema_servisi.dart';


class ProfilEkrani extends StatefulWidget {
  const ProfilEkrani({super.key});

  @override
  State<ProfilEkrani> createState() => _ProfilEkraniState();
}

class _ProfilEkraniState extends State<ProfilEkrani> {
  final TextEditingController isimController = TextEditingController();
  final TextEditingController meslekController = TextEditingController();
  final TextEditingController hedefController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Daha önce kayıt varsa ekrana getir
    isimController.text = KullaniciServisi.isim;

    meslekController.text = KullaniciServisi.meslek;

    hedefController.text = KullaniciServisi.aylikHedef.toString();
  }

  @override
  void dispose() {
    isimController.dispose();
    meslekController.dispose();
    hedefController.dispose();

    super.dispose();
  }

  void kaydet() {
    FocusScope.of(context).unfocus();
    if (isimController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Lütfen adınızı giriniz")));

      return;
    }

    KullaniciServisi.isim = isimController.text.trim();

    KullaniciServisi.meslek = meslekController.text.trim();

    KullaniciServisi.aylikHedef =
        double.tryParse(hedefController.text.replaceAll(",", ".")) ?? 0;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Profil kaydedildi")));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profil"), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 45,
                      child: Icon(Icons.person, size: 45),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      KullaniciServisi.isim.isEmpty
                          ? "Misafir"
                          : KullaniciServisi.isim,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      KullaniciServisi.meslek.isEmpty
                          ? "Meslek belirtilmedi"
                          : KullaniciServisi.meslek,
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),

                    const SizedBox(height: 20),

                    const Divider(),

                    const SizedBox(height: 10),

                    const Text(
                      "Aylık Hedef",
                      style: TextStyle(color: Colors.grey),
                    ),

                    Text(
                      "₺${KullaniciServisi.aylikHedef.toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Center(
              child: Text(
              "Bilgileri Güncelle",
              style: 
              TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            ),

            const SizedBox(height: 15),

            const SizedBox(height: 25),

            const CircleAvatar(radius: 55, child: Icon(Icons.person, size: 60)),

            const SizedBox(height: 20),

            Center(
              child: Text(
                KullaniciServisi.isim.isEmpty
                    ? "Profil Oluştur"
                    : KullaniciServisi.isim,

                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: isimController,

              decoration: InputDecoration(
                labelText: "Adınız",

                prefixIcon: const Icon(Icons.person),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: meslekController,

              decoration: InputDecoration(
                labelText: "Meslek",

                prefixIcon: const Icon(Icons.work),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: hedefController,

              keyboardType: TextInputType.number,

              decoration: InputDecoration(
                labelText: "Aylık Hedef",

                hintText: "Örneğin: 5000",

                prefixIcon: const Icon(Icons.flag),

                suffixText: "₺",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 55,

              child: ElevatedButton.icon(
                onPressed: kaydet,

                icon: const Icon(Icons.save),

                label: const Text(
                  "Profili Kaydet",
                  style: TextStyle(fontSize: 18),

                  
                ),
              ),
            ),
            const SizedBox(height: 35),
            const Text(
              "Ayarlar",
              style:TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),

              ValueListenableBuilder<bool>(
                valueListenable: TemaServisi.karanlikMod,
                builder: (context, karanlik, child) {

                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.dark_mode),
                      title: const Text("Karanllık Mod"),
                      subtitle: Text(
                        karanlik? "Açık": "Kapalı",
                      ),
                      trailing: Switch(
                        value: karanlik, 
                        onChanged: (deger){
                          TemaServisi.temaDegistir(deger);
                        },
                        ),
                      
                    )
                  );
                },
              ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.language),
                title: const Text("Dil Seçeneği"),
                subtitle: const Text("Türkçe"),
                trailing: const Icon(Icons.arrow_forward_ios, size:18),
                onTap: () {
                  
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
