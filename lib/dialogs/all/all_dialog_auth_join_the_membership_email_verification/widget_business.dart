// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// (inner Folder)
import 'widget_view.dart' as widget_view;

// (all)
import '../../../../repositories/network/apis/api_main_server.dart'
    as api_main_server;
import '../../../../repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;
import '../../../dialogs/all/all_dialog_info/widget_view.dart'
    as all_dialog_info_view;
import '../../../dialogs/all/all_dialog_info/widget_business.dart'
    as all_dialog_info_business;
import '../../../dialogs/all/all_dialog_loading_spinner/widget_view.dart'
    as all_dialog_loading_spinner_view;
import '../../../dialogs/all/all_dialog_loading_spinner/widget_business.dart'
    as all_dialog_loading_spinner_business;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class WidgetBusiness {
  // [콜백 함수]
  // (전체 위젯 처음 실행 콜백)
  void onCreated() {
    // !!!onCreated 로직 작성!!!

    verificationUid = inputVo.verificationUid;
  }

  // (전체 위젯 dispose)
  void dispose() {
    // !!!initState 로직 작성!!!
    verificationCodeTextFieldController.dispose();
    verificationCodeTextFieldFocus.dispose();
  }

  // (전체 위젯의 FocusDetector 콜백들)
  void onFocusGained() async {
    // !!!onFocusGained 로직 작성!!!

    // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
    spw_auth_member_info.SharedPreferenceWrapperVo? nowLoginMemberInfo =
        gf_my_functions.getNowVerifiedMemberInfo();

    if (nowLoginMemberInfo != null) {
      // 로그인 상태라면 다이얼로그 닫기
      context.pop();
      return;
    }
  }

  void onFocusLost() async {
    // !!!onFocusLost 로직 작성!!!
  }

  void onVisibilityGained() async {
    // !!!onFocusLost 로직 작성!!!
  }

  void onVisibilityLost() async {
    // !!!onVisibilityLost 로직 작성!!!
  }

  void onForegroundGained() async {
    // !!!onForegroundGained 로직 작성!!!
  }

  void onForegroundLost() async {
    // !!!onForegroundLost 로직 작성!!!
  }

  // [public 변수]
  // (초기화 여부)
  bool onPageCreated = false;

  // (위젯 Context)
  late BuildContext context;

  // (위젯 입력값)
  late widget_view.InputVo inputVo;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  late int verificationUid;

  // VerificationCode Form 필드 관련 전체 키
  final verificationCodeTextFieldKey = GlobalKey<FormFieldState>();
  final TextEditingController verificationCodeTextFieldController =
      TextEditingController();
  final FocusNode verificationCodeTextFieldFocus = FocusNode();
  String? verificationCodeTextFieldErrorMsg;

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  // (다이얼로그 종료 함수)
  void closeDialog() {
    context.pop();
  }

  void onVerificationCodeInputChanged(String? value) {
    if (verificationCodeTextFieldErrorMsg != null) {
      verificationCodeTextFieldErrorMsg = null;
      verificationCodeTextFieldKey.currentState?.reset();
    }
  }

  String? onVerificationCodeInputValidateAndReturnErrorMsg(String? value) {
    // 검사 : return 으로 반환하는 에러 메세지가 null 이 아니라면 에러로 처리
    if (value == null || value.isEmpty) {
      verificationCodeTextFieldErrorMsg = "이 항목을 입력 하세요.";
      return verificationCodeTextFieldErrorMsg;
    }
    return null;
  }

  // (코드 검증 후 다음 단계로 이동)
  bool isVerifyCodeAndGoNextDoing = false;

  void verifyCodeAndGoNext() async {
    if (isVerifyCodeAndGoNextDoing) {
      return;
    }
    isVerifyCodeAndGoNextDoing = true;
    if (verificationCodeTextFieldKey.currentState!.validate()) {
      // 코드 검증
      // (로딩 스피너 다이얼로그 호출)
      var allDialogLoadingSpinnerBusiness =
          all_dialog_loading_spinner_business.WidgetBusiness();

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => all_dialog_loading_spinner_view.WidgetView(
              business: allDialogLoadingSpinnerBusiness,
              inputVo: const all_dialog_loading_spinner_view.InputVo(),
              onDialogCreated: () {})).then((outputVo) {});

      var responseVo = await api_main_server
          .getService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsync(
              requestQueryVo: api_main_server
                  .GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncRequestQueryVo(
                      verificationUid: verificationUid,
                      email: inputVo.emailAddress,
                      verificationCode:
                          verificationCodeTextFieldController.text));

      if (responseVo.dioException == null) {
        // Dio 네트워크 응답
        allDialogLoadingSpinnerBusiness.closeDialog();
        var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

        if (networkResponseObjectOk.responseStatusCode == 200) {
          // 정상 응답

          // 검증 완료
          if (!context.mounted) return;
          context.pop(widget_view.OutputVo(
              checkedVerificationCode:
                  verificationCodeTextFieldController.text));
        } else {
          var responseHeaders = networkResponseObjectOk.responseHeaders
              as api_main_server
              .GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncResponseHeaderVo;

          // 비정상 응답
          if (responseHeaders.apiResultCode == null) {
            // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
            var allDialogInfoBusiness =
                all_dialog_info_business.WidgetBusiness();
            if (!context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) => all_dialog_info_view.WidgetView(
                      business: allDialogInfoBusiness,
                      inputVo: const all_dialog_info_view.InputVo(
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
                  var allDialogInfoBusiness =
                      all_dialog_info_business.WidgetBusiness();
                  if (!context.mounted) return;
                  await showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) => all_dialog_info_view.WidgetView(
                            business: allDialogInfoBusiness,
                            inputVo: const all_dialog_info_view.InputVo(
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
                  var allDialogInfoBusiness =
                      all_dialog_info_business.WidgetBusiness();
                  if (!context.mounted) return;
                  await showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) => all_dialog_info_view.WidgetView(
                            business: allDialogInfoBusiness,
                            inputVo: const all_dialog_info_view.InputVo(
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
                  if (!context.mounted) return;
                  showToast(
                    "본인 인증 코드가 일치하지 않습니다.",
                    context: context,
                    animation: StyledToastAnimation.scale,
                  );
                  FocusScope.of(context)
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
        allDialogLoadingSpinnerBusiness.closeDialog();
        var allDialogInfoBusiness = all_dialog_info_business.WidgetBusiness();
        if (!context.mounted) return;
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) => all_dialog_info_view.WidgetView(
                  business: allDialogInfoBusiness,
                  inputVo: const all_dialog_info_view.InputVo(
                      dialogTitle: "네트워크 에러",
                      dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                      checkBtnTitle: "확인"),
                  onDialogCreated: () {},
                ));
      }

      isVerifyCodeAndGoNextDoing = false;
    } else {
      isVerifyCodeAndGoNextDoing = false;
      FocusScope.of(context).requestFocus(verificationCodeTextFieldFocus);
    }
  }

  // (검증 이메일 다시 전송)
  Future<void> resendVerificationEmail() async {
    // 입력값 검증 완료
    // (로딩 스피너 다이얼로그 호출)
    var allDialogLoadingSpinnerBusiness =
        all_dialog_loading_spinner_business.WidgetBusiness();

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => all_dialog_loading_spinner_view.WidgetView(
            business: allDialogLoadingSpinnerBusiness,
            inputVo: const all_dialog_loading_spinner_view.InputVo(),
            onDialogCreated: () {})).then((outputVo) {});

    var responseVo = await api_main_server
        .postService1TkV1AuthJoinTheMembershipEmailVerificationAsync(
            requestBodyVo: api_main_server
                .PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncRequestBodyVo(
                    email: inputVo.emailAddress));

    if (responseVo.dioException == null) {
      // Dio 네트워크 응답
      allDialogLoadingSpinnerBusiness.closeDialog();
      var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

      if (networkResponseObjectOk.responseStatusCode == 200) {
        var responseBody = networkResponseObjectOk.responseBody
            as api_main_server
            .PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseBodyVo;

        verificationUid = responseBody.verificationUid;

        // 정상 응답
        var allDialogInfoBusiness = all_dialog_info_business.WidgetBusiness();
        if (!context.mounted) return;
        await showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) => all_dialog_info_view.WidgetView(
                  business: allDialogInfoBusiness,
                  inputVo: all_dialog_info_view.InputVo(
                      dialogTitle: "이메일 재발송 성공",
                      dialogContent:
                          "본인 인증 이메일이 재발송 되었습니다.\n(${inputVo.emailAddress})",
                      checkBtnTitle: "확인"),
                  onDialogCreated: () {},
                ));
        if (!context.mounted) return;
        FocusScope.of(context).requestFocus(verificationCodeTextFieldFocus);
      } else {
        var responseHeaders = networkResponseObjectOk.responseHeaders
            as api_main_server
            .PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseHeaderVo;

        // 비정상 응답
        if (responseHeaders.apiResultCode == null) {
          // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
          var allDialogInfoBusiness = all_dialog_info_business.WidgetBusiness();
          if (!context.mounted) return;
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) => all_dialog_info_view.WidgetView(
                    business: allDialogInfoBusiness,
                    inputVo: const all_dialog_info_view.InputVo(
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
                var allDialogInfoBusiness =
                    all_dialog_info_business.WidgetBusiness();
                if (!context.mounted) return;
                await showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) => all_dialog_info_view.WidgetView(
                          business: allDialogInfoBusiness,
                          inputVo: const all_dialog_info_view.InputVo(
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
      allDialogLoadingSpinnerBusiness.closeDialog();
      var allDialogInfoBusiness = all_dialog_info_business.WidgetBusiness();
      if (!context.mounted) return;
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => all_dialog_info_view.WidgetView(
                business: allDialogInfoBusiness,
                inputVo: const all_dialog_info_view.InputVo(
                    dialogTitle: "네트워크 에러",
                    dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                    checkBtnTitle: "확인"),
                onDialogCreated: () {},
              ));
    }
  }

// [private 함수]
}
