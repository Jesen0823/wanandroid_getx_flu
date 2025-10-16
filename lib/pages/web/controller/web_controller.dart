import 'package:get/get.dart';

import '../../../account_manager/account_manager.dart';
import '../../../base/base_request_controller.dart';
import '../../../base/interface.dart';
import '../repository/web_repository.dart';


class WebController extends BaseRequestController<WebRepository, Object?> {
  void Function()? hasActionCallback;

  Future<bool> unCollectAction({required int originId}) async {
    var model = await request.unCollectAction(originId: originId);

    String message;
    if (model.isSuccess) {
      if ((AccountManager.shared.info?.collectIds ?? []).contains(originId)) {
        (AccountManager.shared.info?.collectIds ?? []).remove(originId);
      }
      message = "取消收藏成功";
      if (hasActionCallback != null) {
        hasActionCallback!();
      }
    } else {
      message = model.errorMsg.toString();
    }

    Get.snackbar(
      "success",
      message,
      duration: const Duration(seconds: 1),
    );

    return model.isSuccess;
  }

  Future<bool> collectAction({required int originId}) async {
    var model = await request.collectAction(originId: originId);

    String message;
    if (model.isSuccess) {
      (AccountManager.shared.info?.collectIds ?? []).add(originId);
      message = "收藏成功";
      if (hasActionCallback != null) {
        hasActionCallback!();
      }
    } else {
      message = model.errorMsg.toString();
    }

    Get.snackbar(
      "",
      message,
      duration: const Duration(seconds: 1),
    );

    return model.isSuccess;
  }

  bool isCollect(IWebLoadInfo webLoadInfo) {
    final collectId = realCollectId(webLoadInfo);
    final collectIds = AccountManager.shared.info?.collectIds;
    if (collectIds != null && collectId != null) {
      if (collectIds.contains(collectId)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  int? realCollectId(IWebLoadInfo webLoadInfo) {
    final id = webLoadInfo.id;
    final collectId = webLoadInfo.originId;
    if (collectId == null && id != null) {
      return id;
    } else {
      return collectId;
    }
  }
}
