import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import '../Model/UserModel.dart';
import '../app_config.dart';
import 'AuthController.dart';

class ProfileController extends GetxController {
  AuthController authController = Get.put(AuthController());
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  Rx<UserModel> currentUser = UserModel().obs;
  var imageUrl = ''.obs;
  var errorMessage = ''.obs;
  final box = GetStorage();
  RxString imagePath = "".obs;
  late Client client;
  late Storage storage;

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

    await getUserDetails();
    //await loadUserDetails();
  }


  Future<void> getUserDetails() async {
    try {
      print("Fetching user details...");
      DocumentSnapshot snapshot = await db.collection("users").doc(
          auth.currentUser!.uid).get();

      if (snapshot.exists) {
        // Update the currentUser reactive variable with the fetched data
        currentUser.value =
            UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
        print("User data fetched successfully: ${currentUser.value.toJson()}");
      } else {
        print("No user data found for the current user.");
      }
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }


  Future<String?> uploadImageToAppwrite(File? imageFile) async {
    if (imageFile == null || imageFile.path.isEmpty) {
      print("Image file is null or the path is empty.");
      return null;
    }

    try {
      // Upload the image to the Appwrite storage bucket
      final response = await storage.createFile(
        bucketId: AppConfig.storageBucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: imageFile.path),
      );


      String downloadImageUrl =
          'https://cloud.appwrite.io/v1/storage/buckets/${AppConfig
          .storageBucketId}/files/${response.$id}/view?project=${AppConfig
          .projectId}';

      print("Image uploaded successfully. Image URL: $downloadImageUrl");
      return downloadImageUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<void> updateProfile(String imageUrl,
      String name,
      String about,
      String number,) async {
    isLoading.value = true;
    try {
      // Upload new image only if provided
      String? imageLink = imageUrl.isNotEmpty
          ? await uploadImageToAppwrite(File(imageUrl))
          : currentUser.value.profileImage;

      // Ensure the URL is clean
      if (imageLink != null && imageLink.contains("&project=")) {
        print("Warning: Cleaned duplicate project parameter in URL.");
        imageLink = Uri.parse(imageLink).replace(queryParameters: {
          'project': AppConfig.projectId,
        }).toString();
      }

      // Update user data
      final updatedUser = UserModel(
        id: auth.currentUser!.uid,
        email: auth.currentUser!.email,
        name: name,
        about: about,
        profileImage: imageLink ?? currentUser.value.profileImage,
        phoneNumber: number,
      );

      await db.collection("users").doc(auth.currentUser!.uid).set(
        updatedUser.toJson(),
        SetOptions(merge: true),
      );

      currentUser.value = updatedUser;
      currentUser.refresh();
      print("Profile updated successfully.");
    } catch (ex) {
      print("An error occurred during profile update: $ex");
    } finally {
      isLoading.value = false;
    }
  }

  void clearUserDetails() {
    currentUser.value = UserModel();  // Reset to empty model or null values as needed
  }
}

