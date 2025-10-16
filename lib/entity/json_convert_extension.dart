import '../generated/json/base/json_convert_content.dart';

import '../entity/article_info_entity.dart';
import '../entity/coin_rank_entity.dart';
import '../entity/my_coin_history_entity.dart';
import '../entity/page_entity.dart';

extension MoreGenerics on JsonConvert {
  /// 解决泛型里面包含泛型的转换问题
  static final Map<String, JsonConvertFunction> genericsFuncMap = {
    "PageEntity<List<CoinRankDatas>>": PageEntity<List<CoinRankDatas>>.fromJson,
    "PageEntity<List<ArticleInfoDatas>>": PageEntity<List<ArticleInfoDatas>>.fromJson,
    "PageEntity<List<MyCoinHistoryDatas>>": PageEntity<List<MyCoinHistoryDatas>>.fromJson,
	};
}