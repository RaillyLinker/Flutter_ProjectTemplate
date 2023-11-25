// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// (inner Folder)
import 'widget_business.dart' as widget_business;
import 'inner_widgets/iw_go_home_icon_button/widget_view.dart'
    as iw_go_home_icon_button_view;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
class InputVo {
  const InputVo(
      {required this.child,
      this.floatingActionButton,
      required this.pageTitle,
      this.backgroundColor = Colors.white});

// !!!위젯 입력값 선언!!!

  // (하위 위젯)
  final Widget child;

  // (플로팅 버튼)
  final FloatingActionButton? floatingActionButton;

  // (페이지 타이틀)
  final String pageTitle;

  // (페이지 배경색을 파란색으로 할지 여부)
  final Color backgroundColor;
}

class WidgetView extends StatelessWidget {
  WidgetView({super.key, required this.business, required InputVo inputVo}) {
    business.inputVo = inputVo;
  }

  // [콜백 함수]
  // (위젯을 화면에 draw 할 때의 콜백)
  @override
  Widget build(BuildContext context) {
    business.context = context;
    return viewWidgetBuild(context: context);
  }

  // [public 변수]
  // (위젯 비즈니스)
  final widget_business.WidgetBusiness business;

  // [뷰 위젯]
  Widget viewWidgetBuild({required BuildContext context}) {
    // Mobile 앱 status bar 색상 변경
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));

    // !!!뷰 위젯 반환 콜백 작성 하기!!!
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: !kIsWeb,
            title: Row(
              children: [
                iw_go_home_icon_button_view.WidgetView(
                  business: business.goToHomeIconButtonBusiness,
                  inputVo: const iw_go_home_icon_button_view.InputVo(),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Text(
                  business.inputVo.pageTitle,
                  style: const TextStyle(
                      color: Colors.white, fontFamily: "MaruBuri"),
                ))
              ],
            ),
            backgroundColor: Colors.blue,
            iconTheme:
                const IconThemeData(color: Colors.white //change your color here
                    )),
        backgroundColor: business.inputVo.backgroundColor,
        floatingActionButton: business.inputVo.floatingActionButton,
        body: business.inputVo.child);
  }
}
