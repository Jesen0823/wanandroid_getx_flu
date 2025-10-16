import 'package:flutter/material.dart';
import '../../../../pages/common/info_cell.dart';
import '../../../../pages/common/refresh_header_footer.dart';
import '../../../../pages/common/refresh_status_view.dart';
import '../../../../pages/search_result/controller/search_result_controller.dart';
import '../../../../routes/routes.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';

class SearchResultPage extends GetView<SearchResultController> {
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: RefreshStatusView(
        controller: controller,
        contentBuilder: (_) {
          return SmartRefresher(
            enablePullUp: true,
            header: const RefreshHeader(),
            footer: const RefreshFooter(),
            controller: controller.refreshController,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoadMore,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.dataSource.length,
              itemBuilder: (BuildContext context, int index) {
                final model = controller.dataSource[index];
                return InfoCell(
                  model: model,
                  callback: (_) => Get.toNamed(Routes.web, arguments: model),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
