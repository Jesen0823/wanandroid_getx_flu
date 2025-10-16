import '../../../enum/tag_type.dart';
import '../../../base/base_request_controller.dart';
import '../../../entity/tab_entity.dart';
import '../../../enum/response_status.dart';
import '../../../pages/project_public_number/repository/project_repository.dart';

class ProjectController
    extends BaseRequestController<ProjectRepository, List<TabEntity>> {
  ProjectController(this.type);

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