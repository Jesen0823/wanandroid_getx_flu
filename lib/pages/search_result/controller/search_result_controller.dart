import 'package:get/get.dart';
import '../../../base/base_refresh_controller.dart';
import '../../../base/interface.dart';
import '../../../entity/article_info_entity.dart';
import '../../../enum/response_status.dart';
import '../../../enum/scroll_view_action_type.dart';
import '../repository/search_result_repository.dart';


class SearchResultController
    extends BaseRefreshController<SearchResultRepository, ArticleInfoDatas>
    implements IClassName {
  @override
  void onInit() {
    super.onInit();
    initPage = Get.find(tag: SearchResultController.className);
    page = initPage;
    refreshController = Get.find(tag: SearchResultController.className);
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
    String keyword = Get.arguments;

    response = await request.searchKeyword(page: page, keyword: keyword);
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

  static String? get className => (SearchResultController).toString();
}
