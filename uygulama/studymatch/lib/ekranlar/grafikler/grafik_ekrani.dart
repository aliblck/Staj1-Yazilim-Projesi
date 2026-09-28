import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:studymatch/modeller/islem.dart';
import 'package:studymatch/servisler/islem_servisi.dart';

class GrafikEkrani extends StatelessWidget {
  const GrafikEkrani({super.key});

IconData kategoriIkonu(String giderKategorileri){
        switch(giderKategorileri){
          case "Market":
          return Icons.shopping_cart;

          case "Yemek":
          return Icons.restaurant;

          case  "Ulaşım":
          return Icons.directions_bus;

          case  "Fatura":
          return Icons.receipt_long;

          case  "Sağlık":
          return Icons.local_hospital;

          case  "Eğitim":
          return Icons.school;

          case  "Kira":
          return Icons.home;

          case  "Alışveriş":
          return Icons.shopping_bag;

          case  "Maaş":
          return Icons.work;

          case  "Burs":
          return Icons.school_outlined;

          case  "Ek İş":
          return Icons.business_center;

          case  "Yatırım":
          return Icons.trending_up;

          default:
          return Icons.category;
        }
      }



  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Islem>>(
      valueListenable: IslemServisi.islemler,
      builder: (context, islemler, child) {
        double toplamGelir = 0;
        double toplamGider = 0;

        for (final islem in islemler) {
          if (islem.tur == "Gelir") {
            toplamGelir += islem.tutar;
          } else {
            toplamGider += islem.tutar;
          }
        }

        final Map<String, double> kategoriToplamlari = {};
        for (var islem in islemler) {
          if (islem.tur == "Gider") {
            kategoriToplamlari.update(
              islem.kategori,
              (value) => value + islem.tutar,
              ifAbsent: () => islem.tutar,
            );
          }
        }

        if (toplamGelir == 0 && toplamGider == 0) {
          return const Scaffold(
            body: Center(
              child: Text(
                "Henüz işlem eklenmedi",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text("Grafikler"), centerTitle: true),

          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),

                SizedBox(
                  height: 260,
                  child: PieChart(
                    PieChartData(
                      centerSpaceRadius: 55,
                      sectionsSpace: 3,

                      sections: [
                        PieChartSectionData(
                          value: toplamGelir,
                          color: Colors.green,
                          radius: 70,
                          title: "Gelir\n₺${toplamGelir.toStringAsFixed(0)}",
                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        PieChartSectionData(
                          value: toplamGider,
                          color: Colors.red,
                          radius: 70,
                          title: "Gider\n₺${toplamGider.toStringAsFixed(0)}",
                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Card(
                  child: ListTile(
                    leading: const CircleAvatar(backgroundColor: Colors.green),
                    title: const Text("Toplam Gelir"),
                    trailing: Text("₺${toplamGelir.toStringAsFixed(2)}"),
                  ),
                ),

                const SizedBox(height: 10),

                Card(
                  child: ListTile(
                    leading: const CircleAvatar(backgroundColor: Colors.red),
                    title: const Text("Toplam Gider"),
                    trailing: Text("₺${toplamGider.toStringAsFixed(2)}"),
                  ),
                ),

                const SizedBox(height: 25),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "İşlemler",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                Expanded(
                  child: ListView(
                    children: kategoriToplamlari.entries.map((entry) {
                      return Card(
                        elevation: 2,
                        child: ListTile(
                         leading: CircleAvatar(
  backgroundColor: Colors.indigo.shade100,
  child: Icon(
    kategoriIkonu(entry.key),
    color: Colors.indigo,
  ),
),
                          title: Text(entry.key),
                          trailing: Text(
                            "₺${entry.value.toStringAsFixed(2)}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }).toList(),
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
