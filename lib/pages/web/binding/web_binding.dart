import 'package:get/get.dart';

import '../controller/web_controller.dart';
import '../repository/web_repository.dart';



class WebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => WebRepository(),
    );
    Get.lazyPut(
      () => WebController(),
    );
  }
}