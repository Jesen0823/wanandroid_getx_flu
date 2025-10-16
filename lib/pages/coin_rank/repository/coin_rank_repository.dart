import '../../../base/interface.dart';
import '../../../base/interface.dart';
import '../../../entity/base_entity.dart';
import '../../../entity/coin_rank_entity.dart';
import '../../../entity/page_entity.dart';
import '../../../http_util/request.dart' as http;
import '../../../http_util/api.dart';

class CoinRankRepository extends IRepository {
  Future<BaseEntity<PageEntity<List<CoinRankDatas>>>> getCoinRankList(
          int page) =>
      http.Request.get(api: "${Api.getRankingList}${page.toString()}/json");
}
