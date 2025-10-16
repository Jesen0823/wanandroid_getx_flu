import '../../../base/interface.dart';
import '../../../entity/base_entity.dart';
import '../../../entity/my_coin_history_entity.dart';
import '../../../entity/page_entity.dart';
import '../../../http_util/request.dart' as http;
import '../../../http_util/api.dart';

class MyCoinHistoryRepository extends IRepository {
  Future<BaseEntity<PageEntity<List<MyCoinHistoryDatas>>>> getCoinRankList(
          int page) =>
      http.Request.get(api: "${Api.getCoinList}${page.toString()}/json");
}