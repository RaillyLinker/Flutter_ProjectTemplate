// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../global_widgets/page_outer_frame/widget_business.dart'
    as page_outer_frame_business;
import '../../../../repositories/network/apis/api_main_server.dart'
    as api_main_server;
import '../../../../repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import '../../../dialogs/all/all_dialog_info/page_entrance.dart'
    as all_dialog_info;
import '../../../dialogs/all/all_dialog_loading_spinner/page_entrance.dart'
    as all_dialog_loading_spinner;
import '../../../dialogs/all/all_dialog_yes_or_no/page_entrance.dart'
    as all_dialog_yes_or_no;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;
import '../../../pages/all/all_page_login/page_entrance.dart' as all_page_login;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]
// todo : 템플릿 적용

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageBusiness {
  PageBusiness(this._context) {
    pageViewModel = PageViewModel(_context);
  }

  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // BLoC 객체 모음
  late BLocObjects blocObjects;

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

    // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
    spw_auth_member_info.SharedPreferenceWrapperVo? nowLoginMemberInfo =
        gf_my_functions.getNowVerifiedMemberInfo();

    if (nowLoginMemberInfo == null) {
      // 비회원 상태라면 진입 금지
      showToast(
        "로그인이 필요합니다.",
        context: _context,
        animation: StyledToastAnimation.scale,
      );
      // Login 페이지로 이동
      _context.pushNamed(all_page_login.pageName);
      return;
    }
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
// ex :
//   void changeSampleNumber(int newSampleNumber) {
//     // BLoC 위젯 관련 상태 변수 변경
//     pageViewModel.sampleNumber = newSampleNumber;
//     // BLoC 위젯 변경 트리거 발동
//     blocObjects.blocSample.refresh();
//   }

  // (동의 버튼 클릭시)
  void toggleAgreeButton() {
    pageViewModel.withdrawalAgree = !pageViewModel.withdrawalAgree;
    blocObjects.blocAgreeCheckBox.refresh();
  }

  // (계정 비번으로 회원탈퇴)
  bool accountWithdrawalAsyncClicked = false;

  Future<void> accountWithdrawalAsync() async {
    if (accountWithdrawalAsyncClicked) {
      return;
    }
    accountWithdrawalAsyncClicked = true;

    var signInInfo = spw_auth_member_info.SharedPreferenceWrapper.get();

    if (signInInfo == null) {
      // 비회원일 때
      showToast(
        "로그인이 필요합니다.",
        context: _context,
        animation: StyledToastAnimation.scale,
      );
      accountWithdrawalAsyncClicked = false;
      _context.pop();
      return;
    }

    if (!pageViewModel.withdrawalAgree) {
      // 회원탈퇴 동의 체크가 안됨
      showToast(
        "동의 버튼 체크가 필요합니다.",
        context: _context,
        animation: StyledToastAnimation.scale,
      );
      accountWithdrawalAsyncClicked = false;
      return;
    }

    // 입력창이 모두 충족되었을 때

    accountWithdrawalAsyncClicked = false;

    // (선택 다이얼로그 호출)
    showDialog(
        barrierDismissible: true,
        context: _context,
        builder: (context) => all_dialog_yes_or_no.PageEntrance(
              all_dialog_yes_or_no.PageInputVo(
                  "회원 탈퇴", "회원 탈퇴를 진행하시겠습니까?", "예", "아니오"),
            )).then((outputVo) async {
      if (outputVo.checkPositiveBtn) {
        var loadingSpinner = all_dialog_loading_spinner.PageEntrance(
          all_dialog_loading_spinner.PageInputVo(),
        );

        showDialog(
            barrierDismissible: false,
            context: _context,
            builder: (context) => loadingSpinner);

        // 네트워크 요청
        var responseVo =
            await api_main_server.deleteService1TkV1AuthWithdrawalAsync(
          requestHeaderVo: api_main_server
              .DeleteService1TkV1AuthWithdrawalAsyncRequestHeaderVo(
                  authorization:
                      "${signInInfo.tokenType} ${signInInfo.accessToken}"),
        );

        loadingSpinner.pageBusiness.closeDialog();

        if (responseVo.dioException == null) {
          // Dio 네트워크 응답
          var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

          if (networkResponseObjectOk.responseStatusCode == 200) {
            // 정상 응답
            // 로그아웃 처리
            spw_auth_member_info.SharedPreferenceWrapper.set(value: null);
            if (!_context.mounted) return;
            await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_info.PageEntrance(
                      all_dialog_info.PageInputVo(
                          "회원 탈퇴 완료", "회원 탈퇴가 완료되었습니다.\n안녕히 가세요.", "확인"),
                    ));
            if (!_context.mounted) return;
            _context.pop(page_entrance.PageOutputVo(true));
          } else if (networkResponseObjectOk.responseStatusCode == 401) {
            // 비회원 처리됨
            if (!_context.mounted) return;
            showToast(
              "로그인이 필요합니다.",
              context: _context,
              animation: StyledToastAnimation.scale,
            );
            _context.pop();
            return;
          } else {
            // 비정상 응답
            if (!_context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_info.PageEntrance(
                      all_dialog_info.PageInputVo(
                          "네트워크 에러", "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "확인"),
                    ));
          }
        } else {
          if (!_context.mounted) return;
          showDialog(
              barrierDismissible: true,
              context: _context,
              builder: (context) => all_dialog_info.PageEntrance(
                    all_dialog_info.PageInputVo(
                        "네트워크 에러", "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "확인"),
                  ));
        }
      }
    });
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

  // 페이지 생명주기 관련 states
  final gc_template_classes.PageLifeCycleStates pageLifeCycleStates =
      gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터 (아래 goRouterState 에서 가져와 대입하기)
  late page_entrance.PageInputVo pageInputVo;

  // !!!페이지 데이터 정의!!!
  // ex :
  // int sampleNumber = 0;

  // PageOutFrameViewModel
  page_outer_frame_business.WidgetBusiness pageOutFrameBusiness =
      page_outer_frame_business.WidgetBusiness();

  bool withdrawalAgree = false;
}

// (BLoC 클래스)
// ex :
// class BlocSample extends Bloc<bool, bool> {
//   BlocSample() : super(true) {
//     on<bool>((event, emit) {
//       emit(event);
//     });
//   }
//
//   // BLoC 위젯 갱신 함수
//   void refresh() {
//     add(!state);
//   }
// }

class BlocAgreeCheckBox extends Bloc<bool, bool> {
  BlocAgreeCheckBox() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }

  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }
}

// (BLoC 프로바이더 클래스)
// 본 페이지에서 사용할 BLoC 객체를 모아두어 PageEntrance 에서 페이지 전역 설정에 사용 됩니다.
class BLocProviders {
// !!!이 페이지에서 사용할 "모든" BLoC 클래스들에 대한 Provider 객체들을 아래 리스트에 넣어줄 것!!!
  List<BlocProvider<dynamic>> blocProviders = [
    // ex :
    // BlocProvider<BlocSample>(create: (context) => BlocSample())
    BlocProvider<BlocAgreeCheckBox>(create: (context) => BlocAgreeCheckBox()),
  ];
}

class BLocObjects {
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocAgreeCheckBox = BlocProvider.of<BlocAgreeCheckBox>(_context);
  }

  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!!
  // ex :
  // late BlocSample blocSample;
  late BlocAgreeCheckBox blocAgreeCheckBox;
}
