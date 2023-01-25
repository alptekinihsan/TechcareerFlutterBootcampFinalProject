import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitirmeprojesi/ui/cubit/anasayfa_cubit.dart';
import 'package:bitirmeprojesi/ui/cubit/sepetsayfa_cubit.dart';
import 'package:bitirmeprojesi/ui/cubit/yemek_detay_cubit.dart';
import 'package:bitirmeprojesi/ui/screen/loginn.dart';



Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AnasayfaCubit()),
        BlocProvider(create: (context)=>YemekDetayCubit()),
        BlocProvider(create: (context)=>SepetSayfaCubit()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'Firebase Auth Demo',
          home: Login(),
        ),
    );
    }
  }

