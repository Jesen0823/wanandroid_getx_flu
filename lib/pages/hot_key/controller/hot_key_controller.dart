import '../../../base/base_request_controller.dart';
import '../../../enum/response_status.dart';
import '../../../entity/hot_key_entity.dart';
import '../../../pages/hot_key/repository/hot_key_repository.dart';

class HotKeyController
    extends BaseRequestController<HotKeyRepository, List<HotKeyEntity>> {
  @override
  void onInit() async {
    super.onInit();
    aRequest();
  }

  @override
  Future<void> aRequest({Map<String, dynamic>? parameters}) async {
    response = await request.getHotKey();
    data = response?.data ?? [];
    status = response?.responseStatus ?? ResponseStatus.loading;
    update();
  }
}
