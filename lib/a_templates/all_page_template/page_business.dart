// (external)
import 'package:flutter/material.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageBusiness {
  PageBusiness({required this.context});

  // 페이지 컨텍스트 객체
  final BuildContext context;

  // 페이지 파라미터 (아래 goRouterState 에서 가져와 대입하기)
  late page_entrance.PageInputVo pageInputVo;

  // !!!페이지를 pop 할수 있을지 여부를 설정!!!
  bool pageCanPop = true;

  // !!!페이지 상태 변수 선언하기!!!
  // ex :
  //   page_view
  //       .StatefulWidgetTemplateBusiness statefulWidgetTemplateBusiness = page_view
  //       .StatefulWidgetTemplateBusiness(
  //       sampleText: "sampleText"
  //   );

  // PageOutFrameViewModel
  gw_page_out_frames.PageOutFrameBusiness pageOutFrameBusiness =
      gw_page_out_frames.PageOutFrameBusiness(pageTitle: "페이지 템플릿");

  ////
  // [페이지 생명주기 관련 콜백]
  // (페이지 위젯 initState)
  void onPageInit() {}

  // (페이지 위젯 dispose)
  void onPageDispose() {}

  // (페이지 위젯의 FocusDetector 콜백들)
  void onPageFocusGained() {}

  void onPageFocusLost() {}

  void onPageVisibilityGained() {}

  void onPageVisibilityLost() {}

  void onPageForegroundGained() {}

  void onPageForegroundLost() {}

////
// [비즈니스 함수]
// !!!외부에서 사용할 비즈니스 로직은 아래에 공개 함수로 구현!!!

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!!
}
