import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  final ImagePicker picker = ImagePicker();
  var selectedImagePath = ''.obs;


  Future<String?> pickImage() async {
    // Pick image from the camera
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image!=null){
      return image.path;
    }
     else{
       return "";
    }
  }

  Future<String?> pickImageGallary() async {
    // Pick image from the camera
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image!=null){
      return image.path;
    }
    else{
      return "";
    }
  }

}








