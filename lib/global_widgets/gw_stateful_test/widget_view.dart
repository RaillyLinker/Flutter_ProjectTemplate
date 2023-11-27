// (external)
import 'package:flutter/material.dart';

// (inner Folder)
import 'widget_business.dart' as widget_business;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
class InputVo {
  const InputVo();
// !!!위젯 입력값 선언!!!
}

class WidgetView extends StatelessWidget {
  WidgetView({super.key, required this.business, required InputVo inputVo}) {
    business.inputVo = inputVo;
  }

  // [콜백 함수]
  // (위젯을 화면에 draw 할 때의 콜백)
  @override
  Widget build(BuildContext context) {
    return viewWidgetBuild(context: context);
  }

  // [public 변수]
  // (위젯 비즈니스)
  final widget_business.WidgetBusiness business;

  // [뷰 위젯]
  Widget viewWidgetBuild({required BuildContext context}) {
    return StatefulView(
      business: business,
    );
  }
}

class StatefulView extends StatefulWidget {
  const StatefulView({super.key, required this.business});

  // [콜백 함수]
  @override
  StatefulState createState() => StatefulState();

  // [public 변수]
  // (위젯 비즈니스)
  final widget_business.WidgetBusiness business;
}

class StatefulState extends State<StatefulView> {
  // [콜백 함수]
  @override
  void initState() {
    super.initState();
    widget.business.initState();
  }

  @override
  void dispose() {
    widget.business.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.business.context = context;
    widget.business.refreshUi = refreshUi;
    return WidgetUi.viewWidgetBuild(
        context: context, business: widget.business);
  }

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }
}

class WidgetUi {
  // [뷰 위젯]
  static Widget viewWidgetBuild(
      {required BuildContext context,
      required widget_business.WidgetBusiness business}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          business.countPlus1();
        },
        child: Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black)),
          ),
          margin: const EdgeInsets.only(bottom: 20),
          child: Text("${business.sampleInt}",
              style: const TextStyle(
                  fontSize: 20, color: Colors.black, fontFamily: "MaruBuri")),
        ),
      ),
    );
  }
}
