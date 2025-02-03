import 'package:appwrite/appwrite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:whatsappnew/Model/ChatRoomModel.dart';
import 'package:whatsappnew/Model/UserModel.dart';

class ContactController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  late Client client;
  late Storage storage;
  RxList<UserModel> userList = <UserModel>[].obs;
  RxBool isLoading = false.obs;
  RxList<ChatRoomModel> chatRoomList= <ChatRoomModel>[].obs;
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
    await getChatRoomList();
  }

  Future<void> getUserList() async {
    isLoading.value = true;
    userList.clear();
    try {
      await db.collection("users").get().then(
            (value) => {
              userList.value =
                  value.docs.map((e) => UserModel.fromJson(e.data())).toList(),
            },
          );
    } catch (ex) {
      print(ex);
    }
    isLoading.value = false;
  }

  Future<void> getChatRoomList() async {
    List<ChatRoomModel> tempChatRoom = [];
    await db.collection('chats')
       .orderBy("timestamp",descending: true)
        .get()
        .then(
            (value) {
              tempChatRoom = value.docs
              .map((e) => ChatRoomModel.fromJson(e.data())).toList();
    });

    chatRoomList.value=tempChatRoom
        .where(
        (e)=>e.id!.contains(
            auth.currentUser!.uid,
        ),
    ).toList();
    print(chatRoomList);
    //print(ourChatRooms);
  }

  Future<void> saveContact(UserModel user)async{
    try{
      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("contacts")
          .doc(user.id)
          .set(user.toJson());
    }catch(ex){
      print("Error in Contact");
      print(ex);
    }
  }

  Stream<List<UserModel>> getContacts(){
    return db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("contacts")
        .snapshots()
        .map(
           (snapshot)=> snapshot.docs
               .map(
                 (doc)=>UserModel.fromJson(doc.data()),
          ).toList(),
    );
  }

  // Stream<List<UserModel>> getContacts() {
  //   if (auth.currentUser == null) {
  //     print("Error: User is not logged in");
  //     return Stream.value([]); // Return an empty list if user is not logged in
  //   }
  //
  //   return db
  //       .collection("users")
  //       .doc(auth.currentUser!.uid)
  //       .collection("contacts")
  //       .snapshots()
  //       .map(
  //         (snapshot) => snapshot.docs
  //         .map(
  //           (doc) => UserModel.fromJson(doc.data()),
  //     )
  //         .toList(),
  //   );
  // }

}
