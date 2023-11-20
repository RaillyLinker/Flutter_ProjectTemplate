// (external)
import 'package:flutter/material.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;

// [페이지 화면 위젯 작성 파일]
// 페이지 화면 구현을 담당합니다. (Widget 과 Business 간의 결합을 담당)
// 로직 처리는 pageBusiness 객체에 위임하세요.

//------------------------------------------------------------------------------
// (페이지 UI 위젯)
// !!!세부 화면 정의!!!
class PageView extends StatelessWidget {
  const PageView({super.key, required this.pageBusiness});

  // 페이지 비즈니스 객체
  final page_business.PageBusiness pageBusiness;

  @override
  Widget build(BuildContext context) {
    return gw_page_out_frames.PageOutFrame(
      pageBusiness.pageOutFrameViewModel,
      const Center(
        child: Text(
          "페이지 템플릿입니다.",
          style: TextStyle(fontFamily: "MaruBuri"),
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
//   // 위젯 비즈니스
//   final StatelessWidgetTemplateBusiness business;
//
//   //!!!주입 받을 하위 위젯 선언 하기!!!
//
//   // !!!위젯 작성하기. (business 에서 데이터를 가져와 사용)!!!
//   @override
//   Widget build(BuildContext context) {
//     return Text(business.sampleText);
//   }
// }
//
// class StatelessWidgetTemplateBusiness {
//   StatelessWidgetTemplateBusiness({required this.sampleText});
//
//   // !!!위젯 상태 변수 선언하기!!!
//   String sampleText;
//
//   // !!!위젯 비즈니스 로직 작성하기!!!
//   void sampleFunc({required String text}) {
//     sampleText = sampleText;
//   }
// }

// (Stateful 위젯 템플릿)
// class StatefulWidgetTemplate extends StatefulWidget {
//   const StatefulWidgetTemplate({super.key, required this.business});
//
//   // 위젯 비즈니스
//   final StatefulWidgetTemplateBusiness business;
//
//   //!!!주입 받을 하위 위젯 선언 하기!!!
//
//   @override
//   // ignore: no_logic_in_create_state
//   StatefulWidgetTemplateBusiness createState() => business;
// }
//
// class StatefulWidgetTemplateBusiness extends State<StatefulWidgetTemplate> {
//   StatefulWidgetTemplateBusiness({required this.sampleText});
//
//   // Stateful Widget 화면 갱신
//   void refresh() {
//     setState(() {});
//   }
//
//   // !!!위젯 상태 변수 선언하기!!!
//   String sampleText;
//
//   // !!!위젯 비즈니스 로직 작성하기!!!
//   void sampleFunc({required String text}) {
//     sampleText = sampleText;
//   }
//
//   // !!!위젯 작성하기. (business 에서 데이터를 가져와 사용)!!!
//   @override
//   Widget build(BuildContext context) {
//     return Text(sampleText);
//   }
// }
