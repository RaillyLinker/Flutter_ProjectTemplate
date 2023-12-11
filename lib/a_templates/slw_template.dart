// (external)
import 'package:flutter/cupertino.dart';

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
// (Stateless Widget 예시)
class SlwTemplate extends StatelessWidget {
  const SlwTemplate({super.key, required this.business});

  final SlwTemplateBusiness business;

  // !!!외부 입력 변수 선언 하기!!!

  //----------------------------------------------------------------------------
  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return business.getScreenWidget(context: context);
  }
}

class SlwTemplateBusiness {
  const SlwTemplateBusiness({required this.widget});

  // !!!위젯 변수를 저장 하세요.!!!
  // [public 변수]
  final SlwTemplate widget;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!위젯 함수를 작성 하세요.!!!
  // [public 함수]

  // [private 함수]

  //----------------------------------------------------------------------------
  // [화면 작성]
  Widget getScreenWidget({required BuildContext context}) {
    // !!!위젯 화면을 작성 하세요.!!!

    return const Text("Sample");
  }
}
