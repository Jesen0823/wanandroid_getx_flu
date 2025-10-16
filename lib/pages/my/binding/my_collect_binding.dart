import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';

import '../../../pages/my/controller/my_collect_controller.dart';
import '../../../pages/my/repository/my_collect_repository.dart';

class MyCollectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MyCollectRepository(),
    );
    Get.lazyPut(
      tag: MyCollectController.className,
      () => RefreshController(initialRefresh: true),
    );
    Get.lazyPut<int>(
      tag: MyCollectController.className,
      () => 0,
    );
    Get.lazyPut(
      () => MyCollectController(),
    );
  }
}