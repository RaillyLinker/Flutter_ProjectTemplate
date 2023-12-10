// (external)
import 'package:flutter/cupertino.dart';

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
// (Stateless Widget 예시)
class SlwTemplate extends StatelessWidget {
  const SlwTemplate({super.key});

  // !!!외부 입력 변수 선언 하기!!!

  //----------------------------------------------------------------------------
  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return getScreenWidget(context: context);
  }

  //----------------------------------------------------------------------------
  // [public 함수]

  // [private 함수]

  //----------------------------------------------------------------------------
  // [public 변수]

  // [private 변수]

  //----------------------------------------------------------------------------
  // [화면 작성]
  Widget getScreenWidget({required BuildContext context}) {
    return const Text("Sample");
  }
}
