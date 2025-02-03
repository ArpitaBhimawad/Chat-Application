// import 'dart:io';
// import 'package:appwrite/appwrite.dart';
// import 'package:get/get.dart';
//
// class AppwriteService {
//   final Client client;
//   final Storage storage;
//
//   AppwriteService({required this.client}) : storage = Storage(client);
// }
import 'package:appwrite/appwrite.dart';

class AppwriteService {
  // Singleton instance
  static final AppwriteService _instance = AppwriteService._internal();

  // Appwrite Client and services
  late final Client client;
  late final Account account;
  late final Databases database;

  // Private constructor
  AppwriteService._internal() {
    client = Client()
        .setEndpoint('https://cloud.appwrite.io/v1') // Replace with your endpoint
        .setProject('[6790df2f003282014c3f]');
      //..setKey('your_api_key');// Replace with your project ID
     //.setSelfSigned();
    account = Account(client);
    database = Databases(client);
  }

  // Getter for the singleton instance
  static AppwriteService get instance => _instance;
}
