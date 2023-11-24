// (external)
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// (inner Folder)
import 'widget_business.dart' as widget_business;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.
// 할 수 있다면 외부에서 주입하는 데이터는 뷰의 생성자에서 받고,
// 비즈니스 생성 시점에 꼭 필요한 데이터만 비즈니스 생성자에서 받습니다.

// -----------------------------------------------------------------------------
class WidgetView extends StatefulWidget {
  const WidgetView(
      {super.key, required widget_business.WidgetBusiness business})
      : _business = business;

  // [콜백 함수]
  @override
  // ignore: no_logic_in_create_state
  widget_business.WidgetBusiness createState() => _business;

  // [public 변수]

  // [private 변수]
  // (위젯 비즈니스)
  final widget_business.WidgetBusiness _business;

  // [public 함수]

  // [private 함수]

  // [뷰 위젯]
  // !!!뷰 위젯 반환 콜백 작성 하기!!!
  Widget viewWidgetBuild({required BuildContext context}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _business.countPlus1();
        },
        child: Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black)),
          ),
          margin: const EdgeInsets.only(bottom: 20),
          child: Text("${_business.sampleInt}",
              style: const TextStyle(
                  fontSize: 20, color: Colors.black, fontFamily: "MaruBuri")),
        ),
      ),
    );
  }
}
