// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// (inner Folder)
import 'widget_business.dart' as widget_business;
import 'inner_widgets/go_home_icon_button/widget_view.dart'
    as go_home_icon_button_view;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
class WidgetView extends StatelessWidget {
  WidgetView(
      {super.key,
      required widget_business.WidgetBusiness business,
      required this.pageTitle,
      this.isPageBackgroundBlue = false,
      required this.floatingActionButton,
      required this.child})
      : _business = business {
    _business.view = this;
  }

  // [오버라이드]
  // (위젯을 화면에 draw 할 때의 콜백)
  @override
  Widget build(BuildContext context) {
    return viewWidgetBuild(context: context);
  }

  // [public 변수]

  // [private 변수]
  // (위젯 비즈니스)
  final widget_business.WidgetBusiness _business;

  // (하위 위젯)
  final Widget child;

  // (플로팅 버튼)
  final FloatingActionButton? floatingActionButton;

  // (페이지 타이틀)
  final String pageTitle;

  // (페이지 배경색을 파란색으로 할지 여부)
  final bool isPageBackgroundBlue;

  // [public 함수]

  // [private 함수]

  // [뷰 위젯]
  // !!!뷰 위젯 반환 콜백 작성 하기!!!
  Widget viewWidgetBuild({required BuildContext context}) {
    // Mobile 앱 status bar 색상 변경
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: !kIsWeb,
            title: Row(
              children: [
                go_home_icon_button_view.WidgetView(
                    business: _business.goToHomeIconButtonBusiness),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Text(
                  pageTitle,
                  style: const TextStyle(
                      color: Colors.white, fontFamily: "MaruBuri"),
                ))
              ],
            ),
            backgroundColor: Colors.blue,
            iconTheme:
                const IconThemeData(color: Colors.white //change your color here
                    )),
        backgroundColor:
            isPageBackgroundBlue ? Colors.blue : const Color(0xFFFFFFFF),
        floatingActionButton: floatingActionButton,
        body: child);
  }
}
