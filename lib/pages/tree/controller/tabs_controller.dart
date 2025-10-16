
import '../../../base/base_request_controller.dart';
import '../../../entity/tab_entity.dart';
import '../../../enum/response_status.dart';
import '../../../enum/tag_type.dart';
import '../repository/tabs_repository.dart';


class TabsController
    extends BaseRequestController<TabsRepository, List<TabEntity>> {
  TabsController(this.type);

  TagType type;

  @override
  void onInit() async {
    super.onInit();
    aRequest();
  }

  @override
  Future<void> aRequest({Map<String, dynamic>? parameters}) async {
    response = await request.getTab();
    data = response?.data ?? [];
    status = response?.responseStatus ?? ResponseStatus.loading;
    update();
  }
}