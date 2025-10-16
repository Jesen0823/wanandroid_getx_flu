import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';

import '../controller/search_result_controller.dart';
import '../repository/search_result_repository.dart';

class SearchResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SearchResultRepository(),
    );
    Get.lazyPut(
      tag: SearchResultController.className,
      () => RefreshController(initialRefresh: true),
    );
    Get.lazyPut<int>(
      tag: SearchResultController.className,
      () => 1,
    );
    Get.lazyPut(
      () => SearchResultController(),
    );
  }
}
