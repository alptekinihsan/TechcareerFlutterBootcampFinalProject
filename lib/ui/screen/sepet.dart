
import 'package:bitirmeprojesi/ui/cubit/sepetsayfa_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitirmeprojesi/ui/screen/card/body.dart';

class SepetSayfa extends StatefulWidget {
  const SepetSayfa({Key? key}) : super(key: key);


  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {

  @override
  void initState() {
    super.initState();
    //nullse null değilse olarak göstereceğiz.
    context.read<SepetSayfaCubit>().sepetVerileriYukle("${FirebaseAuth.instance.currentUser?.email}");// Uygulama açıldığında verileri getirecek

    totalucret = 0;
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body:CardBody(),
    );
  }
}