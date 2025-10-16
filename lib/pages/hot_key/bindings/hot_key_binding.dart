import 'package:get/get.dart';

import '../../../pages/hot_key/repository/hot_key_repository.dart';
import '../../../pages/hot_key/controller/hot_key_controller.dart';

class HotKeyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HotKeyRepository(),
    );
    Get.lazyPut(
      () => HotKeyController(),
    );
  }
}