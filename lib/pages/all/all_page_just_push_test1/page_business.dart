// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'page_widgets/page_widget_custom.dart' as page_widget_custom;
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../pages/all/all_page_just_push_test1/page_entrance.dart'
    as all_page_just_push_test1;
import '../../../pages/all/all_page_just_push_test2/page_entrance.dart'
    as all_page_just_push_test2;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageBusiness {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // 페이지 생명주기 관련 states
  var pageLifeCycleStates = gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터 (아래 onCheckPageInputVoAsync 에서 조립)
  late page_entrance.PageInputVo pageInputVo;

  // 페이지 뷰모델 객체
  PageViewModel pageViewModel = PageViewModel();

  // 생성자 설정
  PageBusiness(this._context);

  ////
  // [페이지 생명주기]
  // - 페이지 최초 실행 : onPageCreateAsync -> onPageResumeAsync
  // - 다른 페이지 호출 / 복귀, 화면 끄기 / 켜기, 모바일에서 다른 앱으로 이동 및 복귀시 :
  // onPagePauseAsync -> onPageResumeAsync -> onPagePauseAsync -> onPageResumeAsync 반복
  // - 페이지 종료 : onPageWillPopAsync -(return true 일 때)-> onPagePauseAsync -> onPageDestroyAsync 실행

  // (onPageCreateAsync 실행 전 PageInputVo 체크)
  // onPageCreateAsync 과 완전히 동일하나, 입력값 체크만을 위해 분리한 생명주기
  Future<void> onCheckPageInputVoAsync(GoRouterState goRouterState) async {
    if (kDebugMode) {
      print("+++ onCheckPageInputVoAsync 호출됨");
    }

    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   // 필수 파라미터가 없는 경우에 대한 처리
    // }

    // !!!PageInputVo 입력!!!
    pageInputVo = page_entrance.PageInputVo();
  }

  // (페이지 최초 실행)
  Future<void> onPageCreateAsync() async {
    // !!!페이지 최초 실행 로직 작성!!!

    if (kDebugMode) {
      print("+++ onPageCreateAsync 호출됨");
    }

    showToast(
      "+++ onPageCreateAsync 호출됨",
      context: _context,
      animation: StyledToastAnimation.scale,
    );
  }

  // (페이지 최초 실행 or 다른 페이지에서 복귀)
  Future<void> onPageResumeAsync() async {
    // !!!위젯 최초 실행 및, 다른 페이지에서 복귀 로직 작성!!!
    if (kDebugMode) {
      print("+++ onPageResumeAsync 호출됨");
    }
  }

  // (페이지 종료 or 다른 페이지로 이동 (강제 종료는 탐지 못함))
  Future<void> onPagePauseAsync() async {
    // !!!위젯 종료 및, 다른 페이지로 이동 로직 작성!!!
    if (kDebugMode) {
      print("+++ onPagePauseAsync 호출됨");
    }
  }

  // (페이지 종료 (강제 종료, web 에서 브라우저 뒤로가기 버튼을 눌렀을 때는 탐지 못함))
  Future<void> onPageDestroyAsync() async {
    // !!!페이지 종료 로직 작성!!!
    if (kDebugMode) {
      print("+++ onPageDestroyAsync 호출됨");
    }
  }

  // (Page Pop 요청)
  // context.pop() 호출 직후 호출
  // return 이 true 라면 onWidgetPause 부터 onPageDestroyAsync 까지 실행 되며 페이지 종료
  // return 이 false 라면 pop 되지 않고 그대로 대기
  Future<bool> onPageWillPopAsync() async {
    // !!!onWillPop 로직 작성!!!
    if (kDebugMode) {
      print("+++ onPageWillPop 호출됨");
    }

    return true;
  }

////
// [비즈니스 함수]
// !!!외부에서 사용할 비즈니스 로직은 아래에 공개 함수로 구현!!!
// ex :
//   void changeSampleNumber(int newSampleNumber) {
//     // BLoC 위젯 관련 상태 변수 변경
//     pageViewModel.statefulWidgetSampleVm.sampleNumber = newSampleNumber;
//     // BLoC 위젯 변경 트리거 발동
//     pageViewModel.statefulWidgetSampleStateGk.currentState?.refresh();
//   }

  // (just_push_test 로 이동)
  void goToJustPushTest1Page() {
    _context.pushNamed(all_page_just_push_test1.pageName);
  }

  // (just_push_test 로 이동)
  void goToJustPushTest2Page() {
    _context.pushNamed(all_page_just_push_test2.pageName);
  }

  // (화면 카운트 +1)
  void countPlus1() {
    pageViewModel.statefulWidgetSampleNumberVm.sampleNumber += 1;
    pageViewModel.statefulWidgetSampleNumberStateGk.currentState?.refresh();
  }

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!!
}

// (페이지 뷰 모델 클래스)
// 페이지 전역의 데이터는 여기에 정의되며, Business 인스턴스 안의 pageViewModel 변수로 저장 됩니다.
class PageViewModel {
  PageViewModel();

  // !!!페이지 데이터 정의!!!
  // 하위 Stateful Widget 의 GlobalKey 와 ViewModel, 그리고 Stateless Widget 의 데이터를 저장
  // ex :
  // final GlobalKey<page_view.StatefulWidgetSampleState>
  //     statefulWidgetSampleStateGk = GlobalKey();
  // page_view.StatefulWidgetSampleViewModel statefulWidgetSampleVm =
  //     page_view.StatefulWidgetSampleViewModel(0);

  final GlobalKey<page_widget_custom.StatefulWidgetSampleNumberState>
      statefulWidgetSampleNumberStateGk = GlobalKey();
  page_widget_custom.StatefulWidgetSampleNumberViewModel
      statefulWidgetSampleNumberVm =
      page_widget_custom.StatefulWidgetSampleNumberViewModel(0);
}
