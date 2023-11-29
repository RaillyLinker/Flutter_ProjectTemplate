// (external)
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../dialogs/all/all_dialog_info/widget_view.dart'
    as all_dialog_info_view;
import '../../../dialogs/all/all_dialog_info/widget_business.dart'
    as all_dialog_info_business;
import '../../../global_widgets/gw_page_outer_frame/sl_widget_business.dart'
    as gw_page_outer_frame_business;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../global_widgets/gw_context_menu_region/sf_widget_state.dart'
as gw_context_menu_region_state;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageBusiness {
  PageBusiness(this._context) {
    pageViewModel = PageViewModel(_context);
  }

  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // 페이지 생명주기 관련 states
  final gc_template_classes.PageLifeCycleStates pageLifeCycleStates =
      gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터 (아래 goRouterState 에서 가져와 대입하기)
  late page_entrance.PageInputVo pageInputVo;

  // 페이지 뷰모델 객체
  late PageViewModel pageViewModel;

  ////
  // [페이지 생명주기]
  // - 페이지 최초 실행 : onPageCreateAsync -> onPageResumeAsync
  // - 다른 페이지 호출 / 복귀, 화면 끄기 / 켜기, 모바일에서 다른 앱으로 이동 및 복귀시 :
  // onPagePauseAsync -> onPageResumeAsync -> onPagePauseAsync -> onPageResumeAsync 반복
  // - 페이지 종료 : onPageWillPopAsync -(return true 일 때)-> onPagePauseAsync -> onPageDestroyAsync 실행

  // (onPageCreateAsync 실행 전 PageInputVo 체크)
  // onPageCreateAsync 과 완전히 동일하나, 입력값 체크만을 위해 분리한 생명주기
  Future<void> onCheckPageInputVoAsync(GoRouterState goRouterState) async {
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
  }

  // (페이지 최초 실행 or 다른 페이지에서 복귀)
  Future<void> onPageResumeAsync() async {
    // !!!위젯 최초 실행 및, 다른 페이지에서 복귀 로직 작성!!!
  }

  // (페이지 종료 or 다른 페이지로 이동 (강제 종료는 탐지 못함))
  Future<void> onPagePauseAsync() async {
    // !!!위젯 종료 및, 다른 페이지로 이동 로직 작성!!!
  }

  // (페이지 종료 (강제 종료, web 에서 브라우저 뒤로가기 버튼을 눌렀을 때는 탐지 못함))
  Future<void> onPageDestroyAsync() async {
    // !!!페이지 종료 로직 작성!!!
  }

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

  // (context 메뉴의 토스트 테스트 항목을 클릭)
  void toastTestMenuBtn() {
    showToast(
      "토스트 테스트 메뉴가 선택되었습니다.",
      context: _context,
      animation: StyledToastAnimation.scale,
    );
  }

  // (context 메뉴의 다이얼로그 테스트 항목을 클릭)
  void dialogTestMenuBtn() {
    var allDialogInfoBusiness = all_dialog_info_business.WidgetBusiness();
    showDialog(
        barrierDismissible: true,
        context: _context,
        builder: (context) => all_dialog_info_view.WidgetView(
              business: allDialogInfoBusiness,
              inputVo: const all_dialog_info_view.InputVo(
                  dialogTitle: "컨텍스트 메뉴 테스트",
                  dialogContent: "다이얼로그 테스트 메뉴가\n선택되었습니다.",
                  checkBtnTitle: "확인"),
              onDialogCreated: () {},
            ));
  }

  // (context 메뉴의 뒤로가기 항목을 클릭)
  void goBackBtn() {
    _context.pop();
  }

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!!
}

// (페이지 뷰 모델 클래스)
// 페이지 전역의 데이터는 여기에 정의되며, Business 인스턴스 안의 pageViewModel 변수로 저장 됩니다.
class PageViewModel {
  PageViewModel(this._context);

  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!페이지 데이터 정의!!!
  // ex :
  // GlobalKey<SampleWidgetState> sampleWidgetStateGk = GlobalKey();
  // SampleWidgetViewModel sampleWidgetViewModel = SampleWidgetViewModel();

  var contextMenuRegionGk =
  GlobalKey<gw_context_menu_region_state.SfWidgetState>();

  var contextMenuRegionGk2 =
  GlobalKey<gw_context_menu_region_state.SfWidgetState>();

  // PageOutFrameViewModel
  gw_page_outer_frame_business.SlWidgetBusiness pageOutFrameBusiness =
      gw_page_outer_frame_business.SlWidgetBusiness();
}
