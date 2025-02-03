import 'package:appwrite/appwrite.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:whatsappnew/Config/PagePath.dart';
import 'package:whatsappnew/app_config.dart';
import 'package:whatsappnew/firebase_options.dart';
import 'Config/Themes.dart';
import 'Pages/SplashPage/SplashPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Client client = Client()
      .setEndpoint(AppConfig.endpoint)
      .setProject(AppConfig.projectId);

  Storage storage = Storage(client);
  runApp(const MyApp(

  ));
 }
class MyApp extends StatelessWidget {
  const MyApp({super.key, });


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: FToastBuilder(),
      title: 'Flutter Demo',
      theme:lightTheme,
      getPages: pagePath,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home:const SplashPage(),
    );
  }
}

