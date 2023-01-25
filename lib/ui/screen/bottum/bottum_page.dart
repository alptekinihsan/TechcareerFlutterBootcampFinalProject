import 'package:flutter/material.dart';

import 'package:bitirmeprojesi/ui/screen/anasayfa.dart';
import 'package:bitirmeprojesi/ui/screen/profile.dart';
import 'package:bitirmeprojesi/ui/screen/search.dart';
import 'package:bitirmeprojesi/ui/screen/sepet.dart';

class BottumSayfa extends StatefulWidget {
  const BottumSayfa({Key? key}) : super(key: key);

  @override
  State<BottumSayfa> createState() => _BottumSayfaState();
}
//Scaffoltun orda tanımlıyacaz sabit kalacağı için.
class _BottumSayfaState extends State<BottumSayfa> {
  int secilenIndex =0;
  var sayfaListesi=[Anasayfa(),GalleryScreen(), SepetSayfa(),ProfilSayfa()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sayfaListesi[secilenIndex],
      bottomNavigationBar: BottomNavigationBar(
        items:const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: "Anasayfa"),
          BottomNavigationBarItem(icon: Icon(Icons.search),label: "Ara"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Sepet"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_sharp),label: "Profil"),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        currentIndex: secilenIndex,
        onTap: (index){
          setState(() {
            secilenIndex=index;
          });
        },
      ),


    );
  }
}
