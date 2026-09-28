import 'package:flutter/material.dart';
import 'package:studymatch/modeller/islem.dart';
import 'package:studymatch/servisler/islem_servisi.dart';
import 'package:studymatch/servisler/kullanici_servisi.dart';
import 'package:studymatch/ekranlar/profil/profil_ekrani.dart';

class AnaSayfa extends StatefulWidget {
  final VoidCallback profilAc;
  const AnaSayfa({super.key, required this.profilAc});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Islem>>(
      valueListenable: IslemServisi.islemler,
      builder: (context, islemler, child) {
        double toplamGelir = 0;
        double toplamGider = 0;

        for (var islem in islemler) {
          if (islem.tur == "Gelir") {
            toplamGelir += islem.tutar;
          } else {
            toplamGider += islem.tutar;
          }
        }

        double bakiye = toplamGelir - toplamGider;

        double aylikHedef = KullaniciServisi.aylikHedef;

        double butceOrani = aylikHedef == 0 ? 0 : toplamGider / aylikHedef;


        return Scaffold(
          appBar: AppBar(title: const Text("Bütçem"), centerTitle: true),

          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text(
                  "Merhaba 👋",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),

                Text(
                  KullaniciServisi.isim.isEmpty
                      ? "Misafir"
                      : KullaniciServisi.isim,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                KullaniciServisi.isim.isEmpty
                    ? Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.person_add,
                            color: Colors.indigo,
                          ),

                          title: const Text(
                            "Profilini tamamla",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          subtitle: const Text(
                            "İsmini ve aylık hedefini ekle.",
                          ),

                          trailing: const Icon(Icons.arrow_forward_ios),

                          onTap: () async {
                            final sonuc = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfilEkrani(),
                              ),
                            );
    
                            if (sonuc == true) {
                              setState(() {});
                            
                            }
                          },
                        ),
                      )
                    : const SizedBox(),

                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: bakiye < 0 ? Colors.red : Colors.indigo,
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text(
                        "Toplam Bakiye",
                        style: TextStyle(color: Colors.white),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "₺${bakiye.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: _BilgiKarti(
                        baslik: "Gelir",
                        deger: "₺${toplamGelir.toStringAsFixed(2)}",
                        ikon: Icons.arrow_upward,
                        renk: Colors.green,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: _BilgiKarti(
                        baslik: "Gider",
                        deger: "₺${toplamGider.toStringAsFixed(2)}",
                        ikon: Icons.arrow_downward,
                        renk: Colors.red,
                      ),
                    ),
                  ],
                ),
                Card(
                  elevation: 3,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: ListTile(
                    leading: const Icon(Icons.flag, color: Colors.indigo),

                    title: const Text("Aylık Hedef"),

                    subtitle: Text(
                      "₺${KullaniciServisi.aylikHedef.toStringAsFixed(0)}",
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                const SizedBox(height: 10),

                Text(
                  butceOrani == 0
                      ? "Henüz harcama yok"
                      : "Hedefin ${(butceOrani * 100).toStringAsFixed(0)}%'i kullanıldı",
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),

                const SizedBox(height: 25),

                const Text(
                  "Son İşlemler",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                Expanded(
                  child: islemler.isEmpty
                      ? const Center(
                          child: Text(
                            "Henüz işlem yok",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: islemler.length,

                          itemBuilder: (context, index) {
                            final tersIslemler = islemler.reversed.toList();

                            final islem = tersIslemler[index];
                            return Card(
                              child: ListTile(
                                title: Text(islem.kategori),

                                subtitle: Text(islem.aciklama),

                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,

                                  children: [
                                    Text("₺${islem.tutar.toStringAsFixed(2)}"),

                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),

                                      onPressed: () {
                                        final liste = List<Islem>.from(
                                          islemler,
                                        );

                                        liste.removeAt(islemler.indexOf(islem));

                                        IslemServisi.islemler.value = liste;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BilgiKarti extends StatelessWidget {
  final String baslik;
  final String deger;
  final IconData ikon;
  final Color renk;

  const _BilgiKarti({
    required this.baslik,
    required this.deger,
    required this.ikon,
    required this.renk,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            Icon(ikon, color: renk, size: 30),

            const SizedBox(height: 8),

            Text(baslik, style: const TextStyle(fontWeight: FontWeight.bold)),

            const SizedBox(height: 5),

            Text(deger),
          ],
        ),
      ),
    );
  }
}
