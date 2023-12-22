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
import 'package:flutter_project_template/dialogs/all/all_dialog_auth_join_the_membership_email_verification/main_widget.dart'
    as all_dialog_auth_join_the_membership_email_verification;
import 'package:flutter_project_template/dialogs/all/all_dialog_info/main_widget.dart'
    as all_dialog_info;
import 'package:flutter_project_template/dialogs/all/all_dialog_loading_spinner/main_widget.dart'
    as all_dialog_loading_spinner;
import 'package:flutter_project_template/pages/all/all_page_join_the_membership_edit_member_info/main_widget.dart'
    as all_page_join_the_membership_edit_member_info;
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
    passwordTextFieldController.dispose();
    passwordTextFieldFocus.dispose();
    passwordCheckTextFieldController.dispose();
    passwordCheckTextFieldFocus.dispose();
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
  bool emailTextEditEnabled = true;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState>
      passwordTextFieldAreaGk = GlobalKey();
  late BuildContext passwordTextFieldContext;
  final TextEditingController passwordTextFieldController =
      TextEditingController();
  final FocusNode passwordTextFieldFocus = FocusNode();
  String? passwordTextFieldErrorMsg;
  bool passwordTextFieldHide = true;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState>
      passwordCheckTextFieldAreaGk = GlobalKey();
  late BuildContext passwordCheckTextFieldContext;
  final TextEditingController passwordCheckTextFieldController =
      TextEditingController();
  final FocusNode passwordCheckTextFieldFocus = FocusNode();
  String? passwordCheckTextFieldErrorMsg;
  bool passwordCheckTextFieldHide = true;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState>
      passwordInputRuleHideAreaGk = GlobalKey();
  late BuildContext passwordInputRuleHideContext;
  bool passwordInputRuleHide = true;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> emailCheckBtnAreaGk =
      GlobalKey();
  late BuildContext emailCheckBtnContext;
  String emailCheckBtn = "이메일\n발송";

  int? verificationUid;
  String? checkedEmailVerificationCode;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!비즈니스 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (메인 위젯 화면 갱신)
  late VoidCallback refreshUi;

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

    FocusScope.of(passwordTextFieldContext)
        .requestFocus(passwordTextFieldFocus);

    onEmailBtnClick();
  }

  // (이메일 체크 버튼 클릭)
  bool isSendVerificationEmailClicked = false;

  void onEmailBtnClick() {
    if (emailTextEditEnabled) {
      // 이메일 입력 활성화 상태 (= 아직 이메일 확인하지 않은 상태)
      if (isSendVerificationEmailClicked) {
        return;
      }
      isSendVerificationEmailClicked = true;

      emailTextFieldErrorMsg = null;
      emailTextFieldAreaGk.currentState?.refreshUi();

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

      // 입력값 검증 완료
      // (로딩 스피너 다이얼로그 호출)
      GlobalKey<all_dialog_loading_spinner.MainWidgetState>
          allDialogLoadingSpinnerStateGk = GlobalKey();

      showDialog(
          barrierDismissible: false,
          context: mainContext,
          builder: (context) => all_dialog_loading_spinner.MainWidget(
                key: allDialogLoadingSpinnerStateGk,
                inputVo: all_dialog_loading_spinner.InputVo(
                    onDialogCreated: () async {
                  var responseVo = await api_main_server
                      .postService1TkV1AuthJoinTheMembershipEmailVerificationAsync(
                          requestBodyVo: api_main_server
                              .PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncRequestBodyVo(
                                  email: email));

                  if (responseVo.dioException == null) {
                    // Dio 네트워크 응답
                    allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                        .closeDialog();
                    var networkResponseObjectOk =
                        responseVo.networkResponseObjectOk!;

                    if (networkResponseObjectOk.responseStatusCode == 200) {
                      var responseBody = networkResponseObjectOk.responseBody
                          as api_main_server
                          .PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseBodyVo;

                      // 정상 응답
                      // 검증번호 입력 다이얼로그 띄우기
                      final GlobalKey<
                              all_dialog_auth_join_the_membership_email_verification
                              .MainWidgetState>
                          allDialogAuthJoinTheMembershipEmailVerificationAreaGk =
                          GlobalKey();
                      if (!mainContext.mounted) return;
                      var dialogResult = await showDialog(
                          barrierDismissible: false,
                          context: mainContext,
                          builder: (context) =>
                              all_dialog_auth_join_the_membership_email_verification
                                  .MainWidget(
                                key:
                                    allDialogAuthJoinTheMembershipEmailVerificationAreaGk,
                                inputVo:
                                    all_dialog_auth_join_the_membership_email_verification
                                        .InputVo(
                                  emailAddress: email,
                                  verificationUid: responseBody.verificationUid,
                                  onDialogCreated: () {},
                                ),
                              ));

                      if (dialogResult != null) {
                        verificationUid = dialogResult.verificationUid;
                        checkedEmailVerificationCode =
                            dialogResult.checkedVerificationCode;
                        emailTextEditEnabled = false;
                        emailTextFieldAreaGk.currentState?.refreshUi();

                        emailCheckBtn = "인증\n초기화";
                        emailCheckBtnAreaGk.currentState?.refreshUi();
                      }
                    } else {
                      // 비정상 응답
                      var responseHeaders = networkResponseObjectOk
                              .responseHeaders! as api_main_server
                          .PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseHeaderVo;

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
                                    dialogContent:
                                        "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
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
                              // 기존 회원 존재
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
                                          dialogContent: "이미 가입된 이메일입니다.",
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
    } else {
      // 이메일 입력 비활성화 상태 (= 이메일 확인한 상태)
      emailTextEditEnabled = true;
      emailTextFieldErrorMsg = null;
      emailTextFieldAreaGk.currentState?.refreshUi();

      emailCheckBtn = "이메일\n발송";
      emailCheckBtnAreaGk.currentState?.refreshUi();
    }
  }

  // (패스워드 입력창에서 엔터를 친 경우)
  void onPasswordFieldSubmitted() {
    if (passwordTextFieldController.text == "") {
      passwordTextFieldErrorMsg = "비밀번호를 입력하세요.";
      passwordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(passwordTextFieldContext)
          .requestFocus(passwordTextFieldFocus);
      return;
    }

    if (passwordTextFieldController.text.contains(" ")) {
      passwordTextFieldErrorMsg = "비밀번호에 공백은 허용되지 않습니다.";
      passwordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(passwordTextFieldContext)
          .requestFocus(passwordTextFieldFocus);
      return;
    }

    if (passwordTextFieldController.text.length < 8) {
      passwordTextFieldErrorMsg = "비밀번호는 최소 8자 이상 입력하세요.";
      passwordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(passwordTextFieldContext)
          .requestFocus(passwordTextFieldFocus);
      return;
    }

    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$&*])')
        .hasMatch(passwordTextFieldController.text)) {
      passwordTextFieldErrorMsg = "비밀번호는 영문 대/소문자, 숫자, 그리고 특수문자의 조합을 입력하세요.";
      passwordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(passwordTextFieldContext)
          .requestFocus(passwordTextFieldFocus);
      return;
    }

    if (RegExp(r'[<>()#’/|]').hasMatch(passwordTextFieldController.text)) {
      passwordTextFieldErrorMsg = "특수문자 < > ( ) # ’ / | 는 사용할 수 없습니다.";
      passwordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(passwordTextFieldContext)
          .requestFocus(passwordTextFieldFocus);
      return;
    }

    FocusScope.of(passwordCheckTextFieldContext)
        .requestFocus(passwordCheckTextFieldFocus);
  }

  // (회원가입 다음 단계로 이동)
  Future<void> goToNextStep() async {
    emailTextFieldErrorMsg = null;
    passwordTextFieldErrorMsg = null;
    passwordCheckTextFieldErrorMsg = null;
    emailTextFieldAreaGk.currentState?.refreshUi();
    passwordTextFieldAreaGk.currentState?.refreshUi();
    passwordCheckTextFieldAreaGk.currentState?.refreshUi();

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

    if (passwordTextFieldController.text == "") {
      passwordTextFieldErrorMsg = "비밀번호를 입력하세요.";
      passwordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(passwordTextFieldContext)
          .requestFocus(passwordTextFieldFocus);
      return;
    }

    if (passwordTextFieldController.text.contains(" ")) {
      passwordTextFieldErrorMsg = "비밀번호에 공백은 허용되지 않습니다.";
      passwordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(passwordTextFieldContext)
          .requestFocus(passwordTextFieldFocus);
      return;
    }

    if (passwordTextFieldController.text.length < 8) {
      passwordTextFieldErrorMsg = "비밀번호는 최소 8자 이상 입력하세요.";
      passwordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(passwordTextFieldContext)
          .requestFocus(passwordTextFieldFocus);
      return;
    }

    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$&*])')
        .hasMatch(passwordTextFieldController.text)) {
      passwordTextFieldErrorMsg = "비밀번호는 영문 대/소문자, 숫자, 그리고 특수문자의 조합을 입력하세요.";
      passwordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(passwordTextFieldContext)
          .requestFocus(passwordTextFieldFocus);
      return;
    }

    if (RegExp(r'[<>()#’/|]').hasMatch(passwordTextFieldController.text)) {
      passwordTextFieldErrorMsg = "특수문자 < > ( ) # ’ / | 는 사용할 수 없습니다.";
      passwordTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(passwordTextFieldContext)
          .requestFocus(passwordTextFieldFocus);
      return;
    }

    if (passwordCheckTextFieldController.text == "") {
      passwordCheckTextFieldErrorMsg = "비밀번호 확인을 입력하세요.";
      passwordCheckTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(passwordCheckTextFieldContext)
          .requestFocus(passwordCheckTextFieldFocus);
      return;
    }

    if (passwordCheckTextFieldController.text !=
        passwordTextFieldController.text) {
      passwordCheckTextFieldErrorMsg = "비밀번호와 일치하지 않습니다.";
      passwordCheckTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(passwordCheckTextFieldContext)
          .requestFocus(passwordCheckTextFieldFocus);
      return;
    }

    if (verificationUid == null ||
        checkedEmailVerificationCode == null ||
        emailTextEditEnabled) {
      showToast(
        "이메일 검증이 필요합니다.",
        context: mainContext,
        animation: StyledToastAnimation.scale,
      );
      FocusScope.of(emailTextFieldContext).requestFocus(emailTextFieldFocus);
      return;
    }

    // 필수 정보 입력 페이지로 이동
    // (전달할 파라미터들)
    // 계정 타입 (email, phoneNumber)
    // String? authType;
    // 비밀코드 (계정 타입 email, phoneNumber : 사용할 비밀번호,)
    // String? secretOpt;
    // 멤버 아이디 (계정 타입 email : 이메일(test@email.com), phoneNumber : 전화번호(82)010-0000-0000),)
    // String? memberIdOpt;
    // 계정 검증 단계에서 발행된 검증 코드
    // String? verificationCode;

    var pageResult = await mainContext.pushNamed(
        all_page_join_the_membership_edit_member_info.pageName,
        queryParameters: {
          "memberId": emailTextFieldController.text.trim(),
          "password": passwordTextFieldController.text,
          "verificationCode": checkedEmailVerificationCode,
          "verificationUid": verificationUid.toString(),
        });

    if (pageResult != null &&
        (pageResult as all_page_join_the_membership_edit_member_info.OutputVo)
            .registerComplete) {
      if (!mainContext.mounted) return;
      mainContext.pop();
    }
  }

  // 비밀번호 입력 규칙 클릭
  void onPasswordInputRuleTap() {
    passwordInputRuleHide = !passwordInputRuleHide;
    passwordInputRuleHideAreaGk.currentState?.refreshUi();
  }

  // [private 함수]
  void _doNothing() {}
}
