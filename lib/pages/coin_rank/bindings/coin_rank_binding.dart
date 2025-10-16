import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';
import '../controller/coin_rank_controller.dart';
import '../repository/coin_rank_repository.dart';

class CoinRankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CoinRankRepository(),
    );

    /// 需要通过tag来进行区分,避免RefreshController反复使用导致的内存泄露与崩溃
    Get.lazyPut(
      tag: CoinRankController.className,
      () => RefreshController(initialRefresh: true),
    );
    Get.lazyPut<int>(
      tag: CoinRankController.className,
      () => 1,
    );
    Get.lazyPut(
      () => CoinRankController(),
    );
  }
}
