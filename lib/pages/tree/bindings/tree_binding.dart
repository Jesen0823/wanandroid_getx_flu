import 'package:get/get.dart';

import '../../../enum/tag_type.dart';
import '../controller/tree_controller.dart';
import '../repository/tree_repository.dart';


class TreeBinding extends Bindings {

  TreeBinding(this.type);

  TagType type;

  @override
  void dependencies() {
    Get.lazyPut(
      () => TreeRepository(type),
    );
    Get.lazyPut(
      () => TreeController(type),
    );
  }
}