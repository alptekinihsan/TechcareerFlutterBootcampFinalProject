import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bitirmeprojesi/ui/cubit/yemek_detay_cubit.dart';
import 'package:bitirmeprojesi/ui/screen/anasayfa.dart';
import 'package:bitirmeprojesi/ui/screen/bottum/bottum_page.dart';
import 'package:bitirmeprojesi/ui/screen/card/background.dart';
import 'package:bitirmeprojesi/data/entity/sepet_yemekler.dart';
import 'package:bitirmeprojesi/ui/cubit/sepetsayfa_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitirmeprojesi/ui/screen/profile.dart';
import 'package:bitirmeprojesi/ui/screen/search.dart';
import 'package:bitirmeprojesi/ui/screen/sepet.dart';
import 'package:bitirmeprojesi/ui/screen/yemek_detay.dart';

var bosmu;
var totalucret;

class CardBody extends StatefulWidget {


  CardBody({Key? key }) : super(key: key);

  @override
  State<CardBody> createState() => _CardBodyState();
}

class _CardBodyState extends State<CardBody> {

  String imgUrl = "http://kasimadalan.pe.hu/yemekler/resimler";
  @override
  void initState() {
    context.read<SepetSayfaCubit>().sepetVerileriYukle("${FirebaseAuth.instance.currentUser?.email}");// Uygulama açıldığında verileri getirecek
    bosmu=false;
    int ?sayac;
    totalucret;
    super.initState();
  }
  bool kontrol = false;
  bool ?arttir;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child:Stack(
          children: [
          Padding(
            padding: const EdgeInsets.only( top: 0),
            child: Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>BottumSayfa()))
                      .then((value) {context.read<SepetSayfaCubit>().sepetVerileriYukle("${FirebaseAuth.instance.currentUser?.email}");});//arayüzde güncelldik verileri//anlık olarak göstermesi için
                }, icon:const Icon(Icons.arrow_back)),


                Padding(
                  padding: const EdgeInsets.only(left:120),
                  child: Text("Sepet",style: TextStyle(fontSize: 20),),
                ),
              ],
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: BlocBuilder<SepetSayfaCubit,List<Sepet>>(
                builder: (context,sepetListesi){
                  if(sepetListesi.isEmpty){
                    return Center(
                        child: Text("Sepetiniz Boş"));
                    context.read<SepetSayfaCubit>().sepetVerileriYukle("${FirebaseAuth.instance.currentUser?.email}");// Uygulama açıldığında verileri getirecek
                    //listeleme yapacak kişi nesnesini alacak
                  }
                  else{
                    return Stack(children: [
                    ListView.builder(
                    itemCount: sepetListesi.length,
                      itemBuilder: (context,indeks){
                        var sepet = sepetListesi[indeks];
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: (){
                              context.read<SepetSayfaCubit>().sepetVerileriYukle("${FirebaseAuth.instance.currentUser?.email}");
                            },
                            child: SizedBox(width: size.width*0.15,height: size.height*0.19,
                              child: Card(
                                shadowColor:Colors.white ,
                                //surfaceTintColor: Colors.white12,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.elliptical(20, 20))),
                                child: Row(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.elliptical(40, 40))),
                                      child: Column(
                                        children: [
                                          SizedBox(width: size.width*0.3,height: 115,
                                            child:Image.network("${imgUrl}/${sepet.yemek_resim_adi}"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 16.0),
                                          child: Row(
                                            children: [
                                              Text(sepet.yemek_adi+"(${sepet.yemek_siparis_adet} adet)",style: const TextStyle(fontSize: 18),),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text("Ürün Fiyatı: ${sepet.yemek_fiyat} ₺",style: const TextStyle(fontSize: 20,color:Colors.blue),),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(),
                                          child: Row(
                                            children: [
                                              Row(mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 60.0),
                                                    child: Card(
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.elliptical(60, 60))),
                                                      child: SizedBox(width:size.width*0.25,height: size.height*0.04,
                                                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            GestureDetector(onTap: (){
                                                              for(var i =0; i<sepetListesi.length;i++){
                                                                int sayac=1;
                                                                int gelenFiyat = int.parse(sepet.yemek_fiyat);
                                                                int siparisAdet = int.parse(sepet.yemek_siparis_adet);
                                                                int ilkFiyat = gelenFiyat ~/ siparisAdet ;
                                                                if(sepet.yemek_adi == sepetListesi[i].yemek_adi){
                                                                  print("sepet ekleme ${sepetListesi[i].yemek_adi}");
                                                                  String yeniadet= sepetListesi[i].yemek_siparis_adet;
                                                                  print("yeniadet${yeniadet}");

                                                                  int yenisayac= int.parse(yeniadet)+sayac;
                                                                  print("Yeni Sayac${yenisayac}");

                                                                  int yeniFiyat = yenisayac*ilkFiyat;
                                                                  print("yeni fiyat ${yeniFiyat}");

                                                                  print("eski  fiyat ${sepetListesi[i].yemek_fiyat}");
                                                                  context.read<SepetSayfaCubit>().sil(int.parse(sepetListesi[i].sepet_yemek_id), "${FirebaseAuth.instance.currentUser?.email}");
                                                                  context.read<YemekDetayCubit>().sepeteEkle("${sepet.yemek_adi}", "${sepet.yemek_resim_adi}", "${yeniFiyat!.toString()}", "${yenisayac!.toString()}", "${FirebaseAuth.instance.currentUser?.email}");
                                                                  return;
                                                                }
                                                                setState(() {
                                                                  sepetListesi;
                                                                });
                                                              }


                                                            }, child: Icon(Icons.add,color: Colors.pink,)),
                                                            SizedBox(width:15,),
                                                            Text("${sepet.yemek_siparis_adet.toString()}"),
                                                            SizedBox(width:15,),
                                                            GestureDetector(onTap: (){
                                                              for(var i =0; i<sepetListesi.length;i++){
                                                                int sayac=1;
                                                                int gelenFiyat = int.parse(sepet.yemek_fiyat);
                                                                int siparisAdet = int.parse(sepet.yemek_siparis_adet);
                                                                int ilkFiyat = gelenFiyat ~/ siparisAdet ;
                                                                if(sepet.yemek_adi == sepetListesi[i].yemek_adi){
                                                                  print("sepet ekleme ${sepetListesi[i].yemek_adi}");
                                                                  String yeniadet= sepetListesi[i].yemek_siparis_adet;
                                                                  print("yeniadet${yeniadet}");

                                                                  int yenisayac= int.parse(yeniadet)-sayac;
                                                                  print("Yeni Sayac${yenisayac}");

                                                                  int yeniFiyat = yenisayac*ilkFiyat;
                                                                  print("yeni fiyat ${yeniFiyat}");

                                                                  print("eski  fiyat ${sepetListesi[i].yemek_fiyat}");

                                                                  if(yenisayac<=1){
                                                                    sayac=1;
                                                                    yeniFiyat=ilkFiyat*sayac;
                                                                    yenisayac=1;
                                                                  }
                                                                  context.read<SepetSayfaCubit>().sil(int.parse(sepetListesi[i].sepet_yemek_id), "${FirebaseAuth.instance.currentUser?.email}");
                                                                  context.read<YemekDetayCubit>().sepeteEkle("${sepet.yemek_adi}", "${sepet.yemek_resim_adi}", "${yeniFiyat!.toString()}", "${yenisayac!.toString()}", "${FirebaseAuth.instance.currentUser?.email}");
                                                                  return;
                                                                }
                                                                setState(() {


                                                                });
                                                              }

                                                            }, child: Icon(Icons.remove,color: Colors.pink,)

                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  IconButton(onPressed: (){
                                                    setState(() {
                                                      context.read<SepetSayfaCubit>().sil(int.parse(sepet.sepet_yemek_id),"${FirebaseAuth.instance.currentUser?.email}");
                                                    });
                                                  },
                                                      icon: Icon(Icons.delete_forever_outlined),iconSize:35),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          child: Row(
                            children: [
                                ((){
                                if(kontrol){
                                  int sonToplam=0;
                                  context.read<SepetSayfaCubit>().sepetVerileriYukle("${FirebaseAuth.instance.currentUser?.email}");
                                  for(var i =0; i<sepetListesi.length;i++){
                                    sonToplam=sonToplam+int.parse(sepetListesi[i].yemek_fiyat);
                                    print(sonToplam);

                                  }
                                  return  Center(
                                    child: Card(
                                        child: Text("Toplam Ücret: ${sonToplam} ₺",style: TextStyle(color: Colors.black,fontSize: 22),)),
                                  );
                                }else{
                                  return const Text("",style: TextStyle(color: Colors.red),);
                                }
                              }()),

                              IconButton(
                                onPressed: (){
                                  setState(() {
                                    kontrol=true;
                                  });
                                },

                                icon:Image.asset("assets/icons/siparis.png"),iconSize:30,

                              ),

                            ],
                          )
                          ),
                        ),

                    ],
                    );
                  }
                },

              ),
            ),
          ),
        ],
        ),
    );
  }
}
