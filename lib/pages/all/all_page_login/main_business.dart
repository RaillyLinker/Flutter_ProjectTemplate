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
import 'package:flutter_project_template/repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import 'package:flutter_project_template/dialogs/all/all_dialog_info/main_widget.dart'
    as all_dialog_info;
import 'package:flutter_project_template/dialogs/all/all_dialog_loading_spinner/main_widget.dart'
    as all_dialog_loading_spinner;
import 'package:flutter_project_template/pages/all/all_page_find_password_with_email/main_widget.dart'
    as all_page_find_password_with_email;
import 'package:flutter_project_template/pages/all/all_page_join_the_membership_email_verification/main_widget.dart'
    as all_page_join_the_membership_email_verification;
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
    idTextFieldController.dispose();
    idTextFieldFocus.dispose();
    passwordTextFieldController.dispose();
    passwordTextFieldFocus.dispose();
  }

  // (시스템 밝기 설정 변경시 실행)
  void didChangePlatformBrightness() {
    // !!!didChangePlatformBrightness 로직 작성!!!
  }

  // (시스템 언어/국가 설정 변경시 실행)
  void didChangeLocales() {
    // !!!didChangeLocales 로직 작성!!!
  }

  // (화면 크기 변경시 실행)
  void didChangeMetrics() {
    // !!!didChangeMetrics 로직 작성!!!
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

  // (페이지 설정 정보)
  // onCreate, onFocusGainedAsync, didChangePlatformBrightness, didChangeLocales 실행 직전 마다 갱신됨
  // 페이지 국가 설정 (KR, US, Jpan, ...)
  // WidgetsBinding.instance.platformDispatcher.locale.countryCode 에서 나오는 값
  late String? countrySetting;

  // 페이지 언어 설정 (ko, en, jpa, ...)
  // WidgetsBinding.instance.platformDispatcher.locale.languageCode 에서 나오는 값
  late String languageSetting;

  // 페이지 밝기 모드 설정 (dark, light)
  late String brightnessModeSetting;

  // 화면 너비
  late double screenWidth;

  // 화면 높이
  late double screenHeight;

  // (pageOutFrameBusiness)
  final gw_slw_page_outer_frame.SlwPageOuterFrameBusiness pageOutFrameBusiness =
      gw_slw_page_outer_frame.SlwPageOuterFrameBusiness();

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> idTextFieldAreaGk =
      GlobalKey();
  late BuildContext idTextFieldContext;
  final TextEditingController idTextFieldController = TextEditingController();
  final FocusNode idTextFieldFocus = FocusNode();
  String? idTextFieldErrorMsg;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState>
      passwordTextFieldAreaGk = GlobalKey();
  late BuildContext passwordTextFieldContext;
  final TextEditingController passwordTextFieldController =
      TextEditingController();
  final FocusNode passwordTextFieldFocus = FocusNode();
  String? passwordTextFieldErrorMsg;
  bool passwordTextFieldHide = true;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!비즈니스 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (메인 위젯 화면 갱신)
  late VoidCallback refreshUi;

  // (ID 입력창에서 엔터를 쳤을 때)
  void onIdFieldSubmitted() {
    String id = idTextFieldController.text;

    if (id.trim() == "") {
      // 이메일 미입력 처리
      // 입력창에 Focus 주기
      FocusScope.of(idTextFieldContext).requestFocus(idTextFieldFocus);
      showToast(
        "이메일을 입력하세요.",
        context: mainContext,
        animation: StyledToastAnimation.scale,
      );
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$')
        .hasMatch(id)) {
      // 이메일 형식 맞지 않음

      // 입력창에 Focus 주기
      FocusScope.of(idTextFieldContext).requestFocus(idTextFieldFocus);
      showToast(
        "이메일 형식이 아닙니다.",
        context: mainContext,
        animation: StyledToastAnimation.scale,
      );
    } else {
      FocusScope.of(passwordTextFieldContext)
          .requestFocus(passwordTextFieldFocus);
    }
  }

  // (Password 입력창에서 엔터를 쳤을 때)
  void onPasswordFieldSubmitted() {
    String id = idTextFieldController.text;
    String pw = passwordTextFieldController.text;

    if (id.trim() == "") {
      // 이메일 미입력 처리
      // 입력창에 Focus 주기
      FocusScope.of(idTextFieldContext).requestFocus(idTextFieldFocus);
      showToast(
        "이메일을 입력하세요.",
        context: mainContext,
        animation: StyledToastAnimation.scale,
      );
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$')
        .hasMatch(id)) {
      // 이메일 형식 맞지 않음

      // 입력창에 Focus 주기
      FocusScope.of(idTextFieldContext).requestFocus(idTextFieldFocus);
      showToast(
        "이메일 형식이 아닙니다.",
        context: mainContext,
        animation: StyledToastAnimation.scale,
      );
    } else if (pw.trim() == "") {
      // 입력창에 Focus 주기
      FocusScope.of(passwordTextFieldContext)
          .requestFocus(passwordTextFieldFocus);
      showToast(
        "비밀번호를 입력하세요.",
        context: mainContext,
        animation: StyledToastAnimation.scale,
      );
    } else {
      accountLoginAsync();
    }
  }

  // (계정 로그인 버튼 클릭)
  bool accountLoginAsyncClicked = false;

  void accountLoginAsync() {
    if (accountLoginAsyncClicked) {
      return;
    }
    accountLoginAsyncClicked = true;

    String id = idTextFieldController.text;
    String password = passwordTextFieldController.text;

    if (id.trim() == "") {
      // 이메일 미입력 처리
      // 입력창에 Focus 주기
      FocusScope.of(idTextFieldContext).requestFocus(idTextFieldFocus);
      showToast(
        "이메일을 입력하세요.",
        context: mainContext,
        animation: StyledToastAnimation.scale,
      );
      accountLoginAsyncClicked = false;
      return;
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$')
        .hasMatch(id)) {
      // 이메일 형식 맞지 않음

      // 입력창에 Focus 주기
      FocusScope.of(idTextFieldContext).requestFocus(idTextFieldFocus);
      showToast(
        "이메일 형식이 아닙니다.",
        context: mainContext,
        animation: StyledToastAnimation.scale,
      );
      accountLoginAsyncClicked = false;
      return;
    } else if (password.trim() == "") {
      // 입력창에 Focus 주기
      FocusScope.of(passwordTextFieldContext)
          .requestFocus(passwordTextFieldFocus);
      showToast(
        "비밀번호를 입력하세요.",
        context: mainContext,
        animation: StyledToastAnimation.scale,
      );
      accountLoginAsyncClicked = false;
      return;
    }

    GlobalKey<all_dialog_loading_spinner.MainWidgetState>
        allDialogLoadingSpinnerStateGk = GlobalKey();

    showDialog(
      barrierDismissible: false,
      context: mainContext,
      builder: (context) => all_dialog_loading_spinner.MainWidget(
        key: allDialogLoadingSpinnerStateGk,
        inputVo: all_dialog_loading_spinner.InputVo(
          onDialogCreated: () async {
            // 네트워크 요청
            var responseVo = await api_main_server
                .postService1TkV1AuthLoginWithPasswordAsync(
                    requestBodyVo: api_main_server
                        .PostService1TkV1AuthLoginWithPasswordAsyncRequestBodyVo(
                            loginTypeCode: 1, id: id, password: password));

            allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                .closeDialog();

            if (responseVo.dioException == null) {
              // Dio 네트워크 응답
              var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

              if (networkResponseObjectOk.responseStatusCode == 200) {
                // 정상 응답
                var responseBody = responseVo.networkResponseObjectOk!
                        .responseBody! as api_main_server
                    .PostService1TkV1AuthLoginWithPasswordAsyncResponseBodyVo;

                List<spw_auth_member_info.SharedPreferenceWrapperVoOAuth2Info>
                    myOAuth2ObjectList = [];
                for (var myOAuth2 in responseBody.myOAuth2List) {
                  myOAuth2ObjectList.add(
                      spw_auth_member_info.SharedPreferenceWrapperVoOAuth2Info(
                    myOAuth2.uid,
                    myOAuth2.oauth2TypeCode,
                    myOAuth2.oauth2Id,
                  ));
                }

                List<spw_auth_member_info.SharedPreferenceWrapperVoProfileInfo>
                    myProfileObjectList = [];
                for (var myProfile in responseBody.myProfileList) {
                  myProfileObjectList.add(
                      spw_auth_member_info.SharedPreferenceWrapperVoProfileInfo(
                    myProfile.uid,
                    myProfile.imageFullUrl,
                    myProfile.isFront,
                  ));
                }

                List<spw_auth_member_info.SharedPreferenceWrapperVoEmailInfo>
                    myEmailList = [];
                for (var myProfile in responseBody.myEmailList) {
                  myEmailList.add(
                      spw_auth_member_info.SharedPreferenceWrapperVoEmailInfo(
                    uid: myProfile.uid,
                    emailAddress: myProfile.emailAddress,
                    isFront: myProfile.isFront,
                  ));
                }

                List<spw_auth_member_info.SharedPreferenceWrapperVoPhoneInfo>
                    myPhoneNumberList = [];
                for (var myProfile in responseBody.myPhoneNumberList) {
                  myPhoneNumberList.add(
                      spw_auth_member_info.SharedPreferenceWrapperVoPhoneInfo(
                    uid: myProfile.uid,
                    phoneNumber: myProfile.phoneNumber,
                    isFront: myProfile.isFront,
                  ));
                }

                spw_auth_member_info.SharedPreferenceWrapper.set(
                    value: spw_auth_member_info.SharedPreferenceWrapperVo(
                  responseBody.memberUid,
                  responseBody.nickName,
                  responseBody.roleList,
                  responseBody.tokenType,
                  responseBody.accessToken,
                  responseBody.accessTokenExpireWhen,
                  responseBody.refreshToken,
                  responseBody.refreshTokenExpireWhen,
                  myOAuth2ObjectList,
                  myProfileObjectList,
                  myEmailList,
                  myPhoneNumberList,
                  responseBody.authPasswordIsNull,
                ));

                accountLoginAsyncClicked = false;
                if (!mainContext.mounted) return;
                if (mainContext.canPop()) {
                  // pop 이 가능하면 pop
                  mainContext.pop();
                } else {
                  // pop 이 불가능하면 Home 페이지로 이동
                  mainContext.goNamed(all_page_home.pageName);
                }
              } else {
                // 비정상 응답
                var responseHeaderVo = networkResponseObjectOk.responseHeaders
                    as api_main_server
                    .PostService1TkV1AuthLoginWithPasswordAsyncResponseHeaderVo;

                switch (responseHeaderVo.apiResultCode) {
                  case "1":
                    {
                      // 가입 되지 않은 회원
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
                                  dialogTitle: "로그인 실패",
                                  dialogContent: "가입되지 않은 회원입니다.",
                                  checkBtnTitle: "확인",
                                  onDialogCreated: () {},
                                ),
                              ));
                      accountLoginAsyncClicked = false;
                    }
                    break;
                  case "2":
                    {
                      // 로그인 정보 검증 불일치
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
                                  dialogTitle: "로그인 실패",
                                  dialogContent: "비밀번호가 일치하지 않습니다.",
                                  checkBtnTitle: "확인",
                                  onDialogCreated: () {},
                                ),
                              ));
                      accountLoginAsyncClicked = false;
                    }
                    break;
                  default:
                    {
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
                      accountLoginAsyncClicked = false;
                    }
                }
              }
            } else {
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
              accountLoginAsyncClicked = false;
            }
          },
        ),
      ),
    );
  }

  // (비밀번호 찾기 페이지 이동)
  void goToFindPasswordPage() {
    // 이메일 본인 검증 화면으로 이동
    mainContext.pushNamed(all_page_find_password_with_email.pageName);
  }

  // (회원가입 종류 선택)
  void selectRegisterWith() {
    // 이메일 본인 검증 화면으로 이동
    mainContext
        .pushNamed(all_page_join_the_membership_email_verification.pageName);
  }

  // [private 함수]
  void _doNothing() {}
}
