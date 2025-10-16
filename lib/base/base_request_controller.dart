import 'package:get/get.dart';

import '../entity/base_entity.dart';
import '../enum/response_status.dart';
import 'interface.dart';

abstract class BaseRequestController<R extends IRepository, T>
    extends GetxController {
  late R request;

  BaseEntity<T>? response;

  ResponseStatus status = ResponseStatus.loading;

  T? data;

  @override
  void onInit() async {
    super.onInit();
    request = Get.find<R>();
  }

  Future<void> aRequest({
    Map<String, dynamic>? parameters,
  }) async {}
}
