// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// [페이지 구현 파일]

//------------------------------------------------------------------------------
// (페이지 호출시 필요한 입력값 데이터 형태)
// !!!페이지 입력 데이터 정의!!!
class PageInputVo {}

// (이전 페이지로 전달할 결과 데이터 형태)
// !!!페이지 반환 데이터 정의!!!
class PageOutputVo {}

//------------------------------------------------------------------------------
class PageEntrance extends StatefulWidget {
  const PageEntrance(
      {super.key, required this.state, required this.pageInputVo});

  // [위젯 관련 상수]
  // (위젯 비즈니스)
  final PageEntranceState state;

  // (페이지 입력 데이터)
  final PageInputVo pageInputVo;

  // [내부 함수]
  @override
  // ignore: no_logic_in_create_state
  PageEntranceState createState() => state;
}

class PageEntranceState extends State<PageEntrance>
    with WidgetsBindingObserver {
  PageEntranceState();

  // [위젯 관련 변수]
  // (페이지 pop 가능 여부 변수)
  bool pageCanPop = true;

  // [외부 공개 함수]
  // (다이얼로그 종료 함수)
  void closeDialog() {
    context.pop();
  }

  // [내부 함수]
  // (페이지 위젯 initState)
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  // (페이지 위젯 dispose)
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: pageCanPop,
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {},
        onFocusLost: () async {},
        onVisibilityGained: () async {},
        onVisibilityLost: () async {},
        onForegroundGained: () async {},
        onForegroundLost: () async {},

        // (페이지 UI 위젯)
        child: Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: SingleChildScrollView(
            child: Container(
              height: 280,
              width: 300,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: const Center(
                child: Text(
                  "다이얼로그 템플릿",
                  style: TextStyle(fontFamily: "MaruBuri"),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
