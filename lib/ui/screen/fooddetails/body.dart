import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bitirmeprojesi/data/entity/yemekler.dart';
import 'package:bitirmeprojesi/ui/screen/fooddetails/background.dart';
import 'package:bitirmeprojesi/data/entity/sepet_yemekler.dart';
import 'package:bitirmeprojesi/ui/cubit/sepetsayfa_cubit.dart';
import 'package:bitirmeprojesi/ui/cubit/yemek_detay_cubit.dart';
import 'package:bitirmeprojesi/ui/screen/bottum/bottum_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitirmeprojesi/ui/screen/sepet.dart';

class FoodDetailsBody extends StatefulWidget {
  Yemekler yemek;
  FoodDetailsBody({required this.yemek});
  @override
  State<FoodDetailsBody> createState() => _FoodDetailsBodyState();
}

class _FoodDetailsBodyState extends State<FoodDetailsBody> {



  String imgUrl = "http://kasimadalan.pe.hu/yemekler/resimler";
  int sayac=1;
  int ucret=0;
  var tekrar = 0;
  @override
  void initState() {


    context.read<SepetSayfaCubit>().sepetVerileriYukle("${FirebaseAuth.instance.currentUser?.email}");// Uygulama açıldığında verileri getirecek
    super.initState();
  }

  void adetArttir(bool arttir){
    var yemekler =widget.yemek;
    if(arttir){
      int ilkUcret = int.parse(widget.yemek.yemek_fiyat);
      sayac=sayac+1;
      ucret=ilkUcret;
      ucret=int.parse(yemekler.yemek_fiyat)*sayac;
      print(""+sayac.toString());
    }else{
      sayac=sayac-1;
      ucret=int.parse(yemekler.yemek_fiyat)*sayac;
      if(sayac<=1)
        sayac=1;
      ucret=int.parse(yemekler.yemek_fiyat)*sayac;
      print(""+sayac.toString());
    }
    setState(() {
      sayac;
      ucret;
    });
  }
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var yemekler =widget.yemek;
    return Background(
      child:SingleChildScrollView(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only( top: 0),
              child: Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>BottumSayfa()))
                        .then((value) {context.read<SepetSayfaCubit>().sepetVerileriYukle("${FirebaseAuth.instance.currentUser?.email}");});//arayüzde güncelldik verileri//anlık olarak göstermesi için
                  }, icon:const Icon(Icons.arrow_back)),

                  SizedBox(width: size.width*0.75,
                      child: Center(child: Text("${yemekler.yemek_adi} Detay",style: TextStyle(fontSize: 20),),)
                  ),
                  IconButton(onPressed: (){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>SepetSayfa()));
                        //.then((value) {context.read<SepetSayfaCubit>().sepetVerileriYukle("${FirebaseAuth.instance.currentUser?.email}");});//arayüzde güncelldik verileri//anlık olarak göstermesi için
                  }, icon:const Icon(Icons.shopping_cart)),


                ],

              ),
            ),
            SizedBox(height: 10.0),
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network("${imgUrl}/${yemekler.yemek_resim_adi}",
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
                  ),
                ),

                Positioned(
                  right: -10.0,
                  bottom: 3.0,
                  child: RawMaterialButton(
                    onPressed: (){
                    },
                    fillColor: Colors.white,
                    shape: CircleBorder(),
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        isFav
                            ?Icons.favorite
                            :Icons.favorite_border,
                        color: Colors.red,
                        size: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child:Row(
                children: [
                  Text("${yemekler.yemek_adi} ",style: const TextStyle(fontSize: 24,color: Colors.black),),
                ],
              ),
            ),

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

                  ucret==0 ?
                  Text("${yemekler.yemek_fiyat} ₺",style: const TextStyle(fontSize: 24,fontWeight: FontWeight.w900,color: Colors.black),
                  ):
                  Text("${ucret.toString()} ₺",style: const TextStyle(fontSize: 24,fontWeight: FontWeight.w900,color: Colors.black),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.0),
            Text(
              "Ürün Açıklaması",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),

            SizedBox(height: 10.0),

            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                children:[
                  Text(//eger ürün makarna ise makarnaya ait açıklama
                    "Nulla quis lorem ut libero malesuada feugiat. Lorem ipsum dolor "
                        "sit amet, consectetur adipiscing elit. Curabitur aliqasuet quam "
                        "id dui posuere blandit. Pellentesque in ipsum id orci porta "
                        "dapibus. Vestibulum ante ipsum primis in faucibus orci luctus "
                        "et ultrices posuere cubilia Curae; Donec velit neque, auctor ",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 60.0),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.elliptical(60, 60))),
                    child: SizedBox(width:size.width*0.25,height: size.height*0.06,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(onTap: (){
                            adetArttir(false);
                            var ucret = int.parse(yemekler.yemek_fiyat)*sayac;
                            print("Toplam Ücret  ${ucret}");
                          }, child: Icon(Icons.remove,color: Colors.pink,)),
                          SizedBox(width:15,),
                          Text("${sayac.toString()}"),
                          SizedBox(width:15,),
                          GestureDetector(onTap: (){
                            adetArttir(true);
                            var ucret = int.parse(yemekler.yemek_fiyat)*sayac;
                            print("Toplam Ücret  ${ucret}");
                          }, child: Icon(Icons.add,color: Colors.pink,)),
                        ],
                      ),
                    ),
                  ),
                ),

                BlocBuilder<SepetSayfaCubit,List<Sepet>>
                  (builder: (context,sepetListesi) {
                  return ElevatedButton(onPressed: () {
                    /*"${int.parse(yemekler.yemek_fiyat)*sayac}","${sayac!}"*/
                    /*FONKSİYONU İÇERİSİNDE İF ELSE YAPILACAK AYNI YEMEK EKLENMEYECEK*/
                    for(var i =0; i<sepetListesi.length;i++){
                      if(widget.yemek.yemek_adi == sepetListesi[i].yemek_adi){
                        print("sepet ekleme ${sepetListesi[i].yemek_adi}");
                        String yeniadet= sepetListesi[i].yemek_siparis_adet;
                        print("yeniadet${yeniadet}");
                        int yenisayac= int.parse(yeniadet)+sayac;
                        print("Yeni Sayac${yenisayac}");
                        int yeniFiyat = yenisayac*int.parse(yemekler.yemek_fiyat);
                        print("yeni fiyat ${yeniFiyat}");
                        print("eski  fiyat ${sepetListesi[i].yemek_fiyat}");
                        context.read<SepetSayfaCubit>().sil(int.parse(sepetListesi[i].sepet_yemek_id), "${FirebaseAuth.instance.currentUser?.email}");
                        context.read<YemekDetayCubit>().sepeteEkle("${yemekler.yemek_adi}", "${yemekler.yemek_resim_adi}", "${yeniFiyat!.toString()}", "${yenisayac!.toString()}", "${FirebaseAuth.instance.currentUser?.email}");
                        return;
                      }

                    }
                    if(tekrar==0){
                      context.read<YemekDetayCubit>().sepeteEkle("${yemekler.yemek_adi}", "${yemekler.yemek_resim_adi}", "${ucret!}", "${sayac!}", "${FirebaseAuth.instance.currentUser?.email}");
                      tekrar=tekrar-1;
                    }else{
                    }
                  },
                    child: const Text(
                      "Sepete Ekle", style: TextStyle(color: Colors.black),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white),
                  );
                },
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    );
  }
}
