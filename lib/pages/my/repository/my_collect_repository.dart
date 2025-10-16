import '../../../base/interface.dart';
import '../../../entity/base_entity.dart';
import '../../../entity/article_info_entity.dart';
import '../../../entity/page_entity.dart';
import '../../../http_util/request.dart' as http;
import '../../../http_util/api.dart';

class MyCollectRepository extends IRepository {
  Future<BaseEntity<PageEntity<List<ArticleInfoDatas>>>> getCollectArticleList(
          {required int page}) =>
      http.Request.get(
          api: Api.getCollectArticleList + page.toString() + "/json");

  Future<BaseEntity<Object?>> unCollectAction({required int originId}) => http.Request.post(
        api: Api.postUnCollectArticle + originId.toString() + "/json");
}
