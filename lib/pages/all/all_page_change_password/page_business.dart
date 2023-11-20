// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;
import '../../../../repositories/network/apis/api_main_server.dart'
    as api_main_server;
import '../../../dialogs/all/all_dialog_info/page_entrance.dart'
    as all_dialog_info;
import '../../../dialogs/all/all_dialog_loading_spinner/page_entrance.dart'
    as all_dialog_loading_spinner;
import '../../../dialogs/all/all_dialog_yes_or_no/page_entrance.dart'
    as all_dialog_yes_or_no;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../../repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
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
    pageViewModel.passwordTextFieldController.dispose();
    pageViewModel.passwordTextFieldFocus.dispose();
    pageViewModel.newPasswordTextFieldController.dispose();
    pageViewModel.newPasswordTextFieldFocus.dispose();
    pageViewModel.newPasswordCheckTextFieldController.dispose();
    pageViewModel.newPasswordCheckTextFieldFocus.dispose();
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

  void passwordTextEditOnChanged() {
    // 입력창의 에러를 지우기
    pageViewModel.passwordTextEditErrorMsg = null;
    blocObjects.blocPasswordTextField.refresh();
  }

  void newPasswordCheckTextEditOnChanged() {
    // 입력창의 에러를 지우기
    pageViewModel.newPasswordCheckTextEditErrorMsg = null;
    blocObjects.blocNewPasswordCheckTextField.refresh();
  }

  void newPasswordTextEditOnChanged() {
    // 입력창의 에러를 지우기
    pageViewModel.newPasswordTextEditErrorMsg = null;
    blocObjects.blocNewPasswordTextField.refresh();
  }

  void onPasswordFieldSubmitted() {
    if (pageViewModel.passwordTextFieldController.text == "") {
      pageViewModel.passwordTextEditErrorMsg = "현재 비밀번호를 입력하세요.";
      blocObjects.blocPasswordTextField.refresh();
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    } else {
      FocusScope.of(_context)
          .requestFocus(pageViewModel.newPasswordTextFieldFocus);
    }
  }

  void onNewPasswordFieldSubmitted() {
    if (pageViewModel.newPasswordTextFieldController.text == "") {
      pageViewModel.newPasswordTextEditErrorMsg = "새 비밀번호를 입력하세요.";
      blocObjects.blocNewPasswordTextField.refresh();
      FocusScope.of(_context)
          .requestFocus(pageViewModel.newPasswordTextFieldFocus);
    } else {
      if (pageViewModel.newPasswordTextFieldController.text.contains(" ")) {
        pageViewModel.newPasswordTextEditErrorMsg = "비밀번호에 공백은 허용되지 않습니다.";
        blocObjects.blocNewPasswordTextField.refresh();
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordTextFieldFocus);
      } else if (pageViewModel.newPasswordTextFieldController.text.length < 8) {
        pageViewModel.newPasswordTextEditErrorMsg = "비밀번호는 최소 8자 이상 입력하세요.";
        blocObjects.blocNewPasswordTextField.refresh();
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordTextFieldFocus);
      } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$&*])')
          .hasMatch(pageViewModel.newPasswordTextFieldController.text)) {
        pageViewModel.newPasswordTextEditErrorMsg =
            "비밀번호는 영문 대/소문자, 숫자, 그리고 특수문자의 조합을 입력하세요.";
        blocObjects.blocNewPasswordTextField.refresh();
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordTextFieldFocus);
      } else if (RegExp(r'[<>()#’/|]')
          .hasMatch(pageViewModel.newPasswordTextFieldController.text)) {
        pageViewModel.newPasswordTextEditErrorMsg =
            "특수문자 < > ( ) # ’ / | 는 사용할 수 없습니다.";
        blocObjects.blocNewPasswordTextField.refresh();
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordTextFieldFocus);
      } else {
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordCheckTextFieldFocus);
      }
    }
  }

  void toggleHidePassword() {
    pageViewModel.hidePassword = !pageViewModel.hidePassword;
    blocObjects.blocPasswordTextField.refresh();
  }

  // (비번 숨기기 버튼 토글링)
  void toggleHideNewPassword() {
    pageViewModel.hideNewPassword = !pageViewModel.hideNewPassword;
    blocObjects.blocNewPasswordTextField.refresh();
  }

  void toggleHideNewPasswordCheck() {
    pageViewModel.hideNewPasswordCheck = !pageViewModel.hideNewPasswordCheck;
    blocObjects.blocNewPasswordCheckTextField.refresh();
  }

  void onNewPasswordCheckFieldSubmitted() {
    changePassword();
  }

  // (비밀번호 변경)
  bool changePasswordStart = false;

  Future<void> changePassword() async {
    if (changePasswordStart) {
      return;
    }
    changePasswordStart = true;

    pageViewModel.passwordTextEditErrorMsg = null;
    blocObjects.blocPasswordTextField.refresh();
    pageViewModel.newPasswordTextEditErrorMsg = null;
    blocObjects.blocNewPasswordTextField.refresh();
    pageViewModel.newPasswordCheckTextEditErrorMsg = null;
    blocObjects.blocNewPasswordCheckTextField.refresh();

    if (pageViewModel.passwordTextFieldController.text == "") {
      pageViewModel.passwordTextEditErrorMsg = "현재 비밀번호를 입력하세요.";
      blocObjects.blocPasswordTextField.refresh();
      FocusScope.of(_context)
          .requestFocus(pageViewModel.passwordTextFieldFocus);
    } else if (pageViewModel.newPasswordTextFieldController.text == "") {
      pageViewModel.newPasswordTextEditErrorMsg = "새 비밀번호를 입력하세요.";
      blocObjects.blocNewPasswordTextField.refresh();
      FocusScope.of(_context)
          .requestFocus(pageViewModel.newPasswordTextFieldFocus);
    } else {
      if (pageViewModel.newPasswordTextFieldController.text.contains(" ")) {
        pageViewModel.newPasswordTextEditErrorMsg = "새 비밀번호에 공백은 허용되지 않습니다.";
        blocObjects.blocNewPasswordTextField.refresh();
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordTextFieldFocus);
      } else if (pageViewModel.newPasswordTextFieldController.text.length < 8) {
        pageViewModel.newPasswordTextEditErrorMsg = "새 비밀번호는 최소 8자 이상 입력하세요.";
        blocObjects.blocNewPasswordTextField.refresh();
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordTextFieldFocus);
      } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$&*])')
          .hasMatch(pageViewModel.newPasswordTextFieldController.text)) {
        pageViewModel.newPasswordTextEditErrorMsg =
            "새 비밀번호는 영문 대/소문자, 숫자, 그리고 특수문자의 조합을 입력하세요.";
        blocObjects.blocNewPasswordTextField.refresh();
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordTextFieldFocus);
      } else if (RegExp(r'[<>()#’/|]')
          .hasMatch(pageViewModel.newPasswordTextFieldController.text)) {
        pageViewModel.newPasswordTextEditErrorMsg =
            "특수문자 < > ( ) # ’ / | 는 사용할 수 없습니다.";
        blocObjects.blocNewPasswordTextField.refresh();
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordTextFieldFocus);
      } else if (pageViewModel.newPasswordCheckTextFieldController.text == "") {
        pageViewModel.newPasswordCheckTextEditErrorMsg = "새 비밀번호 확인을 입력하세요.";
        blocObjects.blocNewPasswordCheckTextField.refresh();
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordCheckTextFieldFocus);
      } else if (pageViewModel.newPasswordCheckTextFieldController.text !=
          pageViewModel.newPasswordTextFieldController.text) {
        pageViewModel.newPasswordCheckTextEditErrorMsg = "새 비밀번호와 일치하지 않습니다.";
        blocObjects.blocNewPasswordCheckTextField.refresh();
        FocusScope.of(_context)
            .requestFocus(pageViewModel.newPasswordCheckTextFieldFocus);
      } else {
        await _requestChangePassword();
      }
    }

    changePasswordStart = false;
  }

  // 비밀번호 입력 규칙 클릭
  void onPasswordInputRuleTap() {
    pageViewModel.passwordInputRuleHide = !pageViewModel.passwordInputRuleHide;
    blocObjects.blocPasswordInputRule.refresh();
  }

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!!
  Future<void> _requestChangePassword() async {
    var loadingSpinner = all_dialog_loading_spinner.PageEntrance(
      all_dialog_loading_spinner.PageInputVo(),
    );

    showDialog(
        barrierDismissible: false,
        context: _context,
        builder: (context) => loadingSpinner).then((outputVo) {});

    spw_auth_member_info.SharedPreferenceWrapperVo? loginMemberInfo =
        spw_auth_member_info.SharedPreferenceWrapper.get();

    if (loginMemberInfo == null) {
      // 비회원 상태라면 진입 금지
      if (!_context.mounted) return;
      showToast(
        "로그인이 필요합니다.",
        context: _context,
        animation: StyledToastAnimation.scale,
      );
      // Login 페이지로 이동
      _context.pushNamed(all_page_login.pageName);
      return;
    }

    String? oldPw;
    String? newPw;

    if (pageViewModel.passwordTextFieldController.text.trim() != "") {
      oldPw = pageViewModel.passwordTextFieldController.text;
    }

    if (pageViewModel.newPasswordTextFieldController.text.trim() != "") {
      newPw = pageViewModel.newPasswordTextFieldController.text;
    }

    var response =
        await api_main_server.putService1TkV1AuthChangeAccountPasswordAsync(
            requestHeaderVo: api_main_server
                .PutService1TkV1AuthChangeAccountPasswordAsyncRequestHeaderVo(
                    authorization:
                        "${loginMemberInfo.tokenType} ${loginMemberInfo.accessToken}"),
            requestBodyVo: api_main_server
                .PutService1TkV1AuthChangeAccountPasswordAsyncRequestBodyVo(
                    oldPassword: oldPw, newPassword: newPw));

    // 로딩 다이얼로그 제거
    loadingSpinner.pageBusiness.closeDialog();

    if (response.dioException == null) {
      // Dio 네트워크 응답
      var networkResponseObjectOk = response.networkResponseObjectOk!;

      if (networkResponseObjectOk.responseStatusCode == 200) {
        // 정상 응답

        // 확인 다이얼로그 호출
        if (!_context.mounted) return;
        showDialog(
            barrierDismissible: true,
            context: _context,
            builder: (context) => all_dialog_yes_or_no.PageEntrance(
                  all_dialog_yes_or_no.PageInputVo(
                      "비밀번호 변경",
                      "비밀번호 변경이 완료되었습니다.\n"
                          "로그아웃 됩니다.\n\n"
                          "로그인된 다른 디바이스에서도\n"
                          "로그아웃 처리를 하겠습니까?",
                      "예",
                      "아니오"),
                )).then((outputVo) async {
          if (outputVo.checkPositiveBtn) {
            // 계정 로그아웃 처리
            var loadingSpinner = all_dialog_loading_spinner.PageEntrance(
              all_dialog_loading_spinner.PageInputVo(),
            );

            showDialog(
                barrierDismissible: false,
                context: _context,
                builder: (context) => loadingSpinner).then((outputVo) {});

            spw_auth_member_info.SharedPreferenceWrapperVo? loginMemberInfo =
                spw_auth_member_info.SharedPreferenceWrapper.get();

            if (loginMemberInfo != null) {
              // 모든 기기에서 로그아웃 처리하기

              // 서버 Logout API 실행
              spw_auth_member_info.SharedPreferenceWrapperVo? loginMemberInfo =
                  spw_auth_member_info.SharedPreferenceWrapper.get();

              await api_main_server.deleteService1TkV1AuthAllAuthorizationTokenAsync(
                  requestHeaderVo: api_main_server
                      .DeleteService1TkV1AuthAllAuthorizationTokenAsyncRequestHeaderVo(
                          authorization:
                              "${loginMemberInfo!.tokenType} ${loginMemberInfo.accessToken}"));

              // login_user_info SPW 비우기
              spw_auth_member_info.SharedPreferenceWrapper.set(value: null);
            }

            loadingSpinner.pageBusiness.closeDialog();
            if (!_context.mounted) return;
            _context.pop();
          } else {
            // 계정 로그아웃 처리
            var loadingSpinner = all_dialog_loading_spinner.PageEntrance(
              all_dialog_loading_spinner.PageInputVo(),
            );

            showDialog(
                barrierDismissible: false,
                context: _context,
                builder: (context) => loadingSpinner).then((outputVo) {});

            spw_auth_member_info.SharedPreferenceWrapperVo? loginMemberInfo =
                spw_auth_member_info.SharedPreferenceWrapper.get();

            if (loginMemberInfo != null) {
              // 서버 Logout API 실행
              spw_auth_member_info.SharedPreferenceWrapperVo? loginMemberInfo =
                  spw_auth_member_info.SharedPreferenceWrapper.get();
              await api_main_server.postService1TkV1AuthLogoutAsync(
                  requestHeaderVo: api_main_server
                      .PostService1TkV1AuthLogoutAsyncRequestHeaderVo(
                          authorization:
                              "${loginMemberInfo!.tokenType} ${loginMemberInfo.accessToken}"));

              // login_user_info SPW 비우기
              spw_auth_member_info.SharedPreferenceWrapper.set(value: null);
            }

            loadingSpinner.pageBusiness.closeDialog();
            if (!_context.mounted) return;
            _context.pop();
          }
        });
      } else {
        var responseHeaders = networkResponseObjectOk.responseHeaders
            as api_main_server
            .PutService1TkV1AuthChangeAccountPasswordAsyncResponseHeaderVo;

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
                // 탈퇴된 회원
                if (!_context.mounted) return;
                await showDialog(
                    barrierDismissible: true,
                    context: _context,
                    builder: (context) => all_dialog_info.PageEntrance(
                          all_dialog_info.PageInputVo(
                              "비밀번호 변경 실패", "탈퇴된 회원입니다.", "확인"),
                        ));
              }
              break;
            case "2":
              {
                // 기존 비밀번호가 일치하지 않음
                if (!_context.mounted) return;
                await showDialog(
                    barrierDismissible: true,
                    context: _context,
                    builder: (context) => all_dialog_info.PageEntrance(
                          all_dialog_info.PageInputVo(
                              "비밀번호 변경 실패", "입력한 현재 비밀번호가\n일치하지 않습니다.", "확인"),
                        ));
              }
              break;
            case "3":
              {
                // 비번을 null 로 만들려고 할 때 account 외의 OAuth2 인증이 없기에 비번 제거 불가
                if (!_context.mounted) return;
                await showDialog(
                    barrierDismissible: true,
                    context: _context,
                    builder: (context) => all_dialog_info.PageEntrance(
                          all_dialog_info.PageInputVo(
                              "비밀번호 변경 실패", "비밀번호를 제거할 수 없습니다.", "확인"),
                        ));
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
      // Dio 네트워크 에러
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
  gw_page_out_frames.PageOutFrameBusiness pageOutFrameBusiness =
      gw_page_out_frames.PageOutFrameBusiness(pageTitle: "비밀번호 변경");

  FocusNode passwordTextFieldFocus = FocusNode();
  TextEditingController passwordTextFieldController = TextEditingController();
  bool hidePassword = true;
  String? passwordTextEditErrorMsg;

  FocusNode newPasswordTextFieldFocus = FocusNode();
  TextEditingController newPasswordTextFieldController =
      TextEditingController();
  bool hideNewPassword = true;
  String? newPasswordTextEditErrorMsg;

  FocusNode newPasswordCheckTextFieldFocus = FocusNode();
  TextEditingController newPasswordCheckTextFieldController =
      TextEditingController();
  bool hideNewPasswordCheck = true;
  String? newPasswordCheckTextEditErrorMsg;

  bool passwordInputRuleHide = true;
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

class BlocPasswordTextField extends Bloc<bool, bool> {
  BlocPasswordTextField() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }

  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }
}

class BlocNewPasswordTextField extends Bloc<bool, bool> {
  BlocNewPasswordTextField() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }

  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }
}

class BlocNewPasswordCheckTextField extends Bloc<bool, bool> {
  BlocNewPasswordCheckTextField() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }

  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }
}

class BlocPasswordInputRule extends Bloc<bool, bool> {
  BlocPasswordInputRule() : super(true) {
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
    BlocProvider<BlocPasswordTextField>(
        create: (context) => BlocPasswordTextField()),
    BlocProvider<BlocNewPasswordTextField>(
        create: (context) => BlocNewPasswordTextField()),
    BlocProvider<BlocNewPasswordCheckTextField>(
        create: (context) => BlocNewPasswordCheckTextField()),
    BlocProvider<BlocPasswordInputRule>(
        create: (context) => BlocPasswordInputRule()),
  ];
}

class BLocObjects {
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocPasswordTextField = BlocProvider.of<BlocPasswordTextField>(_context);
    blocNewPasswordTextField =
        BlocProvider.of<BlocNewPasswordTextField>(_context);
    blocNewPasswordCheckTextField =
        BlocProvider.of<BlocNewPasswordCheckTextField>(_context);
    blocPasswordInputRule = BlocProvider.of<BlocPasswordInputRule>(_context);
  }

  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!!
  // ex :
  // late BlocSample blocSample;
  late BlocPasswordTextField blocPasswordTextField;
  late BlocNewPasswordTextField blocNewPasswordTextField;
  late BlocNewPasswordCheckTextField blocNewPasswordCheckTextField;
  late BlocPasswordInputRule blocPasswordInputRule;
}
