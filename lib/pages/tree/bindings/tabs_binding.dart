import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../enum/tag_type.dart';
import '../controller/tabs_controller.dart';
import '../repository/tab_list_repository.dart';
import '../repository/tabs_repository.dart';


class TabsBinding extends Bindings {
  TabsBinding(this.type);

  TagType type;

  @override
  void dependencies() {
    Get.lazyPut(
      () => TabsRepository(type),
    );
    Get.lazyPut(
      () => TabsController(type),
    );
    Get.lazyPut(
      () => TabListRepository(),
    );
  }
}
