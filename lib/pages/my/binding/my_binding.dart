import 'package:get/get.dart';

import '../../../pages/my/controller/my_controller.dart';
import '../../../pages/my/repository/my_repository.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      fenix: true,
      () => MyRepository(),
    );
    Get.lazyPut(
      fenix: true,
      () => MyController(),
    );
  }
}
