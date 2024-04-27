import 'package:get/get.dart';

class FolderController extends GetxController {
  var folderList = [].obs;

  updateFolder(list) {
    folderList.value = list;
  }
}
