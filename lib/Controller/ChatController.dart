import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:whatsappnew/Controller/ContactController.dart';
import 'package:whatsappnew/Controller/ProfileController.dart';
import 'package:whatsappnew/Model/ChatModel.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsappnew/Model/UserModel.dart';
import '../Model/ChatRoomModel.dart';


class ChatController extends GetxController {
  ContactController contactController=Get.put(ContactController());
  ProfileController profileController=Get.put(ProfileController());
  var uuid = Uuid();
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
   RxString selectedImagePath=" ".obs;
   String getRoomId(String targetUserId) {
    String currentUserId = auth.currentUser!.uid;



    // Sort the user IDs to generate a consistent room ID
    List<String> sortedIds = [currentUserId, targetUserId]..sort();
    String roomId = sortedIds.join('_');

    print("Generated roomId: $roomId"); // Debugging
    return roomId;
  }

  UserModel getSender(UserModel currentUser,UserModel targetUser){
    String currentUserId=currentUser.id!;
    String targetUserId=targetUser.id!;
    if(currentUserId[0].codeUnitAt(0) >targetUserId[0].codeUnitAt(0)){
      return currentUser;
    }else{
      return targetUser;
    }
  }

  UserModel getReceiver(UserModel currentUser,UserModel targetUser){
    String currentUserId=currentUser.id!;
    String targetUserId=targetUser.id!;
    if(currentUserId[0].codeUnitAt(0) >targetUserId[0].codeUnitAt(0)){
      return targetUser;
    }else{
      return currentUser;
    }
  }

  Future<void> sendMessage(String targetUserId, String message,UserModel targetUser) async {
    isLoading.value = true;

    String chatId = uuid.v6(); // Generate unique chat ID
    String roomId = getRoomId(targetUserId); // Get room ID
    DateTime timestamp=DateTime.now();
    String nowTime=DateFormat('hh :mm a').format(timestamp);

    UserModel sender=getSender(profileController.currentUser.value, targetUser);
    UserModel receiver=getReceiver(profileController.currentUser.value, targetUser);


    RxString imageUrl = "".obs;
    if (selectedImagePath.value.isNotEmpty) {
      File imageFile = File(selectedImagePath.value); // Convert path to File
      String? uploadedUrl = await profileController.uploadImageToAppwrite(imageFile);

      if (uploadedUrl != null) {
        imageUrl.value = uploadedUrl;
      } else {
        print("Image upload failed.");
      }
    }
    var newChat = ChatModel(
      id: chatId,
      message: message,
      imageUrl: imageUrl.value,
      senderId:auth.currentUser!.uid,
      receiverId: targetUserId,
      senderName:profileController.currentUser.value.name,
      timestamp: DateTime.now().toString(),
    );



    var roomDetails=ChatRoomModel(
      id:roomId,
      lastMessage:message,
      lastMessageTiming:nowTime,
      sender:sender,
      receiver:receiver,
      timestamp:DateTime.now().toString(),
      unReadMessage: 0,
    );

    try {
      await db.collection("chats")
          .doc(roomId) // Room ID for the chat
          .collection("message") // Collection for messages within the room
          .doc(chatId) // Use the generated chat ID
          .set(newChat.toJson()); // Convert the chat model to JSON
      print("Message sent successfully, clearing selectedImagePath.");
      selectedImagePath.value ="";
      print("selectedImagePath after clearing: ${selectedImagePath.value}");

      await db.collection("chats")
          .doc(roomId)
          .set(roomDetails.toJson(),
      );

      await contactController.saveContact(targetUser);

    } catch (e) {
      print(e); // Handle errors
    }

    isLoading.value = false; // Update loading state
  }


  Stream<List<ChatModel>> getMessages(String targetUserId) {
    String roomId = getRoomId(targetUserId);

    print("Fetching messages for Room ID: $roomId"); // Debugging

    return db
        .collection("chats")
        .doc(roomId) // Room ID for the chat
        .collection("message")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) {
      print("Snapshot data: ${snapshot.docs}");
      return snapshot.docs.map((doc) {
        return ChatModel.fromJson(doc.data());
      }).toList();
    });
  }


}

