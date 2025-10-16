import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wanandroid_getx_flu/enum/tag_type.dart';

import '../../common/status_view.dart';
import '../controller/tree_controller.dart';
import 'tree_cell.dart';

class TreePage extends GetView<TreeController> {
  const TreePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.type.title),
      ),
      body: StatusView(
        controller: controller,
        contentBuilder: (_) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: controller.data?.length ?? 0,
            itemBuilder: ((context, index) {
              final model = controller.data?[index];
              if (model != null) {
                return TreeCell(model);
              } else {
                return Container();
              }
            }),
          );
        },
      ),
    );
  }
}