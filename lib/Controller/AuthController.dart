
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsappnew/Controller/ProfileController.dart';
import '../Model/UserModel.dart';
import 'ContactController.dart';

class AuthController extends GetxController {
  //ProfileController profileController=Get.put(ProfileController());
final auth =FirebaseAuth.instance;
final db= FirebaseFirestore.instance;

RxBool isLoading =false.obs;

  Future<void>loginFunction(String emailAddress, String password)async {
    isLoading.value=true;
    try {
      await auth.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      print('Login successful');
      // Access ProfileController using Get.find() and fetch user details
      ProfileController profileController = Get.find();
      profileController.getUserDetails();

      // Fetch contact list after login
      ContactController contactController = Get.find();
      await contactController.getUserList();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');

      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');

      }else{
        print('FirebaseAuth error: ${e.message}');
      }
    }catch(e){
      print('Unexpected Error :${e.toString()}');
      print(e);
    }
    isLoading.value=false;
  }

Future<void> createUser(String emailAddress, String password, String name) async {
  isLoading.value = true;

  try {
    // Create a new user with email and password
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    // If user creation is successful, initialize the user
    User? user = userCredential.user;
    if (user != null) {
      await initUser(emailAddress, name); // Your custom function to initialize user data
      print('User account created successfully!');
      print('User ID: ${user.uid}');
      print('User Email: ${user.email}');
    } else {
      print('Error: Firebase user is null.');
    }
  } on FirebaseAuthException catch (e) {
    // Handle FirebaseAuth-specific errors
    if (e.code == 'email-already-in-use') {
      print('The email address is already in use by another account.');
    } else if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'invalid-email') {
      print('The email address is not valid.');
    } else {
      print('FirebaseAuth error: ${e.message}');
    }
  } catch (e) {
    // Handle any other unexpected errors
    print('Unexpected error: $e');
  } finally {
    // Ensure loading state is updated
    isLoading.value = false;
  }
}


// Future<void> logoutUser() async{
//     await auth.signOut();
//     Get.offAllNamed("/authPage");
// }

  Future<void> logoutUser() async {
    try {
      // Clear user details in ProfileController
      ProfileController profileController = Get.find();
      profileController.clearUserDetails();

      // Log out the current user
      await auth.signOut();
      Get.delete<ContactController>();  // Reset controller
      Get.put(ContactController());     // Reinitialize
      Get.offAllNamed("/authPage");
    } catch (e) {
      print("Error during logout: $e");
    }
  }



  Future<void> initUser(String email, String name) async {
    if (auth.currentUser != null) {
      var newUser = UserModel(
        email: email,
        name: name,
        id: auth.currentUser!.uid,
      );

      try {
        await db.collection("users").doc(auth.currentUser!.uid).set(newUser.toJson());
        print('User data initialized successfully');
      } catch (e) {
        print('Error saving user data: $e');
      }
    } else {
      print('User is not signed in');
    }
  }

}