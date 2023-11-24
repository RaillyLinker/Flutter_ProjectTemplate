// (external)
import 'package:flutter/cupertino.dart';

// (inner Folder)
import 'widget_business.dart' as widget_business;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
// (Dialog 용 종료 애니메이션 샘플)
// 이 위젯을 적용 후 dialogComplete() 를 사용 하면, dialogChild 가 completeChild 로 변환된 이후 종료 됩니다.
class WidgetView extends StatefulWidget {
  WidgetView(
      {super.key,
      required widget_business.WidgetBusiness business,
      required Widget dialogChild,
      required Size dialogChildSize,
      required Widget completeChild,
      required Size completeChildSize,
      required Duration completeAnimationDuration,
      required this.completeCloseDuration})
      : _completeAnimationDuration = completeAnimationDuration,
        _completeChildSize = completeChildSize,
        _completeChild = completeChild,
        _dialogChildSize = dialogChildSize,
        _dialogChild = dialogChild,
        _business = business;

  // [콜백 함수]
  @override
  // ignore: no_logic_in_create_state
  widget_business.WidgetBusiness createState() => _business;

  // [public 변수]

  // [private 변수]
  // (위젯 비즈니스)
  final widget_business.WidgetBusiness _business;

  // (다이얼로그 위젯 정보)
  final Widget _dialogChild;
  final Size _dialogChildSize;

  // (완료시 표시될 위젯 정보)
  final Widget _completeChild;
  final Size _completeChildSize;

  // (변환 애니메이션 속도)
  final Duration _completeAnimationDuration;

  // (다이얼로그 종료 속도 - 변환 애니메이션보단 길어야 애니메이션을 감상 가능)
  final Duration completeCloseDuration;

  // [public 함수]

  // [private 함수]

  // [뷰 위젯]
  // !!!뷰 위젯 반환 콜백 작성 하기!!!
  Widget viewWidgetBuild({required BuildContext context}) {
    return AnimatedContainer(
      width: _business.isComplete
          ? _completeChildSize.width
          : _dialogChildSize.width,
      height: _business.isComplete
          ? _completeChildSize.height
          : _dialogChildSize.height,
      curve: Curves.fastOutSlowIn,
      duration: _completeAnimationDuration,
      child: _business.isComplete ? _completeChild : _dialogChild,
    );
  }
}
