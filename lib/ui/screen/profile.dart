import 'package:flutter/material.dart';
import 'package:bitirmeprojesi/ui/screen/profil/body.dart';

class ProfilSayfa extends StatefulWidget {
  const ProfilSayfa({Key? key}) : super(key: key);

  @override
  State<ProfilSayfa> createState() => _ProfilSayfaState();
}

class _ProfilSayfaState extends State<ProfilSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfilBody(),
    );
  }
}
