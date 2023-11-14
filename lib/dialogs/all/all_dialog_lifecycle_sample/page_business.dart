// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';

// (page)
import 'page_widgets/page_widget_custom.dart' as page_widget_custom;
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../pages/all/all_page_dialog_sample_list/page_entrance.dart'
    as all_page_dialog_sample_list;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageBusiness {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // 페이지 생명주기 관련 states
  var pageLifeCycleStates = gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터
  page_entrance.PageInputVo pageInputVo;

  // 페이지 뷰모델 객체
  PageViewModel pageViewModel = PageViewModel();

  // 생성자 설정
  PageBusiness(this._context, this.pageInputVo);

  ////
  // [페이지 생명주기]
  // - 페이지 최초 실행 : onPageCreateAsync -> onPageResumeAsync
  // - 다른 페이지 호출 / 복귀, 화면 끄기 / 켜기, 모바일에서 다른 앱으로 이동 및 복귀시 :
  // onPagePauseAsync -> onPageResumeAsync -> onPagePauseAsync -> onPageResumeAsync 반복
  // - 페이지 종료 : onPageWillPopAsync -(return true 일 때)-> onPagePauseAsync -> onPageDestroyAsync 실행

  // (페이지 최초 실행)
  Future<void> onPageCreateAsync() async {
    // !!!페이지 최초 실행 로직 작성!!!
    if (kDebugMode) {
      print("+${pageViewModel.randString}+ onPageCreateAsync");
    }
  }

  // (페이지 최초 실행 or 다른 페이지에서 복귀)
  Future<void> onPageResumeAsync() async {
    // !!!위젯 최초 실행 및, 다른 페이지에서 복귀 로직 작성!!!
    if (kDebugMode) {
      print("+${pageViewModel.randString}+ onPageResumeAsync");
    }
  }

  // (페이지 종료 or 다른 페이지로 이동 (강제 종료는 탐지 못함))
  Future<void> onPagePauseAsync() async {
    // !!!위젯 종료 및, 다른 페이지로 이동 로직 작성!!!
    if (kDebugMode) {
      print("+${pageViewModel.randString}+ onPagePauseAsync");
    }
  }

  // (페이지 종료 (강제 종료, web 에서 브라우저 뒤로가기 버튼을 눌렀을 때는 탐지 못함))
  Future<void> onPageDestroyAsync() async {
    // !!!페이지 종료 로직 작성!!!
    if (kDebugMode) {
      print("+${pageViewModel.randString}+ onPageDestroyAsync");
    }
  }

  // (Page Pop 요청)
  // context.pop() 호출 직후 호출
  // return 이 true 라면 onWidgetPause 부터 onPageDestroyAsync 까지 실행 되며 페이지 종료
  // return 이 false 라면 pop 되지 않고 그대로 대기
  Future<bool> onPageWillPopAsync() async {
    // !!!onWillPop 로직 작성!!!
    if (kDebugMode) {
      print("+${pageViewModel.randString}+ onPageWillPopAsync");
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

  // (다이얼로그 종료 함수)
  void closeDialog() {
    _context.pop();
  }

  // (화면 카운트 +1)
  void countPlus1() {
    pageViewModel.statefulWidgetSampleNumberVm.sampleNumber += 1;
    pageViewModel.statefulWidgetSampleNumberStateGk.currentState?.refresh();
  }

  void pushToAnotherPage() {
    _context.pushNamed(all_page_dialog_sample_list.pageName);
  }

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!!
}

// (페이지 뷰 모델 클래스)
// 페이지 전역의 데이터는 여기에 정의되며, Business 인스턴스 안의 pageViewModel 변수로 저장 됩니다.
class PageViewModel {
  PageViewModel() {
    randString = _generateRandomString(10);
  }

  // !!!페이지 데이터 정의!!!
  // 하위 Stateful Widget 의 GlobalKey 와 ViewModel, 그리고 Stateless Widget 의 데이터를 저장
  // ex :
  // final GlobalKey<page_view.StatefulWidgetSampleState>
  //     statefulWidgetSampleStateGk = GlobalKey();
  // page_view.StatefulWidgetSampleViewModel statefulWidgetSampleVm =
  //     page_view.StatefulWidgetSampleViewModel(0);

  String randString = "";

  final GlobalKey<page_widget_custom.StatefulWidgetSampleNumberState>
      statefulWidgetSampleNumberStateGk = GlobalKey();
  page_widget_custom.StatefulWidgetSampleNumberViewModel
      statefulWidgetSampleNumberVm =
      page_widget_custom.StatefulWidgetSampleNumberViewModel(0);

  String _generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(
          random.nextInt(chars.length),
        ),
      ),
    );
  }
}
