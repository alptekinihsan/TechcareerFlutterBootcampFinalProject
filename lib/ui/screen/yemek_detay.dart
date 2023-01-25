
import 'package:bitirmeprojesi/data/entity/yemekler.dart';
import 'package:bitirmeprojesi/ui/cubit/sepetsayfa_cubit.dart';
import 'package:bitirmeprojesi/ui/screen/fooddetails/body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YemekDetay extends StatefulWidget {
  Yemekler yemek;
  YemekDetay({required this.yemek});

  @override
  State<YemekDetay> createState() => _YemekDetayState();
}

class _YemekDetayState extends State<YemekDetay> {
  @override
  void initState() {
    context.read<SepetSayfaCubit>().sepetVerileriYukle("${FirebaseAuth.instance.currentUser?.email}");// Uygulama açıldığında verileri getirecek
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var yemekler =widget.yemek;
    return Scaffold(
      body: FoodDetailsBody(yemek: yemekler),
    );

  }
}
