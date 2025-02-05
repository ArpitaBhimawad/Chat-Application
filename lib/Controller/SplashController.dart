import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{

  final auth=FirebaseAuth.instance;

  @override
  void onInit() async{
    super.onInit();
    await splaceHandle();
  }

  Future<void> splaceHandle() async {
    await Future.delayed(Duration(seconds: 3));

    if (auth.currentUser == null) {
      Get.offAllNamed("/authPage");
    } else {
      Get.offAllNamed("/homePage");
    }

    print("Hello");
  }}