import 'package:flutter/material.dart';
import 'package:studymatch/modeller/islem.dart';
import 'package:studymatch/servisler/islem_servisi.dart';

class GelirGiderEkrani extends StatefulWidget {
  const GelirGiderEkrani({super.key});

  @override
  State<GelirGiderEkrani> createState() => _GelirGiderEkraniState();
}

class _GelirGiderEkraniState extends State<GelirGiderEkrani> {
  String secilenTur = "Gelir";

  String? secilenKategori;
  final List<String> gelirKategorileri = [
    "Maaş",
    "Burs",
    "Kira Geliri",
    "Ek İş",
    "Prim",
    "Yatırım",
    "Hediye",
    "Diğer",
  ];

  final List<String> giderKategorileri = [
    "Market",
    "Yemek",
    "Ulaşım",
    "Fatura",
    "Sağlık",
    "Eğitim",
    "Kira",
    "Alışveriş",
    "Diğer",
  ];
  final TextEditingController aciklamaController = TextEditingController();
  final TextEditingController tutarController = TextEditingController();

  @override
  void dispose() {
    tutarController.dispose();
    aciklamaController.dispose();

    super.dispose();
  }

  DateTime secilenTarih = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text("Yeni İşlem"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "İşlem Türü",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        secilenTur = "Gelir";
                        secilenKategori = null;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secilenTur == "Gelir"
                          ? Colors.green
                          : null,
                    ),
                    icon: const Icon(Icons.arrow_upward),
                    label: const Text("Gelir"),
                  ),
                ),

                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        secilenTur = "Gider";
                        secilenKategori = null;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secilenTur == "Gider"
                          ? Colors.red
                          : null,
                    ),
                    icon: const Icon(Icons.arrow_downward),
                    label: const Text("Gider"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            const Text(
              "Tutar",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: tutarController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Örneğin: 250",
                prefixIcon: const Icon(Icons.currency_lira),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Kategori",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: secilenKategori,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              hint: const Text("Kategori Seçiniz"),
              items:
                  (secilenTur == "Gelir"
                          ? gelirKategorileri
                          : giderKategorileri)
                      .map((kategori) {
                        return DropdownMenuItem(
                          value: kategori,
                          child: Text(kategori),
                        );
                      })
                      .toList(),
              onChanged: (value) {
                setState(() {
                  secilenKategori = value;
                });
              },
            ),
            const SizedBox(height: 25),

            const Text(
              "Açıklama",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: aciklamaController,
              decoration: InputDecoration(
                hintText: secilenTur == "Gelir"
                    ? "Örnek: Maaş Ödemesi"
                    : " Örnek: Market Alışverişi",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Tarih",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.calendar_month),
                label: Text(
                  "${secilenTarih.day}/${secilenTarih.month}/${secilenTarih.year}",
                ),
                onPressed: () async {
                  DateTime? tarih = await showDatePicker(
                    context: context,
                    initialDate: secilenTarih,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2035),
                  );
                  if (tarih != null) {
                    setState(() {
                      secilenTarih = tarih;
                    });
                  }
                },
              ),
            ),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (tutarController.text.isEmpty || secilenKategori == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Lütfen tüm alanları doldurun"),
                      ),
                    );
                    return;
                  }
                  final yeniIslem = Islem(
                    tur: secilenTur,
                    tutar: double.parse(
                      tutarController.text.replaceAll(",", "."),
                    ),
                    kategori: secilenKategori!,
                    aciklama: aciklamaController.text,
                    tarih: secilenTarih,
                  );
                  IslemServisi.islemler.value = [
                    ...IslemServisi.islemler.value,
                    yeniIslem,
                  ];
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.save),
                label: const Text("Kaydet", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
