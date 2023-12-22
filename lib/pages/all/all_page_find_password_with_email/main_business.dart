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
import 'package:flutter_project_template/repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import 'package:flutter_project_template/global_functions/gf_my_functions.dart'
    as gf_my_functions;
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
    emailTextFieldController.dispose();
    emailTextFieldFocus.dispose();
    verificationCodeTextFieldController.dispose();
    verificationCodeTextFieldFocus.dispose();
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

    if (nowLoginMemberInfo != null) {
      // 로그인 상태라면 진입금지
      showToast(
        "잘못된 진입입니다.",
        context: mainContext,
        animation: StyledToastAnimation.scale,
      );
      // 홈 페이지로 이동
      mainContext.goNamed(all_page_home.pageName);
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

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> emailTextFieldAreaGk =
      GlobalKey();
  late BuildContext emailTextFieldContext;
  final TextEditingController emailTextFieldController =
      TextEditingController();
  final FocusNode emailTextFieldFocus = FocusNode();
  String? emailTextFieldErrorMsg;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState>
      verificationCodeTextFieldAreaGk = GlobalKey();
  late BuildContext verificationCodeTextFieldContext;
  final TextEditingController verificationCodeTextFieldController =
      TextEditingController();
  final FocusNode verificationCodeTextFieldFocus = FocusNode();
  String? verificationCodeTextFieldErrorMsg;

  // 검증 고유값
  int? emailVerificationUid;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!비즈니스 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (메인 위젯 화면 갱신)
  late VoidCallback refreshUi;

  // (이메일 텍스트 에디트 입력 변화)
  void emailTextEditOnSubmitted() {
    if (emailTextFieldController.text.trim() == "") {
      emailTextFieldErrorMsg = "이메일을 입력하세요.";
      emailTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(emailTextFieldContext).requestFocus(emailTextFieldFocus);
      return;
    }

    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$')
        .hasMatch(emailTextFieldController.text)) {
      emailTextFieldErrorMsg = "올바른 이메일 형식이 아닙니다.";
      emailTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(emailTextFieldContext).requestFocus(emailTextFieldFocus);
      return;
    }

    FocusScope.of(verificationCodeTextFieldContext)
        .requestFocus(verificationCodeTextFieldFocus);

    sendVerificationEmail();
  }

  // (검증 코드 입력창에서 엔터를 친 경우)
  void onVerificationCodeFieldSubmitted() {
    if (verificationCodeTextFieldController.text.trim() == "") {
      verificationCodeTextFieldErrorMsg = "본인 인증 코드를 입력하세요.";
      verificationCodeTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(verificationCodeTextFieldContext)
          .requestFocus(verificationCodeTextFieldFocus);
      return;
    }

    findPassword();
  }

  // (인증 이메일 발송)
  bool isSendVerificationEmailClicked = false;

  void sendVerificationEmail() async {
    if (isSendVerificationEmailClicked) {
      return;
    }
    isSendVerificationEmailClicked = true;

    emailTextFieldErrorMsg = null;
    verificationCodeTextFieldErrorMsg = null;
    emailTextFieldAreaGk.currentState?.refreshUi();
    verificationCodeTextFieldAreaGk.currentState?.refreshUi();

    var email = emailTextFieldController.text.trim();
    if (email == "") {
      emailTextFieldErrorMsg = "이메일을 입력하세요.";
      emailTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(emailTextFieldContext).requestFocus(emailTextFieldFocus);
      isSendVerificationEmailClicked = false;
      return;
    }

    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$')
        .hasMatch(email)) {
      emailTextFieldErrorMsg = "올바른 이메일 형식이 아닙니다.";
      emailTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(emailTextFieldContext).requestFocus(emailTextFieldFocus);
      isSendVerificationEmailClicked = false;
      return;
    }

    isSendVerificationEmailClicked = false;

    // (로딩 스피너 다이얼로그 호출)
    GlobalKey<all_dialog_loading_spinner.MainWidgetState>
        allDialogLoadingSpinnerStateGk = GlobalKey();

    showDialog(
        barrierDismissible: false,
        context: mainContext,
        builder: (context) => all_dialog_loading_spinner.MainWidget(
              key: allDialogLoadingSpinnerStateGk,
              inputVo:
                  all_dialog_loading_spinner.InputVo(onDialogCreated: () async {
                // 비번 찾기 검증 요청
                var responseVo = await api_main_server
                    .postService1TkV1AuthFindPasswordEmailVerificationAsync(
                        requestBodyVo: api_main_server
                            .PostService1TkV1AuthFindPasswordEmailVerificationAsyncRequestBodyVo(
                                email: email));

                if (responseVo.dioException == null) {
                  // Dio 네트워크 응답
                  allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                      .closeDialog();
                  var networkResponseObjectOk =
                      responseVo.networkResponseObjectOk!;

                  if (networkResponseObjectOk.responseStatusCode == 200) {
                    var networkResponseObjectBody = networkResponseObjectOk
                            .responseBody as api_main_server
                        .PostService1TkV1AuthFindPasswordEmailVerificationAsyncResponseBodyVo;

                    // 정상 응답
                    emailVerificationUid =
                        networkResponseObjectBody.verificationUid;

                    if (!mainContext.mounted) return;
                    showToast(
                      "본인 인증 이메일 발송 완료",
                      context: mainContext,
                      position: StyledToastPosition.bottom,
                      animation: StyledToastAnimation.scale,
                    );
                  } else {
                    // 비정상 응답
                    var responseHeaders = networkResponseObjectOk
                            .responseHeaders! as api_main_server
                        .PostService1TkV1AuthFindPasswordEmailVerificationAsyncResponseHeaderVo;

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
                            // 가입되지 않은 회원
                            final GlobalKey<all_dialog_info.MainWidgetState>
                                allDialogInfoStateGk =
                                GlobalKey<all_dialog_info.MainWidgetState>();
                            if (!mainContext.mounted) return;
                            showDialog(
                                barrierDismissible: true,
                                context: mainContext,
                                builder: (context) =>
                                    all_dialog_info.MainWidget(
                                      key: allDialogInfoStateGk,
                                      inputVo: all_dialog_info.InputVo(
                                        dialogTitle: "인증 이메일 발송 실패",
                                        dialogContent: "가입되지 않은 이메일입니다.",
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
                  allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                      .closeDialog();
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

  // (비밀번호 찾기)
  Future<void> findPassword() async {
    emailTextFieldErrorMsg = null;
    verificationCodeTextFieldErrorMsg = null;
    emailTextFieldAreaGk.currentState?.refreshUi();
    verificationCodeTextFieldAreaGk.currentState?.refreshUi();

    if (emailVerificationUid == null) {
      showToast(
        "이메일 검증이 필요합니다.",
        context: mainContext,
        animation: StyledToastAnimation.scale,
      );
      FocusScope.of(emailTextFieldContext).requestFocus(emailTextFieldFocus);
      return;
    }

    var email = emailTextFieldController.text.trim();
    if (email == "") {
      emailTextFieldErrorMsg = "이메일을 입력하세요.";
      emailTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(emailTextFieldContext).requestFocus(emailTextFieldFocus);
      return;
    }

    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$')
        .hasMatch(email)) {
      emailTextFieldErrorMsg = "올바른 이메일 형식이 아닙니다.";
      emailTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(emailTextFieldContext).requestFocus(emailTextFieldFocus);
      return;
    }

    if (verificationCodeTextFieldController.text.trim() == "") {
      verificationCodeTextFieldErrorMsg = "본인 인증 코드를 입력하세요.";
      verificationCodeTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(verificationCodeTextFieldContext)
          .requestFocus(verificationCodeTextFieldFocus);
      return;
    }

    // (로딩 스피너 다이얼로그 호출)
    GlobalKey<all_dialog_loading_spinner.MainWidgetState>
        allDialogLoadingSpinnerStateGk = GlobalKey();

    showDialog(
        barrierDismissible: false,
        context: mainContext,
        builder: (context) => all_dialog_loading_spinner.MainWidget(
              key: allDialogLoadingSpinnerStateGk,
              inputVo:
                  all_dialog_loading_spinner.InputVo(onDialogCreated: () async {
                // 비번 찾기 검증 요청
                var responseVo = await api_main_server
                    .postService1TkV1AuthFindPasswordWithEmailAsync(
                        requestBodyVo: api_main_server
                            .PostService1TkV1AuthFindPasswordWithEmailAsyncRequestBodyVo(
                                email: email,
                                verificationUid: emailVerificationUid!,
                                verificationCode:
                                    verificationCodeTextFieldController.text));

                if (responseVo.dioException == null) {
                  // Dio 네트워크 응답
                  allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                      .closeDialog();
                  var networkResponseObjectOk =
                      responseVo.networkResponseObjectOk!;

                  if (networkResponseObjectOk.responseStatusCode == 200) {
                    // 정상 응답
                    final GlobalKey<all_dialog_info.MainWidgetState>
                        allDialogInfoStateGk =
                        GlobalKey<all_dialog_info.MainWidgetState>();
                    if (!mainContext.mounted) return;
                    await showDialog(
                        barrierDismissible: true,
                        context: mainContext,
                        builder: (context) => all_dialog_info.MainWidget(
                              key: allDialogInfoStateGk,
                              inputVo: all_dialog_info.InputVo(
                                dialogTitle: "비밀번호 찾기 완료",
                                dialogContent: "새로운 비밀번호가\n"
                                    "이메일로 전송되었습니다.\n"
                                    "($email)",
                                checkBtnTitle: "확인",
                                onDialogCreated: () {},
                              ),
                            ));

                    if (!mainContext.mounted) return;
                    mainContext.pop();
                  } else {
                    // 비정상 응답
                    var responseHeaders = networkResponseObjectOk
                            .responseHeaders! as api_main_server
                        .PostService1TkV1AuthFindPasswordWithEmailAsyncResponseHeaderVo;

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
                            // 이메일 검증 요청을 보낸 적 없음
                            final GlobalKey<all_dialog_info.MainWidgetState>
                                allDialogInfoStateGk =
                                GlobalKey<all_dialog_info.MainWidgetState>();
                            if (!mainContext.mounted) return;
                            showDialog(
                                barrierDismissible: true,
                                context: mainContext,
                                builder: (context) =>
                                    all_dialog_info.MainWidget(
                                      key: allDialogInfoStateGk,
                                      inputVo: all_dialog_info.InputVo(
                                        dialogTitle: "비밀번호 찾기 실패",
                                        dialogContent: "이메일 검증 요청을 보내지 않았습니다.\n"
                                            "이메일 발송 버튼을 누르세요.",
                                        checkBtnTitle: "확인",
                                        onDialogCreated: () {},
                                      ),
                                    ));
                          }
                          break;
                        case "2":
                          {
                            // 이메일 검증 요청이 만료됨
                            final GlobalKey<all_dialog_info.MainWidgetState>
                                allDialogInfoStateGk =
                                GlobalKey<all_dialog_info.MainWidgetState>();
                            if (!mainContext.mounted) return;
                            showDialog(
                                barrierDismissible: true,
                                context: mainContext,
                                builder: (context) =>
                                    all_dialog_info.MainWidget(
                                      key: allDialogInfoStateGk,
                                      inputVo: all_dialog_info.InputVo(
                                        dialogTitle: "비밀번호 찾기 실패",
                                        dialogContent: "이메일 검증 요청이 만료되었습니다.",
                                        checkBtnTitle: "확인",
                                        onDialogCreated: () {},
                                      ),
                                    ));
                          }
                          break;
                        case "3":
                          {
                            // verificationCode 가 일치하지 않음
                            final GlobalKey<all_dialog_info.MainWidgetState>
                                allDialogInfoStateGk =
                                GlobalKey<all_dialog_info.MainWidgetState>();
                            if (!mainContext.mounted) return;
                            showDialog(
                                barrierDismissible: true,
                                context: mainContext,
                                builder: (context) =>
                                    all_dialog_info.MainWidget(
                                      key: allDialogInfoStateGk,
                                      inputVo: all_dialog_info.InputVo(
                                        dialogTitle: "비밀번호 찾기 실패",
                                        dialogContent: "본인 인증 코드가 일치하지 않습니다.",
                                        checkBtnTitle: "확인",
                                        onDialogCreated: () {},
                                      ),
                                    ));
                          }
                          break;
                        case "4":
                          {
                            // 탈퇴한 회원입니다.
                            final GlobalKey<all_dialog_info.MainWidgetState>
                                allDialogInfoStateGk =
                                GlobalKey<all_dialog_info.MainWidgetState>();
                            if (!mainContext.mounted) return;
                            showDialog(
                                barrierDismissible: true,
                                context: mainContext,
                                builder: (context) =>
                                    all_dialog_info.MainWidget(
                                      key: allDialogInfoStateGk,
                                      inputVo: all_dialog_info.InputVo(
                                        dialogTitle: "비밀번호 찾기 실패",
                                        dialogContent: "탈퇴된 이메일입니다.",
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
                  allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                      .closeDialog();
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

  // [private 함수]
  void _doNothing() {}
}
