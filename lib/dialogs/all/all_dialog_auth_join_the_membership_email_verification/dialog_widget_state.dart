// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// (inner Folder)
import 'dialog_widget.dart' as dialog_widget;

// (all)
import '../../../../repositories/network/apis/api_main_server.dart'
    as api_main_server;
import '../../../../repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;
import '../../../dialogs/all/all_dialog_info/dialog_widget.dart'
    as all_dialog_info;
import '../../../dialogs/all/all_dialog_info/dialog_widget_state.dart'
    as all_dialog_info_state;
import '../../../dialogs/all/all_dialog_loading_spinner/dialog_widget.dart'
    as all_dialog_loading_spinner;
import '../../../dialogs/all/all_dialog_loading_spinner/dialog_widget_state.dart'
    as all_dialog_loading_spinner_state;
import '../../../global_widgets/gw_text_form_field_wrapper/sf_widget_state.dart'
    as gw_text_form_field_wrapper_state;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// -----------------------------------------------------------------------------
class DialogWidgetState extends State<dialog_widget.DialogWidget>
    with WidgetsBindingObserver {
  DialogWidgetState();

  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {
          if (needInitState) {
            needInitState = false;
            widget.onDialogCreated();
          }

          // !!!생명주기 처리!!!
          // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
          spw_auth_member_info.SharedPreferenceWrapperVo? nowLoginMemberInfo =
              gf_my_functions.getNowVerifiedMemberInfo();

          if (nowLoginMemberInfo != null) {
            // 로그인 상태라면 다이얼로그 닫기
            context.pop();
            return;
          }
        },
        onFocusLost: () async {
          // !!!생명주기 처리!!!
        },
        onVisibilityGained: () async {
          // !!!생명주기 처리!!!
        },
        onVisibilityLost: () async {
          // !!!생명주기 처리!!!
        },
        onForegroundGained: () async {
          // !!!생명주기 처리!!!
        },
        onForegroundLost: () async {
          // !!!생명주기 처리!!!
        },
        child: widget.widgetUiBuild(context: context, currentState: this),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    widget.onDialogCreated();
    // !!!initState 작성!!!

    verificationUid = widget.inputVo.verificationUid;
  }

  @override
  void dispose() {
    // !!!dispose 작성!!!
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // [public 변수]
  // (최초 실행 플래그)
  bool needInitState = true;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  late int verificationUid;

  // VerificationCode Form 필드 관련 전체 키
  final GlobalKey<gw_text_form_field_wrapper_state.SfWidgetState>
      gwTextFormFieldWrapperStateGk = GlobalKey();

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }

  // (다이얼로그 종료 함수)
  void closeDialog() {
    context.pop();
  }

  String? onVerificationCodeInputValidateAndReturnErrorMsg(String? value) {
    // 검사 : return 으로 반환하는 에러 메세지가 null 이 아니라면 에러로 처리
    if (value == null || value.isEmpty) {
      return "이 항목을 입력 하세요.";
    } else {
      return null;
    }
  }

  // (코드 검증 후 다음 단계로 이동)
  bool isVerifyCodeAndGoNextDoing = false;

  void verifyCodeAndGoNext() async {
    if (isVerifyCodeAndGoNextDoing) {
      return;
    }
    isVerifyCodeAndGoNextDoing = true;
    if (gwTextFormFieldWrapperStateGk.currentState != null &&
        gwTextFormFieldWrapperStateGk.currentState?.validate() == null) {
      // 코드 검증
      // (로딩 스피너 다이얼로그 호출)
      GlobalKey<all_dialog_loading_spinner_state.DialogWidgetState>
          allDialogLoadingSpinnerStateGk = GlobalKey();

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => all_dialog_loading_spinner.DialogWidget(
              globalKey: allDialogLoadingSpinnerStateGk,
              inputVo: const all_dialog_loading_spinner.InputVo(),
              onDialogCreated: () {})).then((outputVo) {});

      var responseVo = await api_main_server
          .getService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsync(
              requestQueryVo: api_main_server
                  .GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncRequestQueryVo(
                      verificationUid: verificationUid,
                      email: widget.inputVo.emailAddress,
                      verificationCode: gwTextFormFieldWrapperStateGk
                          .currentState!
                          .getInputValue()));

      if (responseVo.dioException == null) {
        // Dio 네트워크 응답
        allDialogLoadingSpinnerStateGk.currentState?.closeDialog();
        var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

        if (networkResponseObjectOk.responseStatusCode == 200) {
          // 정상 응답

          // 검증 완료
          if (!context.mounted) return;
          context.pop(dialog_widget.OutputVo(
              checkedVerificationCode:
                  gwTextFormFieldWrapperStateGk.currentState!.getInputValue()));
        } else {
          var responseHeaders = networkResponseObjectOk.responseHeaders
              as api_main_server
              .GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncResponseHeaderVo;

          // 비정상 응답
          if (responseHeaders.apiResultCode == null) {
            // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
            final GlobalKey<all_dialog_info_state.DialogWidgetState>
                allDialogInfoGk = GlobalKey();
            if (!context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) => all_dialog_info.DialogWidget(
                      globalKey: allDialogInfoGk,
                      inputVo: const all_dialog_info.InputVo(
                          dialogTitle: "네트워크 에러",
                          dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                          checkBtnTitle: "확인"),
                      onDialogCreated: () {},
                    ));
          } else {
            // 서버 지정 에러 코드를 전달 받았을 때
            String apiResultCode = responseHeaders.apiResultCode!;

            switch (apiResultCode) {
              case "1":
                {
                  // 이메일 검증 요청을 보낸 적 없음
                  final GlobalKey<all_dialog_info_state.DialogWidgetState>
                      allDialogInfoGk = GlobalKey();
                  if (!context.mounted) return;
                  await showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) => all_dialog_info.DialogWidget(
                            globalKey: allDialogInfoGk,
                            inputVo: const all_dialog_info.InputVo(
                                dialogTitle: "본인 인증 코드 검증 실패",
                                dialogContent:
                                    "본인 인증 요청 정보가 없습니다.\n본인 인증 코드 재전송 버튼을 눌러주세요.",
                                checkBtnTitle: "확인"),
                            onDialogCreated: () {},
                          ));
                }
                break;
              case "2":
                {
                  // 이메일 검증 요청이 만료됨
                  final GlobalKey<all_dialog_info_state.DialogWidgetState>
                      allDialogInfoGk = GlobalKey();
                  if (!context.mounted) return;
                  await showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) => all_dialog_info.DialogWidget(
                            globalKey: allDialogInfoGk,
                            inputVo: const all_dialog_info.InputVo(
                                dialogTitle: "본인 인증 코드 검증 실패",
                                dialogContent:
                                    "본인 인증 요청 정보가 만료되었습니다.\n본인 인증 코드 재전송 버튼을 눌러주세요.",
                                checkBtnTitle: "확인"),
                            onDialogCreated: () {},
                          ));
                }
                break;
              case "3":
                {
                  // verificationCode 가 일치하지 않음

                  // 검증 실패
                  gwTextFormFieldWrapperStateGk
                      .currentState!.textFieldErrorMsg = "본인 인증 코드가 일치하지 않습니다.";
                  gwTextFormFieldWrapperStateGk.currentState!.refreshUi();
                  gwTextFormFieldWrapperStateGk.currentState!.requestFocus();
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
        allDialogLoadingSpinnerStateGk.currentState?.closeDialog();
        final GlobalKey<all_dialog_info_state.DialogWidgetState>
            allDialogInfoGk = GlobalKey();
        if (!context.mounted) return;
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) => all_dialog_info.DialogWidget(
                  globalKey: allDialogInfoGk,
                  inputVo: const all_dialog_info.InputVo(
                      dialogTitle: "네트워크 에러",
                      dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                      checkBtnTitle: "확인"),
                  onDialogCreated: () {},
                ));
      }

      isVerifyCodeAndGoNextDoing = false;
    } else {
      isVerifyCodeAndGoNextDoing = false;
    }
  }

  // (검증 이메일 다시 전송)
  Future<void> resendVerificationEmail() async {
    // 입력값 검증 완료
    // (로딩 스피너 다이얼로그 호출)
    GlobalKey<all_dialog_loading_spinner_state.DialogWidgetState>
        allDialogLoadingSpinnerStateGk = GlobalKey();

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => all_dialog_loading_spinner.DialogWidget(
            globalKey: allDialogLoadingSpinnerStateGk,
            inputVo: const all_dialog_loading_spinner.InputVo(),
            onDialogCreated: () {})).then((outputVo) {});

    var responseVo = await api_main_server
        .postService1TkV1AuthJoinTheMembershipEmailVerificationAsync(
            requestBodyVo: api_main_server
                .PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncRequestBodyVo(
                    email: widget.inputVo.emailAddress));

    if (responseVo.dioException == null) {
      // Dio 네트워크 응답
      allDialogLoadingSpinnerStateGk.currentState?.closeDialog();
      var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

      if (networkResponseObjectOk.responseStatusCode == 200) {
        var responseBody = networkResponseObjectOk.responseBody
            as api_main_server
            .PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseBodyVo;

        verificationUid = responseBody.verificationUid;

        // 정상 응답
        final GlobalKey<all_dialog_info_state.DialogWidgetState>
            allDialogInfoGk = GlobalKey();
        if (!context.mounted) return;
        await showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) => all_dialog_info.DialogWidget(
                  globalKey: allDialogInfoGk,
                  inputVo: all_dialog_info.InputVo(
                      dialogTitle: "이메일 재발송 성공",
                      dialogContent:
                          "본인 인증 이메일이 재발송 되었습니다.\n(${widget.inputVo.emailAddress})",
                      checkBtnTitle: "확인"),
                  onDialogCreated: () {},
                ));

        gwTextFormFieldWrapperStateGk.currentState?.requestFocus();
      } else {
        var responseHeaders = networkResponseObjectOk.responseHeaders
            as api_main_server
            .PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseHeaderVo;

        // 비정상 응답
        if (responseHeaders.apiResultCode == null) {
          // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
          final GlobalKey<all_dialog_info_state.DialogWidgetState>
              allDialogInfoGk = GlobalKey();
          if (!context.mounted) return;
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) => all_dialog_info.DialogWidget(
                    globalKey: allDialogInfoGk,
                    inputVo: const all_dialog_info.InputVo(
                        dialogTitle: "네트워크 에러",
                        dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                        checkBtnTitle: "확인"),
                    onDialogCreated: () {},
                  ));
        } else {
          // 서버 지정 에러 코드를 전달 받았을 때
          String apiResultCode = responseHeaders.apiResultCode!;

          switch (apiResultCode) {
            case "1":
              {
                // 기존 회원 존재
                final GlobalKey<all_dialog_info_state.DialogWidgetState>
                    allDialogInfoGk = GlobalKey();
                if (!context.mounted) return;
                await showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) => all_dialog_info.DialogWidget(
                          globalKey: allDialogInfoGk,
                          inputVo: const all_dialog_info.InputVo(
                              dialogTitle: "인증 이메일 발송 실패",
                              dialogContent: "이미 가입된 이메일입니다.",
                              checkBtnTitle: "확인"),
                          onDialogCreated: () {},
                        ));
                if (!context.mounted) return;
                context.pop();
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
      allDialogLoadingSpinnerStateGk.currentState?.closeDialog();
      final GlobalKey<all_dialog_info_state.DialogWidgetState> allDialogInfoGk =
          GlobalKey();
      if (!context.mounted) return;
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => all_dialog_info.DialogWidget(
                globalKey: allDialogInfoGk,
                inputVo: const all_dialog_info.InputVo(
                    dialogTitle: "네트워크 에러",
                    dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                    checkBtnTitle: "확인"),
                onDialogCreated: () {},
              ));
    }
  }
}
