import 'package:flutter/material.dart';
import '../../../pages/common/refresh_header_footer.dart';
import '../../../pages/common/refresh_status_view.dart';
import '../../../routes/routes.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';
import '../../../pages/coin_rank/controller/coin_rank_controller.dart';

class CoinRankPage extends GetView<CoinRankController> {
  //const CoinRankPage({Key? key}) : super(key: key);
  const CoinRankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("积分排名"),
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
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: controller.dataSource.length,
              itemBuilder: (BuildContext context, int index) {
                final model = controller.dataSource[index];

                return ListTile(
                  leading: Text(model.rank.toString()),
                  title: Text(model.username.toString()),
                  trailing: Text('积分:${model.level.toString()}'),
                  onTap: () => Get.toNamed(Routes.hotKey),
                );
              },
              separatorBuilder: ((context, index) => const Divider()),
            ),
          );
        },
      ),
    );
  }
}
