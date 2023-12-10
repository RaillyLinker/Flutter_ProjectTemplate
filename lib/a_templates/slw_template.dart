// (external)
import 'package:flutter/cupertino.dart';

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
// (Stateless Widget 예시)
class SlwTemplate extends StatelessWidget {
  const SlwTemplate({super.key, required this.business});

  // [public 변수]
  final SlwTemplateBusiness business;

  // !!!외부 입력 변수 선언 하기!!!

  // [콜백 함수]
  // (위젯을 화면에 draw 할 때의 콜백)
  @override
  Widget build(BuildContext context) {
    return widgetUiBuild(context: context);
  }

  // [화면 작성]
  Widget widgetUiBuild({required BuildContext context}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return const Text("Sample");
  }
}

class SlwTemplateBusiness {
  // [콜백 함수]

  // [public 변수]

  // [private 변수]

  // [public 함수]

  // [private 함수]
}
