// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// (inner Folder)
import 'sl_widget_business.dart' as sl_widget_business;
import 'inner_widgets/iw_go_home_icon_button/sf_widget.dart'
    as iw_go_home_icon_button;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
// (입력 데이터)
class InputVo {
  // !!!위젯 입력값 선언!!!
  const InputVo(
      {required this.child,
      this.floatingActionButton,
      required this.pageTitle,
      this.backgroundColor = Colors.white});

  // (하위 위젯)
  final Widget child;

  // (플로팅 버튼)
  final FloatingActionButton? floatingActionButton;

  // (페이지 타이틀)
  final String pageTitle;

  // (페이지 배경색을 파란색으로 할지 여부)
  final Color backgroundColor;
}

class SlWidget extends StatelessWidget {
  const SlWidget({super.key, required this.inputVo, required this.business});

  // [public 변수]
  final InputVo inputVo;
  final sl_widget_business.SlWidgetBusiness business;

  // [private 변수]

  // [콜백 함수]
  // (위젯을 화면에 draw 할 때의 콜백)
  @override
  Widget build(BuildContext context) {
    business.context = context;
    return widgetUiBuild(context: context);
  }

  // [public 함수]

  // [private 함수]

  // [화면 작성]
  Widget widgetUiBuild({required BuildContext context}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

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
                iw_go_home_icon_button.SfWidget(
                  globalKey: business.goToHomeIconButtonGk,
                  inputVo: const iw_go_home_icon_button.InputVo(),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Text(
                  inputVo.pageTitle,
                  style: const TextStyle(
                      color: Colors.white, fontFamily: "MaruBuri"),
                ))
              ],
            ),
            backgroundColor: Colors.blue,
            iconTheme:
                const IconThemeData(color: Colors.white //change your color here
                    )),
        backgroundColor: inputVo.backgroundColor,
        floatingActionButton: inputVo.floatingActionButton,
        body: inputVo.child);
  }
}
