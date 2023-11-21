// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageBusiness {
  PageBusiness({required this.context, required this.pageInputVo});

  // 페이지 컨텍스트 객체
  final BuildContext context;

  // 페이지 파라미터
  final page_entrance.PageInputVo pageInputVo;

  // !!!페이지를 pop 할수 있을지 여부를 설정!!!
  bool pageCanPop = true;

  // !!!페이지 상태 변수 선언하기!!!
  // ex :
  //   page_view
  //       .StatefulWidgetTemplateBusiness statefulWidgetTemplateBusiness = page_view
  //       .StatefulWidgetTemplateBusiness(
  //       sampleText: "sampleText"
  //   );

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

  // (Page Pop 요청)
  // context.pop() 호출 직후 호출
  // return 이 true 라면 onWidgetPause 부터 onPageDestroyAsync 까지 실행 되며 페이지 종료
  // return 이 false 라면 pop 되지 않고 그대로 대기
  Future<bool> onPageWillPopAsync() async {
    // !!!onWillPop 로직 작성!!!

    return true;
  }

  ////
  // [비즈니스 함수]
  // !!!외부에서 사용할 비즈니스 로직은 아래에 공개 함수로 구현!!!
  // (다이얼로그 종료 함수)
  void closeDialog() {
    context.pop();
  }

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!!
}
