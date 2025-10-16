import '../../../base/interface.dart';
import '../../../entity/base_entity.dart';
import '../../../entity/coin_rank_entity.dart';

import '../../../http_util/request.dart' as http;
import '../../../http_util/api.dart';
import '../../../entity/account_info_entity.dart';

class MyRepository extends IRepository {
  Future<BaseEntity<AccountInfoEntity>> login(
      {required String username, required String password}) async {
    var params = <String, String>{};
    params["username"] = username;
    params["password"] = password;
    return await http.Request.post(api: Api.postLogin, params: params);
  }

  Future<BaseEntity<AccountInfoEntity>> register(
      {required String username,
      required String password,
      required String rePassword}) async {
    var params = <String, String>{};
    params["username"] = username;
    params["password"] = password;
    params["repassword"] = rePassword;
    return await http.Request.post(api: Api.postRegister, params: params);
  }

  Future<BaseEntity<Object?>> logout() => http.Request.get(api: Api.getLogout);

  Future<BaseEntity<CoinRankDatas>> getUserCoinInfo() => http.Request.get(api: Api.getUserCoinInfo);
}
