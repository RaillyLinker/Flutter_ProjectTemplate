// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'dialog_widget.dart' as dialog_widget;

// (all)
import '../../../global_widgets/gw_do_delete.dart' as gw_do_delete;
import '../../../../repositories/network/apis/api_main_server.dart'
    as api_main_server;
import '../../../dialogs/all/all_dialog_info/dialog_widget.dart'
    as all_dialog_info;
import '../../../dialogs/all/all_dialog_info/dialog_widget_business.dart'
    as all_dialog_info_business;
import '../../../dialogs/all/all_dialog_loading_spinner/dialog_widget.dart'
    as all_dialog_loading_spinner;
import '../../../dialogs/all/all_dialog_loading_spinner/dialog_widget_business.dart'
    as all_dialog_loading_spinner_business;
import '../../../../repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class DialogWidgetBusiness {
  // [콜백 함수]
  // (전체 위젯 initState)
  void initState() {
    // !!!initState 로직 작성!!!
    viewModel.verificationUid = viewModel.inputVo.verificationUid;
  }

  // (전체 위젯 dispose)
  void dispose() {
    // !!!initState 로직 작성!!!
  }

  // (전체 위젯의 FocusDetector 콜백들)
  Future<void> onFocusGained() async {
    // !!!onFocusGained 로직 작성!!!

    // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
    final spw_auth_member_info.SharedPreferenceWrapperVo? nowLoginMemberInfo =
        gf_my_functions.getNowVerifiedMemberInfo();

    if (nowLoginMemberInfo != null) {
      // 로그인 상태라면 닫기
      viewModel.context.pop();
      return;
    }
  }

  Future<void> onFocusLost() async {
    // !!!onFocusLost 로직 작성!!!
  }

  Future<void> onVisibilityGained() async {
    // !!!onFocusLost 로직 작성!!!
  }

  Future<void> onVisibilityLost() async {
    // !!!onVisibilityLost 로직 작성!!!
  }

  Future<void> onForegroundGained() async {
    // !!!onForegroundGained 로직 작성!!!
  }

  Future<void> onForegroundLost() async {
    // !!!onForegroundLost 로직 작성!!!
  }

  // [public 변수]
  // (페이지 뷰모델 객체)
  late PageWidgetViewModel viewModel;

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  // (다이얼로그 종료 함수)
  void closeDialog() {
    viewModel.context.pop();
  }

// !!!사용 함수 추가하기!!!

  // (검증 이메일 다시 전송)
  void resendVerificationEmail() {
    // 입력값 검증 완료
    // (로딩 스피너 다이얼로그 호출)
    final all_dialog_loading_spinner_business.DialogWidgetBusiness
        allDialogLoadingSpinnerBusiness =
        all_dialog_loading_spinner_business.DialogWidgetBusiness();

    showDialog(
        barrierDismissible: false,
        context: viewModel.context,
        builder: (context) => all_dialog_loading_spinner.DialogWidget(
            business: allDialogLoadingSpinnerBusiness,
            inputVo: const all_dialog_loading_spinner.InputVo(),
            onDialogCreated: () async {
              var responseVo = await api_main_server
                  .postService1TkV1AuthJoinTheMembershipEmailVerificationAsync(
                      requestBodyVo: api_main_server
                          .PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncRequestBodyVo(
                              email: viewModel.inputVo.emailAddress));

              allDialogLoadingSpinnerBusiness.closeDialog();

              if (responseVo.dioException == null) {
                // Dio 네트워크 응답
                var networkResponseObjectOk =
                    responseVo.networkResponseObjectOk!;

                if (networkResponseObjectOk.responseStatusCode == 200) {
                  var responseBody = networkResponseObjectOk.responseBody
                      as api_main_server
                      .PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseBodyVo;

                  viewModel.verificationUid = responseBody.verificationUid;

                  // 정상 응답
                  final all_dialog_info_business.DialogWidgetBusiness
                      allDialogInfoBusiness =
                      all_dialog_info_business.DialogWidgetBusiness();
                  BuildContext context = viewModel.context;
                  if (!context.mounted) return;
                  await showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) => all_dialog_info.DialogWidget(
                            business: allDialogInfoBusiness,
                            inputVo: all_dialog_info.InputVo(
                                dialogTitle: "이메일 재발송 성공",
                                dialogContent:
                                    "본인 인증 이메일이 재발송 되었습니다.\n(${viewModel.inputVo.emailAddress})",
                                checkBtnTitle: "확인"),
                            onDialogCreated: () {},
                          ));

                  if (!context.mounted) return;
                  viewModel.gwTextFormFieldWrapperStateGk.currentState
                      ?.textFieldController.text = "";
                  viewModel.gwTextFormFieldWrapperStateGk.currentState
                      ?.textFieldErrorMsg = null;
                  viewModel.gwTextFormFieldWrapperStateGk.currentState
                      ?.refreshUi();
                  viewModel.gwTextFormFieldWrapperStateGk.currentState
                      ?.requestFocus();
                } else {
                  var responseHeaders = networkResponseObjectOk.responseHeaders
                      as api_main_server
                      .PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseHeaderVo;

                  // 비정상 응답
                  if (responseHeaders.apiResultCode == null) {
                    // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
                    final all_dialog_info_business.DialogWidgetBusiness
                        allDialogInfoBusiness =
                        all_dialog_info_business.DialogWidgetBusiness();
                    BuildContext context = viewModel.context;
                    if (!context.mounted) return;
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) => all_dialog_info.DialogWidget(
                              business: allDialogInfoBusiness,
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
                          final all_dialog_info_business.DialogWidgetBusiness
                              allDialogInfoBusiness =
                              all_dialog_info_business.DialogWidgetBusiness();
                          BuildContext context = viewModel.context;
                          if (!context.mounted) return;
                          await showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) =>
                                  all_dialog_info.DialogWidget(
                                    business: allDialogInfoBusiness,
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
                final all_dialog_info_business.DialogWidgetBusiness
                    allDialogInfoBusiness =
                    all_dialog_info_business.DialogWidgetBusiness();
                BuildContext context = viewModel.context;
                if (!context.mounted) return;
                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) => all_dialog_info.DialogWidget(
                          business: allDialogInfoBusiness,
                          inputVo: const all_dialog_info.InputVo(
                              dialogTitle: "네트워크 에러",
                              dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                              checkBtnTitle: "확인"),
                          onDialogCreated: () {},
                        ));
              }
            })).then((outputVo) {});
  }

  // (코드 검증 후 다음 단계로 이동)
  bool isVerifyCodeAndGoNextDoing = false;

  void verifyCodeAndGoNext({required BuildContext context}) {
    if (isVerifyCodeAndGoNextDoing) {
      return;
    }
    isVerifyCodeAndGoNextDoing = true;

    String? verificationCode = viewModel
        .gwTextFormFieldWrapperStateGk.currentState?.textFieldController.text;

    if (verificationCode == null || verificationCode.isEmpty) {
      viewModel.gwTextFormFieldWrapperStateGk.currentState?.textFieldErrorMsg =
          "이 항목을 입력 하세요.";
      viewModel.gwTextFormFieldWrapperStateGk.currentState?.refreshUi();
      viewModel.gwTextFormFieldWrapperStateGk.currentState?.requestFocus();
      isVerifyCodeAndGoNextDoing = false;
      return;
    }

    // 코드 검증
    // (로딩 스피너 다이얼로그 호출)
    all_dialog_loading_spinner_business.DialogWidgetBusiness
        allDialogLoadingSpinnerBusiness =
        all_dialog_loading_spinner_business.DialogWidgetBusiness();

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => all_dialog_loading_spinner.DialogWidget(
            business: allDialogLoadingSpinnerBusiness,
            inputVo: const all_dialog_loading_spinner.InputVo(),
            onDialogCreated: () async {
              var responseVo = await api_main_server
                  .getService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsync(
                      requestQueryVo: api_main_server
                          .GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncRequestQueryVo(
                              verificationUid: viewModel.verificationUid,
                              email: viewModel.inputVo.emailAddress,
                              verificationCode: verificationCode));

              if (responseVo.dioException == null) {
                // Dio 네트워크 응답
                allDialogLoadingSpinnerBusiness.closeDialog();
                var networkResponseObjectOk =
                    responseVo.networkResponseObjectOk!;

                if (networkResponseObjectOk.responseStatusCode == 200) {
                  // 정상 응답

                  // 검증 완료
                  if (!context.mounted) return;
                  context.pop(dialog_widget.OutputVo(
                      checkedVerificationCode: verificationCode,
                      verificationUid: viewModel.verificationUid));
                } else {
                  var responseHeaders = networkResponseObjectOk.responseHeaders
                      as api_main_server
                      .GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncResponseHeaderVo;

                  // 비정상 응답
                  if (responseHeaders.apiResultCode == null) {
                    // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
                    final all_dialog_info_business.DialogWidgetBusiness
                        allDialogInfoBusiness =
                        all_dialog_info_business.DialogWidgetBusiness();
                    if (!context.mounted) return;
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) => all_dialog_info.DialogWidget(
                              business: allDialogInfoBusiness,
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
                          final all_dialog_info_business.DialogWidgetBusiness
                              allDialogInfoBusiness =
                              all_dialog_info_business.DialogWidgetBusiness();
                          if (!context.mounted) return;
                          await showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) =>
                                  all_dialog_info.DialogWidget(
                                    business: allDialogInfoBusiness,
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
                          final all_dialog_info_business.DialogWidgetBusiness
                              allDialogInfoBusiness =
                              all_dialog_info_business.DialogWidgetBusiness();
                          if (!context.mounted) return;
                          await showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) =>
                                  all_dialog_info.DialogWidget(
                                    business: allDialogInfoBusiness,
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
                          viewModel.gwTextFormFieldWrapperStateGk.currentState
                              ?.textFieldErrorMsg = "본인 인증 코드가 일치하지 않습니다.";
                          viewModel.gwTextFormFieldWrapperStateGk.currentState
                              ?.refreshUi();
                          viewModel.gwTextFormFieldWrapperStateGk.currentState
                              ?.requestFocus();
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
                final all_dialog_info_business.DialogWidgetBusiness
                    allDialogInfoBusiness =
                    all_dialog_info_business.DialogWidgetBusiness();
                if (!context.mounted) return;
                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) => all_dialog_info.DialogWidget(
                          business: allDialogInfoBusiness,
                          inputVo: const all_dialog_info.InputVo(
                              dialogTitle: "네트워크 에러",
                              dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                              checkBtnTitle: "확인"),
                          onDialogCreated: () {},
                        ));
              }
            })).then((outputVo) {
      isVerifyCodeAndGoNextDoing = false;
    });
  }
}

// (페이지에서 사용할 변수 저장 클래스)
class PageWidgetViewModel {
  PageWidgetViewModel({required this.context, required this.inputVo});

  // (최초 실행 플래그)
  bool needInitState = true;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // (페이지 컨텍스트 객체)
  BuildContext context;

  // (위젯 입력값)
  dialog_widget.InputVo inputVo;

// !!!페이지에서 사용할 변수를 아래에 선언하기!!!

// !!!페이지에서 사용할 변수를 아래에 선언하기!!!
  final GlobalKey<gw_do_delete.SfwTextFormFieldState>
      gwTextFormFieldWrapperStateGk = GlobalKey();

  // (검증 요청 고유번호)
  late int verificationUid;
}
