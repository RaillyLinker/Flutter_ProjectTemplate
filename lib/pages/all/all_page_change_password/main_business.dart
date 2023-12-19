// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// (inner_folder)
import 'main_widget.dart' as main_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;
import 'package:flutter_project_template/repositories/network/apis/api_main_server.dart'
    as api_main_server;
import 'package:flutter_project_template/dialogs/all/all_dialog_info/main_widget.dart'
    as all_dialog_info;
import 'package:flutter_project_template/dialogs/all/all_dialog_loading_spinner/main_widget.dart'
    as all_dialog_loading_spinner;
import 'package:flutter_project_template/dialogs/all/all_dialog_yes_or_no/main_widget.dart'
    as all_dialog_yes_or_no;
import 'package:flutter_project_template/repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import 'package:flutter_project_template/global_functions/gf_my_functions.dart'
    as gf_my_functions;
import 'package:flutter_project_template/pages/all/all_page_login/main_widget.dart'
    as all_page_login;
import 'package:flutter_project_template/pages/all/all_page_home/main_widget.dart'
    as all_page_home;

// [위젯 비즈니스]

//------------------------------------------------------------------------------
class MainBusiness {
  // [CallBack 함수]
  // (inputVo 확인 콜백)
  // State 클래스의 initState 에서 실행 되며, Business 클래스의 initState 실행 전에 실행 됩니다.
  // 필수 정보 누락시 null 을 반환, null 이 반환 되었을 때는 inputError 가 true 가 됩니다.
  main_widget.InputVo? onCheckPageInputVo(
      {required GoRouterState goRouterState}) {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters.containsKey("inputValueString")) {
    //   return null;
    // }

    // !!!PageInputVo 입력!!!
    return const main_widget.InputVo();
  }

  // (진입 최초 단 한번 실행) - 아직 위젯이 생성 되기 전
  void initState() {
    // !!!initState 로직 작성!!!
  }

  // (종료 시점 단 한번 실행)
  void dispose() {
    // !!!dispose 로직 작성!!!
    passwordTextFieldController.dispose();
    passwordTextFieldFocus.dispose();
    newPasswordTextFieldController.dispose();
    newPasswordTextFieldFocus.dispose();
    newPasswordCheckTextFieldController.dispose();
    newPasswordCheckTextFieldFocus.dispose();
  }

  // (최초 실행시 단 한번 실행) - 위젯 build 바로 직전, 모든 것이 준비 되었을 때
  void onCreate() {
    // !!!onCreate 로직 작성!!!
  }

  Future<void> onFocusGainedAsync() async {
    // !!!onFocusGainedAsync 로직 작성!!!

    // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
    spw_auth_member_info.SharedPreferenceWrapperVo? nowLoginMemberInfo =
        gf_my_functions.getNowVerifiedMemberInfo();

    if (nowLoginMemberInfo == null) {
      // 비회원 상태라면 진입 금지
      showToast(
        "로그인이 필요합니다.",
        context: mainContext,
        animation: StyledToastAnimation.scale,
      );
      // Login 페이지로 이동
      mainContext.pushNamed(all_page_login.pageName);
      return;
    }
  }

  Future<void> onFocusLostAsync() async {
    // !!!onFocusLostAsync 로직 작성!!!
  }

  Future<void> onVisibilityGainedAsync() async {
    // !!!onVisibilityGainedAsync 로직 작성!!!
  }

  Future<void> onVisibilityLostAsync() async {
    // !!!onVisibilityLostAsync 로직 작성!!!
  }

  Future<void> onForegroundGainedAsync() async {
    // !!!onForegroundGainedAsync 로직 작성!!!
  }

  Future<void> onForegroundLostAsync() async {
    // !!!onForegroundLostAsync 로직 작성!!!
  }

  //----------------------------------------------------------------------------
  // !!!메인 위젯에서 사용할 변수는 이곳에서 저장하여 사용하세요.!!!
  // [public 변수]
  // (위젯 입력값)
  late main_widget.InputVo inputVo;

  // (페이지 pop 가능 여부 변수) - false 로 설정시 pop 불가
  bool canPop = true;

  // (입력값 미충족 여부)
  bool inputError = false;

  // (context 객체)
  late BuildContext mainContext;

  // (최초 실행 플래그)
  bool pageInitFirst = true;

  // (pageOutFrameBusiness)
  final gw_slw_page_outer_frame.SlwPageOuterFrameBusiness pageOutFrameBusiness =
      gw_slw_page_outer_frame.SlwPageOuterFrameBusiness();

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState>
      passwordTextFieldAreaGk = GlobalKey();
  late BuildContext passwordTextFieldContext;
  final TextEditingController passwordTextFieldController =
      TextEditingController();
  final FocusNode passwordTextFieldFocus = FocusNode();
  String? passwordTextFieldErrorMsg;
  bool passwordTextFieldHide = true;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState>
      newPasswordTextFieldAreaGk = GlobalKey();
  late BuildContext newPasswordTextFieldContext;
  final TextEditingController newPasswordTextFieldController =
      TextEditingController();
  final FocusNode newPasswordTextFieldFocus = FocusNode();
  String? newPasswordTextFieldErrorMsg;
  bool newPasswordTextFieldHide = true;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState>
      newPasswordCheckTextFieldAreaGk = GlobalKey();
  late BuildContext newPasswordCheckTextFieldContext;
  final TextEditingController newPasswordCheckTextFieldController =
      TextEditingController();
  final FocusNode newPasswordCheckTextFieldFocus = FocusNode();
  String? newPasswordCheckTextFieldErrorMsg;
  bool newPasswordCheckTextFieldHide = true;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState>
      passwordInputRuleHideAreaGk = GlobalKey();
  late BuildContext passwordInputRuleHideContext;
  bool passwordInputRuleHide = true;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!비즈니스 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (메인 위젯 화면 갱신)
  late VoidCallback refreshUi;

  void onPasswordFieldSubmitted() {
    if (passwordTextFieldController.text == "") {
      passwordTextFieldErrorMsg = "현재 비밀번호를 입력하세요.";
      passwordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(passwordTextFieldContext)
          .requestFocus(passwordTextFieldFocus);
      return;
    }

    FocusScope.of(newPasswordTextFieldContext)
        .requestFocus(newPasswordTextFieldFocus);
  }

  void onNewPasswordFieldSubmitted() {
    if (newPasswordTextFieldController.text == "") {
      newPasswordTextFieldErrorMsg = "새 비밀번호를 입력하세요.";
      newPasswordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(newPasswordTextFieldContext)
          .requestFocus(newPasswordTextFieldFocus);
      return;
    }

    if (newPasswordTextFieldController.text.contains(" ")) {
      newPasswordTextFieldErrorMsg = "비밀번호에 공백은 허용되지 않습니다.";
      newPasswordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(newPasswordTextFieldContext)
          .requestFocus(newPasswordTextFieldFocus);
      return;
    }

    if (newPasswordTextFieldController.text.length < 8) {
      newPasswordTextFieldErrorMsg = "비밀번호는 최소 8자 이상 입력하세요.";
      newPasswordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(newPasswordTextFieldContext)
          .requestFocus(newPasswordTextFieldFocus);
      return;
    }

    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$&*])')
        .hasMatch(newPasswordTextFieldController.text)) {
      newPasswordTextFieldErrorMsg = "비밀번호는 영문 대/소문자, 숫자, 그리고 특수문자의 조합을 입력하세요.";
      newPasswordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(newPasswordTextFieldContext)
          .requestFocus(newPasswordTextFieldFocus);
      return;
    }

    if (RegExp(r'[<>()#’/|]').hasMatch(newPasswordTextFieldController.text)) {
      newPasswordTextFieldErrorMsg = "특수문자 < > ( ) # ’ / | 는 사용할 수 없습니다.";
      newPasswordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(newPasswordTextFieldContext)
          .requestFocus(newPasswordTextFieldFocus);
      return;
    }

    FocusScope.of(newPasswordCheckTextFieldContext)
        .requestFocus(newPasswordCheckTextFieldFocus);
  }

  void onNewPasswordCheckFieldSubmitted() {
    if (newPasswordCheckTextFieldController.text == "") {
      newPasswordCheckTextFieldErrorMsg = "새 비밀번호 확인을 입력하세요.";
      newPasswordCheckTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(newPasswordCheckTextFieldContext)
          .requestFocus(newPasswordCheckTextFieldFocus);
      return;
    }

    if (newPasswordCheckTextFieldController.text !=
        newPasswordTextFieldController.text) {
      newPasswordCheckTextFieldErrorMsg = "새 비밀번호와 일치하지 않습니다.";
      newPasswordCheckTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(newPasswordCheckTextFieldContext)
          .requestFocus(newPasswordCheckTextFieldFocus);
      return;
    }

    changePassword();
  }

  // (비밀번호 변경)
  bool changePasswordStart = false;

  Future<void> changePassword() async {
    if (changePasswordStart) {
      return;
    }
    changePasswordStart = true;

    passwordTextFieldErrorMsg = null;
    passwordTextFieldAreaGk.currentState?.refreshUi();
    newPasswordTextFieldErrorMsg = null;
    newPasswordTextFieldAreaGk.currentState?.refreshUi();
    newPasswordCheckTextFieldErrorMsg = null;
    newPasswordCheckTextFieldAreaGk.currentState?.refreshUi();

    if (passwordTextFieldController.text == "") {
      passwordTextFieldErrorMsg = "현재 비밀번호를 입력하세요.";
      passwordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(passwordTextFieldContext)
          .requestFocus(passwordTextFieldFocus);
      changePasswordStart = false;
      return;
    }
    if (newPasswordTextFieldController.text == "") {
      newPasswordTextFieldErrorMsg = "새 비밀번호를 입력하세요.";
      newPasswordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(newPasswordTextFieldContext)
          .requestFocus(newPasswordTextFieldFocus);
      changePasswordStart = false;
      return;
    }

    if (newPasswordTextFieldController.text.contains(" ")) {
      newPasswordTextFieldErrorMsg = "비밀번호에 공백은 허용되지 않습니다.";
      newPasswordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(newPasswordTextFieldContext)
          .requestFocus(newPasswordTextFieldFocus);
      changePasswordStart = false;
      return;
    }

    if (newPasswordTextFieldController.text.length < 8) {
      newPasswordTextFieldErrorMsg = "비밀번호는 최소 8자 이상 입력하세요.";
      newPasswordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(newPasswordTextFieldContext)
          .requestFocus(newPasswordTextFieldFocus);
      changePasswordStart = false;
      return;
    }

    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$&*])')
        .hasMatch(newPasswordTextFieldController.text)) {
      newPasswordTextFieldErrorMsg = "비밀번호는 영문 대/소문자, 숫자, 그리고 특수문자의 조합을 입력하세요.";
      newPasswordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(newPasswordTextFieldContext)
          .requestFocus(newPasswordTextFieldFocus);
      changePasswordStart = false;
      return;
    }

    if (RegExp(r'[<>()#’/|]').hasMatch(newPasswordTextFieldController.text)) {
      newPasswordTextFieldErrorMsg = "특수문자 < > ( ) # ’ / | 는 사용할 수 없습니다.";
      newPasswordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(newPasswordTextFieldContext)
          .requestFocus(newPasswordTextFieldFocus);
      changePasswordStart = false;
      return;
    }

    if (newPasswordCheckTextFieldController.text == "") {
      newPasswordCheckTextFieldErrorMsg = "새 비밀번호 확인을 입력하세요.";
      newPasswordCheckTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(newPasswordCheckTextFieldContext)
          .requestFocus(newPasswordCheckTextFieldFocus);
      changePasswordStart = false;
      return;
    }

    if (newPasswordCheckTextFieldController.text !=
        newPasswordTextFieldController.text) {
      newPasswordCheckTextFieldErrorMsg = "새 비밀번호와 일치하지 않습니다.";
      newPasswordCheckTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(newPasswordCheckTextFieldContext)
          .requestFocus(newPasswordCheckTextFieldFocus);
      changePasswordStart = false;
      return;
    }

    GlobalKey<all_dialog_loading_spinner.MainWidgetState>
        allDialogLoadingSpinnerStateGk = GlobalKey();

    showDialog(
        barrierDismissible: false,
        context: mainContext,
        builder: (context) => all_dialog_loading_spinner.MainWidget(
              key: allDialogLoadingSpinnerStateGk,
              inputVo:
                  all_dialog_loading_spinner.InputVo(onDialogCreated: () async {
                spw_auth_member_info.SharedPreferenceWrapperVo?
                    loginMemberInfo =
                    spw_auth_member_info.SharedPreferenceWrapper.get();

                if (loginMemberInfo == null) {
                  // 비회원 상태라면 진입 금지
                  if (!mainContext.mounted) return;
                  showToast(
                    "로그인이 필요합니다.",
                    context: mainContext,
                    animation: StyledToastAnimation.scale,
                  );
                  // Login 페이지로 이동
                  changePasswordStart = false;
                  mainContext.pushNamed(all_page_login.pageName);
                  return;
                }

                String oldPw = passwordTextFieldController.text;
                String newPw = newPasswordTextFieldController.text;

                var response = await api_main_server
                    .putService1TkV1AuthChangeAccountPasswordAsync(
                        requestHeaderVo: api_main_server
                            .PutService1TkV1AuthChangeAccountPasswordAsyncRequestHeaderVo(
                                authorization:
                                    "${loginMemberInfo.tokenType} ${loginMemberInfo.accessToken}"),
                        requestBodyVo: api_main_server
                            .PutService1TkV1AuthChangeAccountPasswordAsyncRequestBodyVo(
                                oldPassword: oldPw, newPassword: newPw));

                // 로딩 다이얼로그 제거
                allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                    .closeDialog();
                changePasswordStart = false;

                if (response.dioException == null) {
                  // Dio 네트워크 응답
                  var networkResponseObjectOk =
                      response.networkResponseObjectOk!;

                  if (networkResponseObjectOk.responseStatusCode == 200) {
                    // 정상 응답

                    // 확인 다이얼로그 호출
                    final GlobalKey<all_dialog_yes_or_no.MainWidgetState>
                        allDialogYesOrNoStateGk = GlobalKey();
                    if (!mainContext.mounted) return;
                    showDialog(
                        barrierDismissible: true,
                        context: mainContext,
                        builder: (context) => all_dialog_yes_or_no.MainWidget(
                              key: allDialogYesOrNoStateGk,
                              inputVo: all_dialog_yes_or_no.InputVo(
                                dialogTitle: "비밀번호 변경",
                                dialogContent: "비밀번호 변경이 완료되었습니다.\n"
                                    "로그아웃 됩니다.\n\n"
                                    "로그인된 다른 디바이스에서도\n"
                                    "로그아웃 처리를 하겠습니까?",
                                positiveBtnTitle: "예",
                                negativeBtnTitle: "아니오",
                                onDialogCreated: () {},
                              ),
                            )).then((outputVo) async {
                      if (outputVo.checkPositiveBtn) {
                        // 계정 로그아웃 처리
                        GlobalKey<all_dialog_loading_spinner.MainWidgetState>
                            allDialogLoadingSpinnerStateGk = GlobalKey();

                        showDialog(
                            barrierDismissible: false,
                            context: mainContext,
                            builder: (context) =>
                                all_dialog_loading_spinner.MainWidget(
                                  key: allDialogLoadingSpinnerStateGk,
                                  inputVo: all_dialog_loading_spinner.InputVo(
                                      onDialogCreated: () async {
                                    spw_auth_member_info
                                        .SharedPreferenceWrapperVo?
                                        loginMemberInfo = spw_auth_member_info
                                            .SharedPreferenceWrapper.get();

                                    if (loginMemberInfo != null) {
                                      // 모든 기기에서 로그아웃 처리하기

                                      // 서버 Logout API 실행
                                      spw_auth_member_info
                                          .SharedPreferenceWrapperVo?
                                          loginMemberInfo = spw_auth_member_info
                                              .SharedPreferenceWrapper.get();

                                      await api_main_server
                                          .deleteService1TkV1AuthAllAuthorizationTokenAsync(
                                              requestHeaderVo: api_main_server
                                                  .DeleteService1TkV1AuthAllAuthorizationTokenAsyncRequestHeaderVo(
                                                      authorization:
                                                          "${loginMemberInfo!.tokenType} ${loginMemberInfo.accessToken}"));

                                      // login_user_info SPW 비우기
                                      spw_auth_member_info
                                              .SharedPreferenceWrapper
                                          .set(value: null);
                                    }

                                    allDialogLoadingSpinnerStateGk
                                        .currentState?.mainBusiness
                                        .closeDialog();
                                    if (!mainContext.mounted) return;
                                    // 홈 페이지로 이동
                                    mainContext.goNamed(all_page_home.pageName);
                                  }),
                                )).then((outputVo) {});
                      } else {
                        // 계정 로그아웃 처리
                        GlobalKey<all_dialog_loading_spinner.MainWidgetState>
                            allDialogLoadingSpinnerStateGk = GlobalKey();

                        showDialog(
                            barrierDismissible: false,
                            context: mainContext,
                            builder: (context) =>
                                all_dialog_loading_spinner.MainWidget(
                                  key: allDialogLoadingSpinnerStateGk,
                                  inputVo: all_dialog_loading_spinner.InputVo(
                                      onDialogCreated: () async {
                                    spw_auth_member_info
                                        .SharedPreferenceWrapperVo?
                                        loginMemberInfo = spw_auth_member_info
                                            .SharedPreferenceWrapper.get();

                                    if (loginMemberInfo != null) {
                                      // 서버 Logout API 실행
                                      spw_auth_member_info
                                          .SharedPreferenceWrapperVo?
                                          loginMemberInfo = spw_auth_member_info
                                              .SharedPreferenceWrapper.get();
                                      await api_main_server
                                          .postService1TkV1AuthLogoutAsync(
                                              requestHeaderVo: api_main_server
                                                  .PostService1TkV1AuthLogoutAsyncRequestHeaderVo(
                                                      authorization:
                                                          "${loginMemberInfo!.tokenType} ${loginMemberInfo.accessToken}"));

                                      // login_user_info SPW 비우기
                                      spw_auth_member_info
                                              .SharedPreferenceWrapper
                                          .set(value: null);
                                    }

                                    allDialogLoadingSpinnerStateGk
                                        .currentState?.mainBusiness
                                        .closeDialog();
                                    if (!mainContext.mounted) return;
                                    // 홈 페이지로 이동
                                    mainContext.goNamed(all_page_home.pageName);
                                  }),
                                )).then((outputVo) {});
                      }
                    });
                  } else {
                    var responseHeaders = networkResponseObjectOk
                            .responseHeaders as api_main_server
                        .PutService1TkV1AuthChangeAccountPasswordAsyncResponseHeaderVo;

                    // 비정상 응답
                    if (responseHeaders.apiResultCode == null) {
                      // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
                      final GlobalKey<all_dialog_info.MainWidgetState>
                          allDialogInfoStateGk =
                          GlobalKey<all_dialog_info.MainWidgetState>();
                      if (!mainContext.mounted) return;
                      showDialog(
                          barrierDismissible: true,
                          context: mainContext,
                          builder: (context) => all_dialog_info.MainWidget(
                                key: allDialogInfoStateGk,
                                inputVo: all_dialog_info.InputVo(
                                  dialogTitle: "네트워크 에러",
                                  dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                                  checkBtnTitle: "확인",
                                  onDialogCreated: () {},
                                ),
                              ));
                    } else {
                      // 서버 지정 에러 코드를 전달 받았을 때
                      String apiResultCode = responseHeaders.apiResultCode!;

                      switch (apiResultCode) {
                        case "1":
                          {
                            // 탈퇴된 회원
                            final GlobalKey<all_dialog_info.MainWidgetState>
                                allDialogInfoStateGk =
                                GlobalKey<all_dialog_info.MainWidgetState>();
                            if (!mainContext.mounted) return;
                            await showDialog(
                                barrierDismissible: true,
                                context: mainContext,
                                builder: (context) =>
                                    all_dialog_info.MainWidget(
                                      key: allDialogInfoStateGk,
                                      inputVo: all_dialog_info.InputVo(
                                        dialogTitle: "비밀번호 변경 실패",
                                        dialogContent: "탈퇴된 회원입니다.",
                                        checkBtnTitle: "확인",
                                        onDialogCreated: () {},
                                      ),
                                    ));
                          }
                          break;
                        case "2":
                          {
                            // 기존 비밀번호가 일치하지 않음
                            final GlobalKey<all_dialog_info.MainWidgetState>
                                allDialogInfoStateGk =
                                GlobalKey<all_dialog_info.MainWidgetState>();
                            if (!mainContext.mounted) return;
                            await showDialog(
                                barrierDismissible: true,
                                context: mainContext,
                                builder: (context) =>
                                    all_dialog_info.MainWidget(
                                      key: allDialogInfoStateGk,
                                      inputVo: all_dialog_info.InputVo(
                                        dialogTitle: "비밀번호 변경 실패",
                                        dialogContent:
                                            "입력한 현재 비밀번호가\n일치하지 않습니다.",
                                        checkBtnTitle: "확인",
                                        onDialogCreated: () {},
                                      ),
                                    ));
                          }
                          break;
                        case "3":
                          {
                            // 비번을 null 로 만들려고 할 때 account 외의 OAuth2 인증이 없기에 비번 제거 불가
                            final GlobalKey<all_dialog_info.MainWidgetState>
                                allDialogInfoStateGk =
                                GlobalKey<all_dialog_info.MainWidgetState>();
                            if (!mainContext.mounted) return;
                            await showDialog(
                                barrierDismissible: true,
                                context: mainContext,
                                builder: (context) =>
                                    all_dialog_info.MainWidget(
                                      key: allDialogInfoStateGk,
                                      inputVo: all_dialog_info.InputVo(
                                        dialogTitle: "비밀번호 변경 실패",
                                        dialogContent: "비밀번호를 제거할 수 없습니다.",
                                        checkBtnTitle: "확인",
                                        onDialogCreated: () {},
                                      ),
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
                  final GlobalKey<all_dialog_info.MainWidgetState>
                      allDialogInfoStateGk =
                      GlobalKey<all_dialog_info.MainWidgetState>();
                  if (!mainContext.mounted) return;
                  showDialog(
                      barrierDismissible: true,
                      context: mainContext,
                      builder: (context) => all_dialog_info.MainWidget(
                            key: allDialogInfoStateGk,
                            inputVo: all_dialog_info.InputVo(
                              dialogTitle: "네트워크 에러",
                              dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                              checkBtnTitle: "확인",
                              onDialogCreated: () {},
                            ),
                          ));
                }
              }),
            )).then((outputVo) {});
  }

  // 비밀번호 입력 규칙 클릭
  void onPasswordInputRuleTap() {
    passwordInputRuleHide = !passwordInputRuleHide;
    passwordInputRuleHideAreaGk.currentState?.refreshUi();
  }

  // [private 함수]
  void _doNothing() {}
}
