// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner_folder)
import 'main_widget.dart' as main_widget;

// (all)
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

// [위젯 비즈니스]

//------------------------------------------------------------------------------
class MainBusiness {
  // [CallBack 함수]
  // (진입 최초 단 한번 실행) - 아직 위젯이 생성 되기 전
  void initState() {
    // !!!initState 로직 작성!!!
    verificationUid = inputVo.verificationUid;
  }

  // (종료 시점 단 한번 실행)
  void dispose() {
    // !!!dispose 로직 작성!!!
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
    final spw_auth_member_info.SharedPreferenceWrapperVo? nowLoginMemberInfo =
        gf_my_functions.getNowVerifiedMemberInfo();

    if (nowLoginMemberInfo != null) {
      // 로그인 상태라면 닫기
      mainContext.pop();
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

  // (context 객체)
  late BuildContext mainContext;

  // (최초 실행 플래그)
  bool pageInitFirst = true;

  // (onDialogCreated 실행 플래그)
  bool needCallOnDialogCreated = true;

  // (검증 요청 고유번호)
  late int verificationUid;

  // 검증 코드 입력창 AreaGk
  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState>
      verificationCodeTextFieldAreaGk = GlobalKey();
  late BuildContext verificationCodeTextFieldContext;
  final TextEditingController verificationCodeTextFieldController =
      TextEditingController();
  final FocusNode verificationCodeTextFieldFocus = FocusNode();
  String? verificationCodeTextFieldErrorMsg;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!비즈니스 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (메인 위젯 화면 갱신)
  late VoidCallback refreshUi;

  // (다이얼로그 종료 함수)
  void closeDialog() {
    mainContext.pop();
  }

  // (검증 이메일 다시 전송)
  void resendVerificationEmail() {
    // 입력값 검증 완료
    // (로딩 스피너 다이얼로그 호출)
    final GlobalKey<all_dialog_loading_spinner.MainWidgetState>
        allDialogLoadingSpinnerStateGk = GlobalKey();

    showDialog(
        barrierDismissible: false,
        context: mainContext,
        builder: (context) => all_dialog_loading_spinner.MainWidget(
              key: allDialogLoadingSpinnerStateGk,
              inputVo:
                  all_dialog_loading_spinner.InputVo(onDialogCreated: () async {
                var responseVo = await api_main_server
                    .postService1TkV1AuthJoinTheMembershipEmailVerificationAsync(
                        requestBodyVo: api_main_server
                            .PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncRequestBodyVo(
                                email: inputVo.emailAddress));

                allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                    .closeDialog();

                if (responseVo.dioException == null) {
                  // Dio 네트워크 응답
                  var networkResponseObjectOk =
                      responseVo.networkResponseObjectOk!;

                  if (networkResponseObjectOk.responseStatusCode == 200) {
                    var responseBody = networkResponseObjectOk.responseBody
                        as api_main_server
                        .PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseBodyVo;

                    verificationUid = responseBody.verificationUid;

                    // 정상 응답
                    final GlobalKey<all_dialog_info.MainWidgetState>
                        allDialogInfoStateGk = GlobalKey();

                    if (!mainContext.mounted) return;
                    await showDialog(
                        barrierDismissible: true,
                        context: mainContext,
                        builder: (context) => all_dialog_info.MainWidget(
                              key: allDialogInfoStateGk,
                              inputVo: all_dialog_info.InputVo(
                                dialogTitle: "이메일 재발송 성공",
                                dialogContent:
                                    "본인 인증 이메일이 재발송 되었습니다.\n(${inputVo.emailAddress})",
                                checkBtnTitle: "확인",
                                onDialogCreated: () {},
                              ),
                            ));

                    if (!verificationCodeTextFieldContext.mounted) return;
                    verificationCodeTextFieldController.text = "";
                    verificationCodeTextFieldErrorMsg = null;
                    verificationCodeTextFieldAreaGk.currentState?.refreshUi();
                    FocusScope.of(verificationCodeTextFieldContext)
                        .requestFocus(verificationCodeTextFieldFocus);
                  } else {
                    var responseHeaders = networkResponseObjectOk
                            .responseHeaders as api_main_server
                        .PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseHeaderVo;

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
                            // 기존 회원 존재
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
                                        dialogTitle: "인증 이메일 발송 실패",
                                        dialogContent: "이미 가입된 이메일입니다.",
                                        checkBtnTitle: "확인",
                                        onDialogCreated: () {},
                                      ),
                                    ));
                            if (!mainContext.mounted) return;
                            mainContext.pop();
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

  // (코드 검증 후 다음 단계로 이동)
  bool isVerifyCodeAndGoNextDoing = false;

  void verifyCodeAndGoNext() {
    if (isVerifyCodeAndGoNextDoing) {
      return;
    }
    isVerifyCodeAndGoNextDoing = true;

    String? verificationCode = verificationCodeTextFieldController.text;

    if (verificationCode.isEmpty) {
      verificationCodeTextFieldErrorMsg = "이 항목을 입력 하세요.";
      verificationCodeTextFieldAreaGk.currentState?.refreshUi();
      FocusScope.of(verificationCodeTextFieldContext)
          .requestFocus(verificationCodeTextFieldFocus);
      isVerifyCodeAndGoNextDoing = false;
      return;
    }

    isVerifyCodeAndGoNextDoing = false;
    // 코드 검증
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
                var responseVo = await api_main_server
                    .getService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsync(
                        requestQueryVo: api_main_server
                            .GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncRequestQueryVo(
                                verificationUid: verificationUid,
                                email: inputVo.emailAddress,
                                verificationCode: verificationCode));

                allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                    .closeDialog();
                if (responseVo.dioException == null) {
                  // Dio 네트워크 응답
                  var networkResponseObjectOk =
                      responseVo.networkResponseObjectOk!;

                  if (networkResponseObjectOk.responseStatusCode == 200) {
                    // 정상 응답

                    // 검증 완료
                    if (!mainContext.mounted) return;
                    mainContext.pop(main_widget.OutputVo(
                        checkedVerificationCode: verificationCode,
                        verificationUid: verificationUid));
                  } else {
                    var responseHeaders = networkResponseObjectOk
                            .responseHeaders as api_main_server
                        .GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncResponseHeaderVo;

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
                            // 이메일 검증 요청을 보낸 적 없음
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
                                        dialogTitle: "본인 인증 코드 검증 실패",
                                        dialogContent:
                                            "본인 인증 요청 정보가 없습니다.\n본인 인증 코드 재전송 버튼을 눌러주세요.",
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
                            await showDialog(
                                barrierDismissible: true,
                                context: mainContext,
                                builder: (context) =>
                                    all_dialog_info.MainWidget(
                                      key: allDialogInfoStateGk,
                                      inputVo: all_dialog_info.InputVo(
                                        dialogTitle: "본인 인증 코드 검증 실패",
                                        dialogContent:
                                            "본인 인증 요청 정보가 만료되었습니다.\n본인 인증 코드 재전송 버튼을 눌러주세요.",
                                        checkBtnTitle: "확인",
                                        onDialogCreated: () {},
                                      ),
                                    ));
                          }
                          break;
                        case "3":
                          {
                            // verificationCode 가 일치하지 않음
                            // 검증 실패
                            verificationCodeTextFieldErrorMsg =
                                "본인 인증 코드가 일치하지 않습니다.";
                            verificationCodeTextFieldAreaGk.currentState
                                ?.refreshUi();
                            if (!verificationCodeTextFieldContext.mounted) {
                              return;
                            }
                            FocusScope.of(verificationCodeTextFieldContext)
                                .requestFocus(verificationCodeTextFieldFocus);
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
