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
import 'package:flutter_project_template/dialogs/all/all_dialog_yes_or_no/main_widget.dart'
    as all_dialog_yes_or_no;
import 'package:flutter_project_template/pages/all/all_page_home/main_widget.dart'
    as all_page_home;
import 'package:flutter_project_template/pages/all/all_page_login/main_widget.dart'
    as all_page_login;
import 'package:flutter_project_template/global_functions/gf_my_functions.dart'
    as gf_my_functions;

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

    if (nowLoginMemberInfo == null) {
      // 로그아웃 상태
      showToast(
        "로그인이 필요합니다.",
        context: mainContext,
        animation: StyledToastAnimation.scale,
      );
      mainContext.goNamed(all_page_login.pageName);
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

  // (회원탈퇴 동의 체크 여부)
  bool withdrawalAgree = false;
  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> withdrawalAgreeAreaGk =
      GlobalKey();
  late BuildContext withdrawalAgreeAreaContext;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!비즈니스 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (메인 위젯 화면 갱신)
  late VoidCallback refreshUi;

  // (계정 비번으로 회원탈퇴)
  bool accountWithdrawalAsyncClicked = false;

  void accountWithdrawal() {
    if (accountWithdrawalAsyncClicked) {
      return;
    }
    accountWithdrawalAsyncClicked = true;

    var signInInfo = spw_auth_member_info.SharedPreferenceWrapper.get();

    if (signInInfo == null) {
      // 비회원일 때
      showToast(
        "로그인이 필요합니다.",
        context: mainContext,
        animation: StyledToastAnimation.scale,
      );
      accountWithdrawalAsyncClicked = false;
      mainContext.pop();
      return;
    }

    if (!withdrawalAgree) {
      // 회원탈퇴 동의 체크가 안됨
      showToast(
        "동의 버튼 체크가 필요합니다.",
        context: mainContext,
        animation: StyledToastAnimation.scale,
      );
      accountWithdrawalAsyncClicked = false;
      return;
    }

    // 입력창이 모두 충족되었을 때

    accountWithdrawalAsyncClicked = false;

    // (선택 다이얼로그 호출)
    final GlobalKey<all_dialog_yes_or_no.MainWidgetState>
        allDialogYesOrNoStateGk = GlobalKey();
    showDialog(
        barrierDismissible: true,
        context: mainContext,
        builder: (context) => all_dialog_yes_or_no.MainWidget(
              key: allDialogYesOrNoStateGk,
              inputVo: all_dialog_yes_or_no.InputVo(
                dialogTitle: "회원 탈퇴",
                dialogContent: "회원 탈퇴를 진행하시겠습니까?",
                positiveBtnTitle: "예",
                negativeBtnTitle: "아니오",
                onDialogCreated: () {},
              ),
            )).then((outputVo) async {
      if (outputVo != null && outputVo.checkPositiveBtn) {
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
                        .deleteService1TkV1AuthWithdrawalAsync(
                      requestHeaderVo: api_main_server
                          .DeleteService1TkV1AuthWithdrawalAsyncRequestHeaderVo(
                              authorization:
                                  "${signInInfo.tokenType} ${signInInfo.accessToken}"),
                    );

                    allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                        .closeDialog();

                    if (responseVo.dioException == null) {
                      // Dio 네트워크 응답
                      var networkResponseObjectOk =
                          responseVo.networkResponseObjectOk!;

                      if (networkResponseObjectOk.responseStatusCode == 200) {
                        // 정상 응답
                        // 로그아웃 처리
                        spw_auth_member_info.SharedPreferenceWrapper.set(
                            value: null);
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
                                    dialogTitle: "회원 탈퇴 완료",
                                    dialogContent: "회원 탈퇴가 완료되었습니다.\n안녕히 가세요.",
                                    checkBtnTitle: "확인",
                                    onDialogCreated: () {},
                                  ),
                                ));
                        if (!mainContext.mounted) return;
                        // 홈 페이지로 이동
                        mainContext.goNamed(all_page_home.pageName);
                      } else if (networkResponseObjectOk.responseStatusCode ==
                          401) {
                        // 비회원 처리됨
                        if (!mainContext.mounted) return;
                        showToast(
                          "로그인이 필요합니다.",
                          context: mainContext,
                          animation: StyledToastAnimation.scale,
                        );
                        mainContext.goNamed(all_page_login.pageName);
                        return;
                      } else {
                        // 비정상 응답
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
                ));
      }
    });
  }

  // (동의 버튼 클릭시)
  void toggleAgreeButton() {
    withdrawalAgree = !withdrawalAgree;
    withdrawalAgreeAreaGk.currentState?.refreshUi();
  }

  // [private 함수]
  void _doNothing() {}
}
