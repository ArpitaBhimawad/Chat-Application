import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsappnew/Config/CustomMessage.dart';
import 'package:whatsappnew/Controller/ProfileController.dart';
import 'package:whatsappnew/Model/ChatModel.dart';
import 'package:whatsappnew/Model/UserModel.dart';
import 'package:whatsappnew/Pages/HomePage/HomePage.dart';

import '../Model/GroupModel.dart';

class GroupController extends GetxController{
  ProfileController profileController=Get.put(ProfileController());
  RxList<UserModel> groupMembers=<UserModel>[].obs;
  RxList<GroupModel> groupList=<GroupModel>[].obs;

  final db=FirebaseFirestore.instance;
  final auth=FirebaseAuth.instance;
  var uuid = Uuid();
  RxBool isLoading=false.obs;

  @override
  void onInit(){
    super.onInit();
    getGroup();
  }

  void selectMember(UserModel user){
    if(groupMembers.contains(user)){
      groupMembers.remove(user);
    }else{
      groupMembers.add(user);
    }
  }



  Future<void> createdGroup(String groupName, String imagePath) async {
    isLoading.value=true;
    String groupId = uuid.v6();
    groupMembers.add(
      UserModel(
        id:auth.currentUser!.uid,
        name: profileController.currentUser.value.name,
        profileImage: profileController.currentUser.value.profileImage,
        email:profileController.currentUser.value.email ,
        role: "admin",
      ),
    );
    try {
      if (auth.currentUser == null) {
        print("🚨 User is not authenticated!");
        return;
      }
      if (imagePath == null || imagePath.isEmpty) {
        print("🚨 Image path is invalid or empty!");
        return;
      }
      File imageFile = File(imagePath);
      String? imageUrl = await profileController.uploadImageToAppwrite(imageFile);
      if (imageUrl == null) {
        print("🚨 Image URL is null!");
        return;
      }

      if (groupMembers.isEmpty) {
        print("🚨 Group members list is empty!");
        return;
      }

      final groupData = {
        "id": groupId,
        "name": groupName,
        "profileUrl": imageUrl,
        "members": groupMembers.map((e) => e.toJson()).toList(),
        "createdAt": DateTime.now().toString(),
        "createdBy": auth.currentUser!.uid, // Ensure this is correct
        "timeStamp": DateTime.now().toString(),
      };

      print("🔥 Attempting to write to Firestore with data: $groupData");

      await db.collection("groups").doc(groupId).set(groupData);
      successMessage("Group Created");
      Get.offAll(HomePage());
      isLoading.value=false;
    } catch (e) {
      print("🚨 Firestore Write Error: $e");
    }
  }

  Future<void> getGroup()async {
    isLoading.value=true;
    List<GroupModel> tempGroup =[];
    await db.collection('groups').get().then(
        (value) {
          tempGroup = value.docs
              .map(
              (e) => GroupModel.fromJson(e.data()),
          ).toList();
        }
    );
    groupList.clear();
    groupList.value = tempGroup
    .where(
        (e) => e.members!.any(
            (element) =>element.id == auth.currentUser!.uid,
        ),
    ).toList();
    isLoading.value=false;
  }

  // Future<void> getGroup() async {
  //   isLoading.value = true;
  //
  //   var snapshot = await db.collection('groups').get();
  //   List<GroupModel> tempGroup = snapshot.docs.map((e) {
  //     print("Raw Firestore Data: ${e.data()}"); // Debug Firestore Data
  //     return GroupModel.fromJson(e.data());
  //   }).toList();
  //
  //   print("Total Groups Fetched: ${tempGroup.length}");
  //
  //   for (var group in tempGroup) {
  //     print("Group Name: ${group.name}");
  //     print("Members: ${group.members}");
  //   }
  //
  //   groupList.value = tempGroup.where((e) {
  //     bool hasCurrentUser = e.members!.any((element) => element.id == auth.currentUser!.uid);
  //     print("Group: ${e.name}, User in Group: $hasCurrentUser");
  //     return hasCurrentUser;
  //   }).toList();
  //
  //   print("Filtered Groups: ${groupList.length}");
  //
  //   isLoading.value = false;
  // }


  Future<void> sendGroupMessage(String message,String groupId, String imagePath)async {
    var chatId=uuid.v6();
    File imageFile = File(imagePath);
    String? imageUrl = await profileController.uploadImageToAppwrite(imageFile);
    var newChat=ChatModel(
      id: chatId,
      message: message,
      imageUrl: imageUrl,
      senderId: auth.currentUser!.uid,
      senderName: profileController.currentUser.value.name,
      timestamp: DateTime.now().toString(),
    );
    await db.collection("groups")
        .doc(groupId)
        .collection("messages")
        .doc(chatId)
        .set(
      newChat.toJson(),
    );
  }

  Stream<List<ChatModel>> getGroupMessages(String groupId){
     return db
         .collection("groups")
         .doc(groupId)
         .collection("messages")
         .orderBy("timestamp",descending: true)
         .snapshots()
         .map(
         (snapshot) =>snapshot.docs
             .map(
             (doc) => ChatModel.fromJson(doc.data()),
         ).toList()
     );
  }
}