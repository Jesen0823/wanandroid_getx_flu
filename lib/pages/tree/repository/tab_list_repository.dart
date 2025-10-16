import '../../../base/interface.dart';
import '../../../entity/base_entity.dart';
import '../../../entity/article_info_entity.dart';
import '../../../entity/page_entity.dart';
import '../../../enum/tag_type.dart';
import '../../../http_util/request.dart' as http;
import '../../../http_util/api.dart';

class TabListRepository extends IRepository {

  Future<BaseEntity<PageEntity<List<ArticleInfoDatas>>>> getList({
    required int page,
    required String id,
    required TagType tagType,
  }) async {
    switch (tagType) {
      case TagType.project:
        var params = <String, String>{};
        params["cid"] = id.toString();
        final api = "${Api.getProjectClassifyList}${page.toString()}/json";
        return await http.Request.get(api: api, params: params);
      case TagType.publicNumber:
        final api =
            "${Api.getPubilicNumberList}${id.toString()}/${page.toString()}/json";
        return await http.Request.get(api: api);
      case TagType.tree:
        return BaseEntity<PageEntity<List<ArticleInfoDatas>>>(null, null, null);
    }
  }
}
