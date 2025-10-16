import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid_getx_flu/enum/tag_type.dart';
import 'package:wanandroid_getx_flu/extension/string_extension.dart';
import 'package:wanandroid_getx_flu/pages/tree/view/tab_list_page.dart';

import '../../../enum/scroll_view_action_type.dart';
import '../../common/status_view.dart';
import '../controller/tab_list_controller.dart';
import '../controller/tabs_controller.dart';



class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final _tabsController = Get.find<TabsController>();

  final _alreadyRequestIndex = Set<int>();

  final _tabListControllers = <TabListController>[];

  late TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: StatusView<TabsController>(
        controller: _tabsController,
        contentBuilder: (_) {
          _tabController = TabController(
              length: _tabsController.data?.length ?? 0, vsync: this);
          _tabController.addListener(() {
            var index = _tabController.index;
            var value = _tabController.animation?.value;

            ///修复执行2次的BUG,增加条件
            if (index == value && index == _tabController.length - 1) {
              if (!_alreadyRequestIndex.contains(index)) {
                _alreadyRequestIndex.add(index);
                _tabListControllers[index]
                    .aRequest(type: ScrollViewActionType.refresh);
              } else {
                print("已经包含不用请求");
              }
            }
          });
          return Scaffold(
            appBar: AppBar(
              //title: Text(_tabsController.type.title),
              title: _tabBar(_tabController),
            ),
            body: TabBarView(
              controller: _tabController,
              children: _createTabsPage(),
            ),
          );
        },
      ),
    );
  }

  TabBar _tabBar(TabController controller) {
    return TabBar(
      tabs: (_tabsController.data ?? []).map(
        (model) {
          return Tab(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Text(model.name.toString().replaceHtmlElement),
            ),
          );
        },
      ).toList(),
      controller: controller,
      isScrollable: true,
      indicatorColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: const TextStyle(color: Colors.white, fontSize: 20),
      unselectedLabelStyle: const TextStyle(color: Colors.grey, fontSize: 18),
      labelColor: Colors.white,
      labelPadding: const EdgeInsets.all(0.0),
      indicatorPadding: const EdgeInsets.all(0.0),
      indicatorWeight: 2.3,
      unselectedLabelColor: Colors.white,
    );
  }

  List<Widget> _createTabsPage() {
    return (_tabsController.data ?? []).map((model) {
      final controller = TabListController();
      controller.tagType = _tabsController.type;
      controller.id = model.id.toString();
      controller.request = Get.find();
      controller.refreshController = RefreshController(initialRefresh: true);
      controller.page = _tabsController.type.pageNum;
      controller.initPage = _tabsController.type.pageNum;
      Get.put(controller, tag: model.id.toString());
      _tabListControllers.add(controller);
      return TabListPage(
        controller: controller,
      );
    }).toList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
