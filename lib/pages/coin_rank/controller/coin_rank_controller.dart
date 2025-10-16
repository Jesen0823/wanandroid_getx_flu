import 'package:get/get.dart';

import '../../../base/base_refresh_controller.dart';
import '../../../entity/coin_rank_entity.dart';
import '../../../base/interface.dart';
import '../../../enum/response_status.dart';
import '../../../pages/coin_rank/repository/coin_rank_repository.dart';
import '../../../enum/scroll_view_action_type.dart';

class CoinRankController
    extends BaseRefreshController<CoinRankRepository, CoinRankDatas>
    implements IClassName {
  @override
  void onInit() {
    super.onInit();
    initPage = Get.find<int>(tag: CoinRankController.className);
    page = initPage;
    refreshController = Get.find(tag: CoinRankController.className);
  }

  @override
  Future<void> onRefresh() async {
    page = initPage;
    await aRequest(type: ScrollViewActionType.refresh);
  }

  @override
  Future<void> onLoadMore() async {
    page = page + 1;
    await aRequest(type: ScrollViewActionType.loadMore);
  }

  @override
  Future<void> aRequest({
    required ScrollViewActionType type,
    Map<String, dynamic>? parameters,
  }) async {
    response = await request.getCoinRankList(page);
    status = response?.responseStatus ?? ResponseStatus.loading;

    final models = response?.data?.dataSource ?? [];

    switch (type) {
      case ScrollViewActionType.refresh:
        dataSource.clear();
        dataSource.addAll(models);
        break;
      case ScrollViewActionType.loadMore:
        dataSource.addAll(models);
        break;
    }

    refreshControllerStatusUpdate(type);

    update();
  }

  static String? get className => (CoinRankController).toString();
}
