import 'package:get/get.dart';

import '../../../base/base_refresh_controller.dart';
import '../../../base/interface.dart';
import '../../../entity/my_coin_history_entity.dart';
import '../../../enum/response_status.dart';
import '../../../enum/scroll_view_action_type.dart';
import '../../../pages/my/repository/my_coin_history_repository.dart';

class MyCoinHistoryController
    extends BaseRefreshController<MyCoinHistoryRepository, MyCoinHistoryDatas>
    implements IClassName {
  @override
  void onInit() {
    super.onInit();
    initPage = Get.find<int>(tag: MyCoinHistoryController.className);
    page = initPage;
    refreshController = Get.find(tag: MyCoinHistoryController.className);
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

  static String? get className => (MyCoinHistoryController).toString();
}