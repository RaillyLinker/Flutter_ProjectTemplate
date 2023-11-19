// (external)
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../../repositories/network/apis/api_main_server.dart'
    as api_main_server;
import '../../../../repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;
import '../../../dialogs/all/all_dialog_info/page_entrance.dart'
    as all_dialog_info;
import '../../../dialogs/all/all_dialog_loading_spinner/page_entrance.dart'
    as all_dialog_loading_spinner;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageBusiness {
  PageBusiness(this._context, this.pageInputVo) {
    pageViewModel = PageViewModel(_context);
  }

  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // 페이지 생명주기 관련 states
  final gc_template_classes.PageLifeCycleStates pageLifeCycleStates =
      gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터
  final page_entrance.PageInputVo pageInputVo;

  // 페이지 뷰모델 객체
  late PageViewModel pageViewModel;

  ////
  // [페이지 생명주기]
  // - 페이지 최초 실행 : onPageCreateAsync -> onPageResumeAsync
  // - 다른 페이지 호출 / 복귀, 화면 끄기 / 켜기, 모바일에서 다른 앱으로 이동 및 복귀시 :
  // onPagePauseAsync -> onPageResumeAsync -> onPagePauseAsync -> onPageResumeAsync 반복
  // - 페이지 종료 : onPageWillPopAsync -(return true 일 때)-> onPagePauseAsync -> onPageDestroyAsync 실행

  // (페이지 최초 실행)
  Future<void> onPageCreateAsync() async {
    // !!!페이지 최초 실행 로직 작성!!!

    pageViewModel.verificationUid = pageInputVo.verificationUid;
  }

  // (페이지 최초 실행 or 다른 페이지에서 복귀)
  Future<void> onPageResumeAsync() async {
    // !!!위젯 최초 실행 및, 다른 페이지에서 복귀 로직 작성!!!

    // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
    spw_auth_member_info.SharedPreferenceWrapperVo? nowLoginMemberInfo =
        gf_my_functions.getNowVerifiedMemberInfo();

    if (nowLoginMemberInfo != null) {
      // 로그인 상태라면 다이얼로그 닫기
      _context.pop();
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
    pageViewModel.verificationCodeTextFieldController.dispose();
    pageViewModel.verificationCodeTextFieldFocus.dispose();
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
  // (다이얼로그 종료 함수)
  void closeDialog() {
    _context.pop();
  }

  // (코드 검증 후 다음 단계로 이동)
  bool isVerifyCodeAndGoNextDoing = false;

  void verifyCodeAndGoNext() async {
    if (isVerifyCodeAndGoNextDoing) {
      return;
    }
    isVerifyCodeAndGoNextDoing = true;
    if (pageViewModel.verificationCodeFormKey.currentState!.validate()) {
      // 코드 검증
      // (로딩 스피너 다이얼로그 호출)
      var loadingSpinner = all_dialog_loading_spinner.PageEntrance(
          all_dialog_loading_spinner.PageInputVo());

      showDialog(
          barrierDismissible: false,
          context: _context,
          builder: (context) => loadingSpinner).then((outputVo) {});

      var responseVo = await api_main_server
          .getService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsync(
              api_main_server
                  .GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncRequestQueryVo(
                      pageViewModel.verificationUid,
                      pageInputVo.emailAddress,
                      pageViewModel.verificationCodeTextFieldController.text));

      if (responseVo.dioException == null) {
        // Dio 네트워크 응답
        loadingSpinner.pageBusiness.closeDialog();
        var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

        if (networkResponseObjectOk.responseStatusCode == 200) {
          // 정상 응답

          // 검증 완료
          if (!_context.mounted) return;
          _context.pop(page_entrance.PageOutputVo(
              pageViewModel.verificationCodeTextFieldController.text));
        } else {
          var responseHeaders = networkResponseObjectOk.responseHeaders
              as api_main_server
              .GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncResponseHeaderVo;

          // 비정상 응답
          if (responseHeaders.apiResultCode == null) {
            // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
            if (!_context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_info.PageEntrance(
                      all_dialog_info.PageInputVo(
                          "네트워크 에러", "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "확인"),
                    ));
          } else {
            // 서버 지정 에러 코드를 전달 받았을 때
            String apiResultCode = responseHeaders.apiResultCode!;

            switch (apiResultCode) {
              case "1":
                {
                  // 이메일 검증 요청을 보낸 적 없음
                  if (!_context.mounted) return;
                  await showDialog(
                      barrierDismissible: true,
                      context: _context,
                      builder: (context) => all_dialog_info.PageEntrance(
                            all_dialog_info.PageInputVo(
                                "본인 인증 코드 검증 실패",
                                "본인 인증 요청 정보가 없습니다.\n본인 인증 코드 재전송 버튼을 눌러주세요.",
                                "확인"),
                          ));
                }
                break;
              case "2":
                {
                  // 이메일 검증 요청이 만료됨
                  if (!_context.mounted) return;
                  await showDialog(
                      barrierDismissible: true,
                      context: _context,
                      builder: (context) => all_dialog_info.PageEntrance(
                            all_dialog_info.PageInputVo(
                                "본인 인증 코드 검증 실패",
                                "본인 인증 요청 정보가 만료되었습니다.\n본인 인증 코드 재전송 버튼을 눌러주세요.",
                                "확인"),
                          ));
                }
                break;
              case "3":
                {
                  // verificationCode 가 일치하지 않음

                  // 검증 실패
                  if (!_context.mounted) return;
                  showToast(
                    "본인 인증 코드가 일치하지 않습니다.",
                    context: _context,
                    animation: StyledToastAnimation.scale,
                  );
                  FocusScope.of(_context).requestFocus(
                      pageViewModel.verificationCodeTextFieldFocus);
                }
                break;
              default:
                {
                  // 알 수 없는 코드일 때
                  throw Exception("unKnown Error Code");
                }
            }
          }
        }
      } else {
        loadingSpinner.pageBusiness.closeDialog();
        if (!_context.mounted) return;
        showDialog(
            barrierDismissible: true,
            context: _context,
            builder: (context) => all_dialog_info.PageEntrance(
                  all_dialog_info.PageInputVo(
                      "네트워크 에러", "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "확인"),
                ));
      }

      isVerifyCodeAndGoNextDoing = false;
    } else {
      isVerifyCodeAndGoNextDoing = false;
      FocusScope.of(_context)
          .requestFocus(pageViewModel.verificationCodeTextFieldFocus);
    }
  }

  // (검증 이메일 다시 전송)
  Future<void> resendVerificationEmail() async {
    // 입력값 검증 완료
    // (로딩 스피너 다이얼로그 호출)
    var loadingSpinner = all_dialog_loading_spinner.PageEntrance(
      all_dialog_loading_spinner.PageInputVo(),
    );

    showDialog(
        barrierDismissible: false,
        context: _context,
        builder: (context) => loadingSpinner).then((outputVo) {});

    var responseVo = await api_main_server
        .postService1TkV1AuthJoinTheMembershipEmailVerificationAsync(api_main_server
            .PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncRequestBodyVo(
                pageInputVo.emailAddress));

    if (responseVo.dioException == null) {
      // Dio 네트워크 응답
      loadingSpinner.pageBusiness.closeDialog();
      var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

      if (networkResponseObjectOk.responseStatusCode == 200) {
        var responseBody = networkResponseObjectOk.responseBody
            as api_main_server
            .PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseBodyVo;

        pageViewModel.verificationUid = responseBody.verificationUid;

        // 정상 응답
        if (!_context.mounted) return;
        await showDialog(
            barrierDismissible: true,
            context: _context,
            builder: (context) => all_dialog_info.PageEntrance(
                  all_dialog_info.PageInputVo(
                      "이메일 재발송 성공",
                      "본인 인증 이메일이 재발송 되었습니다.\n(${pageInputVo.emailAddress})",
                      "확인"),
                ));
        if (!_context.mounted) return;
        FocusScope.of(_context)
            .requestFocus(pageViewModel.verificationCodeTextFieldFocus);
      } else {
        var responseHeaders = networkResponseObjectOk.responseHeaders
            as api_main_server
            .PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseHeaderVo;

        // 비정상 응답
        if (responseHeaders.apiResultCode == null) {
          // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
          if (!_context.mounted) return;
          showDialog(
              barrierDismissible: true,
              context: _context,
              builder: (context) => all_dialog_info.PageEntrance(
                    all_dialog_info.PageInputVo(
                        "네트워크 에러", "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "확인"),
                  ));
        } else {
          // 서버 지정 에러 코드를 전달 받았을 때
          String apiResultCode = responseHeaders.apiResultCode!;

          switch (apiResultCode) {
            case "1":
              {
                // 기존 회원 존재
                if (!_context.mounted) return;
                await showDialog(
                    barrierDismissible: true,
                    context: _context,
                    builder: (context) => all_dialog_info.PageEntrance(
                          all_dialog_info.PageInputVo(
                              "인증 이메일 발송 실패", "이미 가입된 이메일입니다.", "확인"),
                        ));
                if (!_context.mounted) return;
                _context.pop();
              }
              break;
            default:
              {
                // 알 수 없는 코드일 때
                throw Exception("unKnown Error Code");
              }
          }
        }
      }
    } else {
      loadingSpinner.pageBusiness.closeDialog();
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

  late int verificationUid;

  // VerificationCode Form 필드 전체 키
  GlobalKey<FormState> verificationCodeFormKey = GlobalKey<FormState>();

  final verificationCodeTextFieldKey = GlobalKey<FormFieldState>();
  TextEditingController verificationCodeTextFieldController =
      TextEditingController();
  FocusNode verificationCodeTextFieldFocus = FocusNode();
}
