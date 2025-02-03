import 'package:get/get.dart';
import 'package:whatsappnew/Pages/Auth/LoginForm.dart';
import 'package:whatsappnew/Pages/HomePage/HomePage.dart';
import 'package:whatsappnew/Pages/UserProfile/UpdateProfile.dart';

import '../Pages/Auth/AuthPage.dart';
import '../Pages/Chat/ChatPage.dart';
import '../Pages/ContactPage/ContactPage.dart';
import '../Pages/ProfilePage/ProfilePage.dart';



var pagePath=[
  GetPage(
      name: "/authPage",
      page: ()=>const AuthPage(),
      transition: Transition.rightToLeft,
  ),
  GetPage(
    name: "/homePage",
    page: ()=>const HomePage(),
    transition: Transition.rightToLeft,
  ),

  GetPage(
    name: "/loginPage",
    page: ()=>const LoginForm(),
    transition: Transition.rightToLeft,
  ),
  // GetPage(
  //   name: "/chatPage",
  //   page: ()=>const ChatPage(),
  //   transition: Transition.rightToLeft,
  // ),

  GetPage(
    name: "/contactPage",
    page: ()=> ContactPage(),
    transition: Transition.rightToLeft,
  ),

  GetPage(
    name: "/profilePage",
    page: ()=>ProfilePage(),
    transition: Transition.rightToLeft,
  ),

  // GetPage(
  //   name: "/updateProfile",
  //   page: ()=>const UserUpdateProfile(),
  //   transition: Transition.rightToLeft,
  // ),

];