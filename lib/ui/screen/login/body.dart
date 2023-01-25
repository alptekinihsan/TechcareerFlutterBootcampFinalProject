import 'package:flutter/material.dart';
import 'package:bitirmeprojesi/ui/cubit/firebase.dart';
import 'package:bitirmeprojesi/ui/screen/bottum/bottum_page.dart';
import 'package:bitirmeprojesi/ui/screen/login/background.dart';
import 'package:google_sign_in/google_sign_in.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  var tfKontrolEmail = TextEditingController();
  var tfKontrolPassword = TextEditingController();
  LoginForm auth = LoginForm();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Card(
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.elliptical(20, 30))),
            child: Column(
              children:  [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: const Text("Ahçıbaşı Giriş",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),
                    ),
                  ),
                ),
                Image.asset(
                  "assets/icons/ahcibasi.png",
                  width:100,
                  height:110,
                ),

                Container(
                  width: size.width*1.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                    child: ElevatedButton(
                      onPressed: (){
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>const Giris()));
                      },
                      child: TextField(
                        controller: tfKontrolEmail,
                        decoration: const InputDecoration(hintText: "E-Mail",prefixText: ' ',
                          prefixIcon: Icon(
                            Icons.mail_lock_rounded,
                            color: Colors.orangeAccent,
                          ),
                          hintStyle: TextStyle(color: Colors.orange),
                          focusColor: Colors.white,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                              )),
                        ),
                        keyboardType: TextInputType.emailAddress,

                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                  ),
                ),

                Container(
                  width: size.width*1.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                    child: ElevatedButton(
                      onPressed: (){
                      },
                      child: TextField(
                        controller: tfKontrolPassword,
                        decoration: const InputDecoration(hintText: "Şifre",prefixText: "",
                          prefixIcon: Icon(
                          Icons.keyboard,
                          color: Colors.orangeAccent,
                        ),
                        hintStyle: TextStyle(color: Colors.orange),
                        focusColor: Colors.white,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.redAccent,
                            )),
                      ),

                        keyboardType: TextInputType.text,
                        obscureText: true,
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  ElevatedButton(onPressed: (){
                    setState(() {
                      auth.signIn(tfKontrolEmail.text, tfKontrolPassword.text).then((value) {
                        return Navigator.push(context, MaterialPageRoute(builder: (context) => BottumSayfa()));
                      }).onError((error, stackTrace) {});

                    });

                  },
                    child: const Text("Giriş Yap"),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                    ),
                  ),

                  ElevatedButton(onPressed: (){
                    setState(() {

                      AuthService().signInWithGoogle();
                      auth.signIn(tfKontrolEmail.text, tfKontrolPassword.text).then((value) {
                        return Navigator.push(context, MaterialPageRoute(builder: (context) => BottumSayfa()));
                      }).onError((error, stackTrace) {});

                    });

                  },
                    child: const Text("Google ile Giriş Yap"),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                    ),
                  ),



                ],),


              ],

            ),
          ),
        ),
      ),
    );
  }
}
