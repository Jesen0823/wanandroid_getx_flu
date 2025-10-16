import '../../../base/interface.dart';
import '../../../entity/article_info_entity.dart';
import '../../../entity/base_entity.dart';
import '../../../entity/banner_entity.dart';
import '../../../entity/page_entity.dart';
import '../../../http_util/request.dart' as http;
import '../../../http_util/api.dart';

class HomeRepository extends IRepository {
  Future<BaseEntity<List<BannerEntity>>> getBanner() =>
      http.Request.get(api: Api.getBanner);

  Future<BaseEntity<List<ArticleInfoDatas>>> getTopArticleList() =>
      http.Request.get(api: Api.getTopArticleList);

  Future<BaseEntity<PageEntity<List<ArticleInfoDatas>>>> getArticleList(
          {required int page}) =>
      http.Request.get(api: "${Api.getArticleList}${page.toString()}/json");
}
