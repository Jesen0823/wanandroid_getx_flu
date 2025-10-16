import '../../../base/interface.dart';
import '../../../enum/tag_type.dart';
import '../../../entity/base_entity.dart';
import '../../../entity/tab_entity.dart';
import '../../../http_util/request.dart' as http;

class TreeRepository extends IRepository {
  TreeRepository(this.type);

  TagType type;

  Future<BaseEntity<List<TabEntity>>> getTab() =>
      http.Request.get(api: type.tabApi);
}
