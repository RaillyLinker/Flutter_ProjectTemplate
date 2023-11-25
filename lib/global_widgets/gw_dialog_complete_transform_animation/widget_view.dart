// (external)
import 'package:flutter/cupertino.dart';

// (inner Folder)
import 'widget_business.dart' as widget_business;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
class InputVo {
  const InputVo(
      {required this.dialogChild,
      required this.dialogChildSize,
      required this.completeChild,
      required this.completeChildSize,
      required this.completeAnimationDuration,
      required this.completeCloseDuration});

  // !!!위젯 입력값 선언!!!

  // (다이얼로그 위젯 정보)
  final Widget dialogChild;
  final Size dialogChildSize;

  // (완료시 표시될 위젯 정보)
  final Widget completeChild;
  final Size completeChildSize;

  // (변환 애니메이션 속도)
  final Duration completeAnimationDuration;

  // (다이얼로그 종료 속도 - 변환 애니메이션보단 길어야 애니메이션을 감상 가능)
  final Duration completeCloseDuration;
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
      key: business.statefulGk,
      business: business,
    );
  }
}

class StatefulView extends StatefulWidget {
  const StatefulView({required super.key, required this.business});

  // [콜백 함수]
  @override
  StatefulBusiness createState() => StatefulBusiness();

  // [public 변수]
  // (위젯 비즈니스)
  final widget_business.WidgetBusiness business;
}

class StatefulBusiness extends State<StatefulView> {
  StatefulBusiness();

  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    widget.business.context = context;
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
    return AnimatedContainer(
      width: business.isComplete
          ? business.inputVo.completeChildSize.width
          : business.inputVo.dialogChildSize.width,
      height: business.isComplete
          ? business.inputVo.completeChildSize.height
          : business.inputVo.dialogChildSize.height,
      curve: Curves.fastOutSlowIn,
      duration: business.inputVo.completeAnimationDuration,
      child: business.isComplete
          ? business.inputVo.completeChild
          : business.inputVo.dialogChild,
    );
  }
}
