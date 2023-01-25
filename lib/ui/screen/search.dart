
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitirmeprojesi/ui/cubit/anasayfa_cubit.dart';
import 'package:bitirmeprojesi/ui/screen/search/body.dart';



class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  void initState()
  {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();// Uygulama açıldığında verileri getirecek
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchBody(),
    );
  }
}