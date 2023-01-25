
import 'package:bitirmeprojesi/ui/screen/home/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitirmeprojesi/ui/cubit/anasayfa_cubit.dart';
import 'package:flutter/foundation.dart';

class Anasayfa extends StatefulWidget {

  Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}


class _AnasayfaState extends State<Anasayfa> {

  @override
  void initState() {
    // TODO: implement initState
    context.read<AnasayfaCubit>().yemekleriYukle();// Uygulama açıldığında verileri getirecek
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnasayfaBody(),
    );

  }
}
