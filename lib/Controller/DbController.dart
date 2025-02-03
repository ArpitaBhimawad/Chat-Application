
import 'package:appwrite/appwrite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:whatsappnew/Model/UserModel.dart';

class DbController extends GetxController{
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  late Client client;
  late Storage storage;
  RxList<UserModel> userList=<UserModel>[].obs;
  RxBool isLoading=false.obs;

  @override
  void onInit() async {
    super.onInit();
    // Initialize Appwrite client and storage
    client = Client()
      ..setEndpoint(
          'https://cloud.appwrite.io/v1') // Replace with your Appwrite endpoint
      ..setProject(
          '6790df2f003282014c3f'); // Replace with your Appwrite project ID
    storage = Storage(client);
    await getUserList();
  }

  Future<void> getUserList() async{
    isLoading.value=true;
   try{
     await db.collection("users").get().then(
           (value)=>{
         userList.value= value.docs.
         map(
                 (e)=> UserModel.fromJson(
                 e.data()
             )
         ).toList(),
       },
     );
   }catch(ex){
     print(ex);
   }
   isLoading.value=false;
  }
}