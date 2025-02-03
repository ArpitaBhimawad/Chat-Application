import 'package:flutter/material.dart';

class abc{
  // Appwrite client and storage initialization
// Client client = Client()
//   ..setEndpoint('https://cloud.appwrite.io/v1') // Replace with your Appwrite endpoint
//   ..setProject('6790df2f003282014c3f') ;       // Replace with your Appwrite project ID
//                       // Use for self-signed certificates
//
// final Storage storage = Storage(client);

// Future<void> testUpdate() async {
//   final user = FirebaseAuth.instance.currentUser;
//
//   if (user != null) {
//     try {
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .set({
//         'name': 'John Doe',
//         'about': 'Flutter Developer',
//         'phoneNumber': '+1234567890',
//       }, SetOptions(merge: true));
//
//       print("Profile updated successfully!");
//     } catch (e) {
//       print("Error updating profile: $e");
//     }
//   } else {
//     print("User is not authenticated");
//   }
// }

// Future<void> updateProfile(
//     String imageUrl,
//     String name,
//     String about,
//     String number,
//     ) async {
//   isLoading = true;
//   print("Starting profile update...");
//
//   try {
//     // Step 1: Fetch user details before updating the profile
//     await profileController.getUserDetails();  // Wait for the data to be fetched before proceeding
//     print("User details fetched successfully: ${currentUser.value.toJson()}");
//
//     // Step 2: Upload image to Appwrite if a new image URL is provided
//     String? imageLink;
//     if (imageUrl.isNotEmpty) {
//       print("Uploading image...");
//       imageLink = await uploadImageToAppwrite(File(imageUrl));
//       if (imageLink != null) {
//         print("Image uploaded successfully. Link: $imageLink");
//       } else {
//         print("Image upload failed.");
//       }
//     } else {
//       print("No new image provided, using existing profile image.");
//     }

// Step 3: Create updated user model
//     print("Creating updated user model...");
//     final updatedUser = UserModel(
//       name: name,
//       about: about,
//       profileImage: imageLink ?? currentUser.value.profileImage,  // Use existing image if no new one is uploaded
//       phoneNumber: number,
//     );
//     print("Updated user model: ${updatedUser.toJson()}");
//
//     // Step 4: Update Firestore with new user data
//     print("Updating Firestore user collection...");
//     await profileController.db
//         .collection("users")
//         .doc(profileController.auth.currentUser!.uid)
//         .set(updatedUser.toJson());
//     currentUser.value = updatedUser;
//     print("Firestore update successful.");
//   } catch (ex) {
//     print("An error occurred during profile update: $ex");
//   } finally {
//     isLoading = false;
//     print("Profile update process completed.");
//   }
// }

// Future<void> pickAndUploadImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
  //
  //   if (pickedFile != null) {
  //     imagePath.value = pickedFile.path; // Update the image path to reflect the picked image
  //     File imageFile = File(pickedFile.path);
  //
  //     // Upload the image to Appwrite storage
  //     try {
  //       String? uploadedFileId = await uploadImageToAppwrite(imageFile);
  //
  //       if (uploadedFileId != null) {
  //         // Construct the download URL using the fileId
  //         // String downloadImageUrl =
  //         //     'https://cloud.appwrite.io/v1/storage/buckets/6791047b001289ddc724/files/$uploadedFileId/view';
  //         // print("Image uploaded successfully. Image URL: $downloadImageUrl");
  //
  //         // Update the imagePath with the fileId instead of the full URL (optional, if you want to track the ID separately)
  //         imagePath.value = uploadedFileId;
  //
  //         // You can choose to do something else here if needed (e.g., update state)
  //       } else {
  //         print("Failed to upload image");
  //       }
  //     } catch (e) {
  //       print("Error uploading image: $e");
  //     }
  //   } else {
  //     print("No image selected");
  //   }
  // }




  // Future<void> updateProfile(
  //     String imageUrl, // New image URL or existing one
  //     String name,
  //     String about,
  //     String number,
  //     ) async {
  //   isLoading.value = true;
  //   try {
  //     // If a new image is provided, upload it
  //     String? imageLink = imageUrl.isNotEmpty
  //         ? await uploadImageToAppwrite(File(imageUrl))
  //         : currentUser.value.profileImage; // Use the existing image if none is uploaded
  //
  //     // Construct updated user model
  //     final updatedUser = UserModel(
  //       name: name,
  //       about: about,
  //       profileImage: imageLink ?? currentUser.value.profileImage, // Retain the current image if not updated
  //       phoneNumber: number,
  //     );
  //
  //     // Update Firestore
  //     await db
  //         .collection("users")
  //         .doc(auth.currentUser!.uid)
  //         .set(updatedUser.toJson(), SetOptions(merge: true));
  //
  //     // Update local reactive data
  //     currentUser.value = updatedUser;
  //     currentUser.refresh(); // Trigger UI update
  //     print("Profile updated successfully.");
  //   } catch (ex) {
  //     print("An error occurred during profile update: $ex");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }


// Future<void> createUser(String emailAddress, String password, String name) async {
  //   isLoading.value = true;
  //
  //   try {
  //     // Step 1: Create user in Firebase Authentication
  //     UserCredential userCredential = await auth.createUserWithEmailAndPassword(
  //       email: emailAddress,
  //       password: password,
  //     );
  //
  //     // Step 2: Fetch the UID from the Firebase user
  //     User? user = userCredential.user; // Firebase User object
  //     if (user != null) {
  //       String uid = user.uid; // Extract UID
  //
  //       // Step 3: Initialize the user in Appwrite
  //       await initUser(uid, emailAddress, name);
  //       print('User created and initialized successfully!');
  //     } else {
  //       print('Error: Firebase user is null.');
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     } else {
  //       print('FirebaseAuth error: ${e.message}');
  //     }
  //   } catch (e) {
  //     print('Unexpected Error: $e');
  //   }
  //
  //   isLoading.value = false;
  // }
  //

  // Future<void> initUser(String email,String name)async {
//    var newUser= UserModel(
//      email:email,
//      name:name,
//      id: auth.currentUser!.uid,
//    );
//    try{
//      await db.collection("users").doc(auth.currentUser!.uid).set(newUser.toJson(),);
//    }catch(ex){
//      print(ex);
//    }
// }


// Future<void> initUser(String userId, String email, String name) async {
  //   final appwrite = AppwriteService.instance;
  //
  //   try {
  //     // Step 1: Save user details in the Appwrite database
  //     await appwrite.database.createDocument(
  //       databaseId: '679112e9002f27da9b53', // Replace with your database ID
  //       collectionId: '67938480001428b5e6d4', // Replace with your collection ID
  //       documentId: userId, // Use the user ID as the document ID
  //       data: {
  //         'email': email,
  //         'name': name,
  //         'createdAt': DateTime.now().toIso8601String(),
  //       },
  //       permissions: [
  //         Permission.read(Role.user(userId)), // Allow the user to read their own data
  //         Permission.update(Role.user(userId)), // Allow the user to update their data
  //         Permission.delete(Role.user(userId)), // Allow the user to delete their data
  //       ],
  //     );
  //     print('User data initialized successfully in Appwrite');
  //   } catch (e) {
  //     print('Error saving user data in Appwrite: $e');
  //   }
  // }

  // Future<String?> pickImage() async {
  //   PermissionStatus status = await Permission.photos.request();
  //   if (status.isGranted) {
  //     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //     final XFile? photo = await picker.pickImage(source: ImageSource.camera);
  //     if (image != null) {
  //       print(image.path);
  //       return image.path;
  //     } else {
  //       print("No image selected");
  //       return null;
  //     }
  //   } else {
  //     print("Permission denied. Please enable it in settings.");
  //     openAppSettings();
  //     return null;
  //   }
  // }
}