import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bitirmeprojesi/data/entity/yemekler.dart';
import 'package:bitirmeprojesi/ui/cubit/anasayfa_cubit.dart';
import 'package:bitirmeprojesi/ui/screen/bottum/bottum_page.dart';
import 'package:bitirmeprojesi/ui/screen/search/background.dart';
import 'package:bitirmeprojesi/ui/screen/search/notification.dart';
import 'package:bitirmeprojesi/ui/screen/yemek_detay.dart';
import 'package:tflite/tflite.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({Key? key}) : super(key: key);

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {


  late File _image;
  late List _results;
  int secilenIndex = 0;
  bool imageSelect=false;
  bool imageSelecttwo=true;
  String imgUrl = "http://kasimadalan.pe.hu/yemekler/resimler";
  bool kontrol = false;
  @override
  void initState()
  {
    super.initState();
    loadModel();
    kurulum();
    context.read<AnasayfaCubit>().yemekleriYukle();// Uygulama açıldığında verileri getirecek

  }

  Future loadModel()
  async {
    Tflite.close();
    String res;
    res=(await Tflite.loadModel(model: "assets/model_unquant.tflite",labels: "assets/labels.txt"))!;
    print("Model yükleme: $res");
  }

  Future imageClassification(File image)
  async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults:14,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,

    );
    setState(() {
      _results=recognitions!;
      _image=image;
      imageSelect=true;
    });
  }
  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,);

    File image=File(pickedFile!.path);
    imageClassification(image);

  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(child: ListView(
    children: [
    SingleChildScrollView(
    child: Container(
    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all( 2.0),
          child: Row(
            children: [
              IconButton(onPressed: (){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>BottumSayfa()));
                //.then((value) {context.read<SepetSayfaCubit>().sepetVerileriYukle("${FirebaseAuth.instance.currentUser?.email}");});//arayüzde güncelldik verileri//anlık olarak göstermesi için
              }, icon:const Icon(Icons.arrow_back)),

              SizedBox(width: size.width*0.75,
                  child: Center(child: Text(" Yemek & İçecek Ara",style: TextStyle(fontSize: 20),),)),
              Row(
                children: [
                  IconButton(onPressed: (){
                    bildirimOlustur();
                    pickImage();
                    setState(() {
                      kontrol=true;
                    });
                  }, icon:const Icon(Icons.search)),

                ],
              ),
            ],

          ),
        ),

        /*Kategori kısmı buraya gelecek*/

        /*Fotograf ile Arama Kısmı*/
        SingleChildScrollView(
          child: BlocBuilder<AnasayfaCubit,List<Yemekler>>
            (builder: (context,yemekListesi) {
            return Column(
              children: (imageSelect) ? _results.map((result) {
                for (var i = 0; i < yemekListesi.length; i++) {
                  if (result["label"] == yemekListesi[i].yemek_adi) {
                    print("${yemekListesi[i].yemek_adi}");
                    print("${yemekListesi[i].yemek_resim_adi}");
                    print("${yemekListesi[i].yemek_fiyat} ₺");

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ((){
                            if(kontrol){
                              int sonucSayi=0;
                              for(var i =0; i<yemekListesi.length;i++){
                                if(result["label"] == yemekListesi[i].yemek_adi){
                                  sonucSayi=sonucSayi+1;
                                  print(sonucSayi);
                                }
                              }
                              return  Center(
                                child: Card(
                                    shadowColor: Colors.transparent,
                                    child: Text("Aramaya ait ${sonucSayi} sonuç bulundu...",style: TextStyle(color: Colors.black,fontSize: 18),)),
                              );
                            }else{
                              return const Text("Arama Yapmadınız !",style: TextStyle(color: Colors.red),);
                            }
                          }()),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: SizedBox(width: size.width*0.9,
                              child: Card(
                                color: Colors.white,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [

                                      Container(
                                        height: MediaQuery.of(context).size.height/4,
                                        width: MediaQuery.of(context).size.width/2,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Image.network("${imgUrl}/${yemekListesi[i].yemek_resim_adi}",
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
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: Text("${result["label"]}",
                                                  style: TextStyle(fontSize: 20,
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.black),),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: Text("Fiyat: ${yemekListesi[i].yemek_fiyat} ₺",
                                                  style: TextStyle(fontSize: 25,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black),),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: ElevatedButton(onLongPress:(){},onPressed: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>YemekDetay(yemek: yemekListesi[i],)));
                                                },
                                                  child: Text("${result["label"]} Detay", style: TextStyle(color: Colors.black),),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.white,
                                                    shadowColor: Colors.lightBlue,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }
                return Center();
              }).toList() : [],
            );
          }
          ),
        ),

        /*Kategori*/

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 22),
              child: Text("Diğer Seçenekler",
                style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(top: 30,left: 20),
          child: SingleChildScrollView(
            child: Container(
              child: Container(
                child: BlocBuilder<AnasayfaCubit,List<Yemekler>>(// dinlenecek yer belirlendi
                  builder: (context,yemeklerListesi){//kisiler listesini gönderecek
                    if(yemeklerListesi.isNotEmpty){//boş değilse
                      return Container(width: size.width,height:size.height*0.25,
                        child: Container(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: yemeklerListesi.length,//kişiler sayısı kadar getirecek
                            itemBuilder: (context,indeks){//0,1,2 gelecek indeksleme yapıyor.
                              var yemekler = yemeklerListesi[indeks];
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>YemekDetay(yemek: yemekler)))
                                      .then((value) {context.read<AnasayfaCubit>().yemekleriYukle(); });
                                },
                                child: Container(width: size.width*0.4,height: size.height*0.4,
                                  child: Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.elliptical(20, 30))),
                                    child: Column(
                                      children: [
                                        SizedBox(width: size.width,
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



        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 22),
              child: Text("Diğer Seçenekler",
                style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(top: 30,left: 20),
          child: SingleChildScrollView(
            child: Container(
              child: Container(
                child: BlocBuilder<AnasayfaCubit,List<Yemekler>>(
                  builder: (context,yemeklerListesi){
                    if(yemeklerListesi.isNotEmpty){
                      return Container(width: size.width,height:size.height*0.25,
                        child: Container(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            reverse: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: yemeklerListesi.length,
                            itemBuilder: (context,indeks){
                              var yemekler = yemeklerListesi[indeks];
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>YemekDetay(yemek: yemekler)))
                                      .then((value) {context.read<AnasayfaCubit>().yemekleriYukle(); });
                                },
                                child: Container(width: size.width*0.4,height: size.height*0.4,
                                  child: Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.elliptical(20, 30))),
                                    child: Column(
                                      children: [
                                        SizedBox(width: size.width,
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



      ],
    ),
    ),
    ),
    ],
    ),);
  }
}
