import '../../../base/interface.dart';
import '../../../entity/base_entity.dart';
import '../../../entity/article_info_entity.dart';
import '../../../entity/page_entity.dart';
import '../../../http_util/request.dart' as http;
import '../../../http_util/api.dart';

class SearchResultRepository extends IRepository {
  Future<BaseEntity<PageEntity<List<ArticleInfoDatas>>>> searchKeyword(
      {required int page, required String keyword}) async {
    var params = <String, String>{};
    params["k"] = keyword;
    return await http.Request.post(
        api: Api.postQueryKey + page.toString() + "/json", params: params);
  }
}
