import '../../../base/interface.dart';
import '../../../entity/base_entity.dart';
import '../../../entity/hot_key_entity.dart';
import '../../../http_util/request.dart' as http;
import '../../../http_util/api.dart';

class HotKeyRepository extends IRepository {
  Future<BaseEntity<List<HotKeyEntity>>> getHotKey() =>
      http.Request.get(api: Api.getSearchHotKey);
}
