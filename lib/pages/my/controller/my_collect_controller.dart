import 'package:get/get.dart';

import '../../../base/base_refresh_controller.dart';
import '../../../base/interface.dart';
import '../../../enum/response_status.dart';
import '../../../entity/article_info_entity.dart';
import '../../../pages/my/repository/my_collect_repository.dart';
import '../../../enum/scroll_view_action_type.dart';
import '../../../account_manager/account_manager.dart';

class MyCollectController
    extends BaseRefreshController<MyCollectRepository, ArticleInfoDatas>
    implements IClassName {
  @override
  void onInit() {
    super.onInit();
    initPage = Get.find(tag: MyCollectController.className);
    page = initPage;
    refreshController = Get.find(tag: MyCollectController.className);
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
    response = await request.getCollectArticleList(page: page);
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

  Future<void> unCollectAction({required int index}) async {
    var model = await request.unCollectAction(
        originId: dataSource[index].originId ?? 0);

    String message;
    if (model.isSuccess) {
      if ((AccountManager.shared.info?.collectIds ?? [])
          .contains(dataSource[index].originId)) {
        (AccountManager.shared.info?.collectIds ?? [])
            .remove(dataSource[index].originId);
      }
      dataSource.removeAt(index);
      message = "取消收藏成功";
    } else {
      message = model.errorMsg.toString();
    }

    Get.snackbar(
      "",
      message,
      duration: const Duration(seconds: 1),
    );

    update();
  }

  static String? get className => (MyCollectController).toString();
}
