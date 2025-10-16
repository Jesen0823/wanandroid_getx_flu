import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../pages/home/controller/home_controller.dart';
import '../../../pages/home/repository/home_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeRepository(),
    );

    /// 需要通过tag来进行区分,避免RefreshController反复使用导致的内存泄露与崩溃
    Get.lazyPut(
      tag: HomeController.className,
      () => RefreshController(initialRefresh: true),
    );
    Get.lazyPut<int>(
      tag: HomeController.className,
      () => -1,
    );
    Get.lazyPut(
      () => HomeController(),
    );
  }
}
