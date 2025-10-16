import 'dart:async';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../account_manager/account_manager.dart';
import '../../../pages/web/controller/web_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:marquee/marquee.dart';

import '../../../base/interface.dart';
import '../../../extension/string_extension.dart';

class WebPage extends GetView<WebController> {
  late final WebViewController _webViewController;

  WebPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IWebLoadInfo webLoadInfo = Get.arguments;
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          // 页面开始加载回调（4.8.0 页面加载生命周期核心回调，替代旧版 onPageStarted 参数）
          onPageStarted: (String url) {
            print('Page started loading: $url');
            // 显示加载弹窗（原业务逻辑不变）
            Get.dialog(
              const Center(child: CircularProgressIndicator()),
              barrierDismissible: false,
            );
          },
          // 页面加载完成回调（4.8.0 页面加载生命周期核心回调，替代旧版 onPageFinished 参数）
          onPageFinished: (String url) {
            print('Page finished loading: $url');
            // 关闭加载弹窗（原业务逻辑不变）
            Get.back();
          },
        ),
      )
      ..loadRequest(
        Uri.parse(webLoadInfo.link ?? ''),
      );

    var isCollect = controller.isCollect(webLoadInfo).obs;
    var notShowCollectIcon = Get.parameters['notShowCollectIcon'];
    bool isShowCollectIcon;
    if (notShowCollectIcon == "true") {
      isShowCollectIcon = false;
    } else {
      isShowCollectIcon =
          webLoadInfo.id != null && AccountManager.shared.isLogin;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _title(webLoadInfo),
        actions: <Widget>[
          Visibility(
            visible: webLoadInfo.id != null,
            child: IconButton(
              icon: const Icon(Icons.open_in_new),
              onPressed: () {
                if (webLoadInfo.link != null) {
                  Share.share(webLoadInfo.link!);
                }
              },
            ),
          ),
          Visibility(
            visible: isShowCollectIcon,
            child: IconButton(
              icon: Obx(
                () {
                  final icon =
                      isCollect.value ? Icons.bookmark : Icons.bookmark_outline;
                  return Icon(icon);
                },
              ),
              onPressed: () async {
                final collectId = controller.realCollectId(webLoadInfo);
                Get.dialog(
                  const Center(
                    child: CircularProgressIndicator(), // 可替换为自定义动画
                  ),
                  barrierDismissible: false, // 禁止点击外部关闭
                );
                if (collectId != null) {
                  if (isCollect.value) {
                    final result =
                        await controller.unCollectAction(originId: collectId);
                    isCollect.value = !result;
                  } else {
                    final result =
                        await controller.collectAction(originId: collectId);
                    isCollect.value = result;
                  }
                }
                Get.back();
              },
            ),
          ),
        ],
      ),
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: SafeArea(
        child: Builder(builder: (BuildContext context) {
          return WebViewWidget(
            controller: _webViewController,
          );
        }),
      ),
    );
  }

  Widget _title(IWebLoadInfo webLoadInfo) {
    if (webLoadInfo.id != null) {
      return SizedBox(
        height: 44,
        child: Marquee(
            text: webLoadInfo.title.toString().replaceHtmlElement,
            showFadingOnlyWhenScrolling: true),
      );
    } else {
      return Text(
        webLoadInfo.title.toString(),
      );
    }
  }
}
