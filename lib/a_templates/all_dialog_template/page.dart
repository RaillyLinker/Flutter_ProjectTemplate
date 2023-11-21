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
class Page extends StatefulWidget {
  const Page({super.key, required this.business, required this.pageInputVo});

  // [위젯 관련 상수]
  // (위젯 비즈니스)
  final PageBusiness business;

  // (페이지 입력 데이터)
  final PageInputVo pageInputVo;

  // [내부 함수]
  @override
  // ignore: no_logic_in_create_state
  PageBusiness createState() => business;
}

class PageBusiness extends State<Page> with WidgetsBindingObserver {
  PageBusiness();

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
      // 페이지 생명주기를 Business 에 넘겨주기
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {},
        onFocusLost: () async {},
        onVisibilityGained: () async {},
        onVisibilityLost: () async {},
        onForegroundGained: () async {},
        onForegroundLost: () async {},
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

// ex :
// (Stateless 위젯 템플릿)
// class StatelessWidgetTemplate extends StatelessWidget {
//   const StatelessWidgetTemplate({super.key, required this.business});
//
//   // [위젯 관련 변수] - State 의 setState() 를 하면 초기화 됩니다.
//   // (위젯 비즈니스)
//   final StatelessWidgetTemplateBusiness business;
//
//   // [내부 함수]
//   @override
//   Widget build(BuildContext context) {
//     return Text(business.sampleText);
//   }
// }
//
// class StatelessWidgetTemplateBusiness {
//   StatelessWidgetTemplateBusiness({required this.sampleText});
//
//   // [위젯 관련 변수] - State 내에서 상태가 유지 됩니다.
//   // (샘플 변수)
//   String sampleText;
//
//   // [외부 공개 함수]
//   // (샘플 외부 공개 함수)
//   void sampleFunc({required String text}) {
//     sampleText = text;
//     _samplePrivateFunc(text: text);
//   }
//
//   // [내부 함수]
//   // (샘플 내부 함수)
//   void _samplePrivateFunc({required String text}) {
//     if (kDebugMode) {
//       print(text);
//     }
//   }
// }

// (Stateful 위젯 템플릿)
// class StatefulWidgetTemplate extends StatefulWidget {
//   const StatefulWidgetTemplate({super.key, required this.business});
//
//   // [위젯 관련 변수] - State 의 setState() 를 하면 초기화 됩니다.
//   // (위젯 비즈니스)
//   final StatefulWidgetTemplateBusiness business;
//
//   // [내부 함수]
//   @override
//   // ignore: no_logic_in_create_state
//   StatefulWidgetTemplateBusiness createState() => business;
// }
//
// class StatefulWidgetTemplateBusiness extends State<StatefulWidgetTemplate> {
//   StatefulWidgetTemplateBusiness({required this.sampleText});
//
//   // [위젯 관련 변수] - State 내에서 상태가 유지 됩니다.
//   // (샘플 변수)
//   String sampleText;
//
//   // [외부 공개 함수]
//   // (Stateful Widget 화면 갱신)
//   void refresh() {
//     setState(() {});
//   }
//
//   // (샘플 외부 공개 함수)
//   void sampleFunc({required String text}) {
//     sampleText = sampleText;
//   }
//
//   // [내부 함수]
//   @override
//   Widget build(BuildContext context) {
//     return Text(sampleText);
//   }
// }
