import 'package:flutter_local_notifications/flutter_local_notifications.dart';

var flp = FlutterLocalNotificationsPlugin();
Future<void> kurulum() async{
  var androidAyari = AndroidInitializationSettings("@mipmap/ic_launcher");

  var kurulumAyari = InitializationSettings(android: androidAyari);
  await flp.initialize(kurulumAyari);
}

Future<void> bildirimOlustur()async{

  var androidBildirimDetayi = AndroidNotificationDetails(
      "id", "name",
      channelDescription: "description",
      priority: Priority.high,importance: Importance.high);

  var bildirimDetayi = NotificationDetails(android: androidBildirimDetayi);
  await flp.show(5, "Arama Yapmak İçin", "Fotograf Yüklemeniz Lazım..", bildirimDetayi);

}
