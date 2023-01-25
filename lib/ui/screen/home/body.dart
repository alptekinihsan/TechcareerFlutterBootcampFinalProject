import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:bitirmeprojesi/ui/screen/home/background.dart';
import 'package:bitirmeprojesi/ui/screen/home/indicator.dart';
import 'package:bitirmeprojesi/ui/screen/search/notification.dart';
import 'package:bitirmeprojesi/ui/screen/yemek_detay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitirmeprojesi/data/entity/yemekler.dart';
import 'package:bitirmeprojesi/ui/cubit/anasayfa_cubit.dart';
import 'package:flutter/foundation.dart';

class AnasayfaBody extends StatefulWidget {
  const AnasayfaBody({Key? key}) : super(key: key);

  @override
  State<AnasayfaBody> createState() => _AnasayfaBodyState();
}


class _AnasayfaBodyState extends State<AnasayfaBody> {

  bool isFav = false;
  String imgUrl = "http://kasimadalan.pe.hu/yemekler/resimler";
  List<File> files = [];
  int secilenIndex = 0;
  @override
  void initState() {

    context.read<AnasayfaCubit>().yemekleriYukle();// Uygulama açıldığında verileri getirecek

  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
      child: Container(
        child:Column(
          children:[
            Row(children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: SizedBox(width: size.width*0.2,
                      child: IconButton(onPressed: (){
                        debugPrint("Anasayfa buton");
                      },
                        icon:Image.asset("assets/icons/ahcibasi.png"),iconSize:60,),
                    ),
                  ),
                ],
              ),
              Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text("AHÇIBAŞI",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w900),),
                ),
              ],
              ),
            ],
            ),

            ImageCarousel(),

            Padding(
              padding: const EdgeInsets.only(top: 5,left: 22),
              child: Row(
                children: [Text("Ahçıbaşı Menü",
                  style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),),
                ],
              ),
            ),

            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 15,left: 20),
                child: SingleChildScrollView(
                  child: Container(
                    child: Container(
                      child: BlocBuilder<AnasayfaCubit,List<Yemekler>>(
                        builder: (context,yemeklerListesi){
                          if(yemeklerListesi.isNotEmpty){
                            return Container(width: size.width,height:size.height*0.4,
                              child: Container(
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: yemeklerListesi.length,
                                  itemBuilder: (context,indeks){
                                    var yemekler = yemeklerListesi[indeks];
                                    return GestureDetector(
                                      onTap: (){

                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>YemekDetay(yemek: yemekler)))
                                            .then((value) {context.read<AnasayfaCubit>().yemekleriYukle(); });
                                      },
                                      child: Container(width: size.width*0.67,height: size.height*0.4,
                                        child: Card(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.elliptical(20, 30))),
                                          child: Column(
                                            children: [
                                              SizedBox(width: size.width*0.4,
                                                child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.network("${imgUrl}/${yemekler.yemek_resim_adi}",

                                                      loadingBuilder: (BuildContext context, Widget child,
                                                          ImageChunkEvent? loadingProgress) {
                                                        if (loadingProgress == null) {
                                                          return child;
                                                        }
                                                        return Center(
                                                          child: CircularProgressIndicator(
                                                            value: loadingProgress.expectedTotalBytes != null
                                                                ? loadingProgress.cumulativeBytesLoaded /
                                                                loadingProgress.expectedTotalBytes!
                                                                : null,
                                                          ),
                                                        );
                                                      },

                                                    ),

                                                  ],
                                                ),
                                              ),

                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 10),
                                                    child:Row(
                                                      children: [
                                                        Text("${yemekler.yemek_adi} ",style: const TextStyle(fontSize: 16,color: Colors.black),),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 10),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Fiyat:",
                                                          style: TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight: FontWeight.w300,
                                                          ),
                                                        ), SizedBox(width: 10.0),
                                                        Text("${yemekler.yemek_fiyat} ₺",style: const TextStyle(fontSize: 24,fontWeight: FontWeight.w900,color: Colors.black),),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              Row(
                                                children: [
                                                  RawMaterialButton(
                                                    onPressed: (){
                                                    },
                                                    fillColor: Colors.white,
                                                    shape: CircleBorder(),
                                                    elevation: 7.0,
                                                    child: Padding(
                                                      padding: EdgeInsets.all(0),
                                                      child: Icon(
                                                        isFav
                                                            ?Icons.favorite
                                                            :Icons.favorite_border,
                                                        color: Colors.black,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),

                                                  RawMaterialButton(
                                                    onPressed: (){


                                                    },
                                                    fillColor: Colors.white,
                                                    shape: CircleBorder(),
                                                    elevation: 7.0,
                                                    child: Padding(
                                                      padding: EdgeInsets.all(0),
                                                      child: Icon(
                                                        isFav
                                                            ?Icons.location_pin
                                                            :Icons.location_on_outlined,
                                                        color: Colors.black,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  RawMaterialButton(
                                                    onPressed: (){
                                                    },
                                                    fillColor: Colors.white,
                                                    shape: CircleBorder(),
                                                    elevation: 7.0,
                                                    child: Padding(
                                                      padding: EdgeInsets.all(0),
                                                      child: Icon(
                                                        isFav
                                                            ?Icons.shopping_cart
                                                            :Icons.shopping_cart,
                                                        color: Colors.black,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );//listeleme yapacak kişi nesnesini alacak
                          }else{
                            return const Center();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    ),


    );
  }
}
