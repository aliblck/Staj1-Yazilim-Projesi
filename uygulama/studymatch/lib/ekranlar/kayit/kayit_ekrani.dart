

import 'package:flutter/material.dart';
import 'package:studymatch/core/tema/renkler.dart';
import 'package:studymatch/ekranlar/ana_menu/ana_menu.dart';

class KayitEkrani extends StatefulWidget{
  const KayitEkrani({super.key});

  @override
  State < KayitEkrani > createState()=> _KayitEkraniState();
}

class _KayitEkraniState extends State <KayitEkrani> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController adController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController sifreController = TextEditingController();
  final TextEditingController sifreTekrarController = TextEditingController();

   @override
   void dispose(){
    adController.dispose();
    emailController.dispose();
    sifreController.dispose();
    sifreTekrarController.dispose();
    super.dispose();
   }

   void kayitOl(){
    FocusScope.of(context).unfocus();

    if(_formKey.currentState!.validate()){
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context)=> const AnaMenu(),
        ),
        );
    }
   }

   @override
   Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kayıt Ol"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Icon(
                Icons.person_add_alt_1,
                size: 80,
                color: UygulamaRenkleri.anaRenk,
              ),
              const SizedBox(height: 20),
              const Text("Yeni Hesap Oluştur",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              ),
              const SizedBox(height: 30),

              TextFormField(
                controller: adController,
                decoration: InputDecoration(
                  labelText: "Ad Soyad",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return "Ad Soyad boş bırakılamaz";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "E-Posta",
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                
                  ),
                ),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "E-Posta boş bırakılamaz";
                  }
                  if(!value.contains("@")){
                    return "Geçerli bir e-posta giriniz";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              
              TextFormField(
                controller: sifreController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Şifre",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Şifre boş bırakılamaz";
                  }
                  if(value.length <6){
                    return "Şifre en az 6 karakter olmalıdır";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: sifreTekrarController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Sifre Tekrar",
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (value){
                  if(value != sifreController.text){
                    return "Şifreler eşleşmiyor";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: kayitOl,
                   child: const Text (
                   "Kayıt Ol")
                   ),
              ),
          
            ],
          ),
        ),
      ),
    );
   }

  }
