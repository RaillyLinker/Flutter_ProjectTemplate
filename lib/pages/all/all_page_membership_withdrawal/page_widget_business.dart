// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// (inner Folder)
import 'page_widget.dart' as page_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_classes/todo_gc_delete.dart'
    as gc_template_classes;
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
import 'package:flutter_project_template/pages/all/all_page_home/page_widget.dart'
    as all_page_home;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageWidgetBusiness {
  // [콜백 함수]
  // (전체 위젯 initState)
  void initState() {
    // !!!initState 로직 작성!!!
  }

  // (전체 위젯 dispose)
  void dispose() {
    // !!!initState 로직 작성!!!
  }

  // (전체 위젯의 FocusDetector 콜백들)
  Future<void> onFocusGained() async {
    // !!!onFocusGained 로직 작성!!!
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

  void onCheckPageInputVo({required GoRouterState goRouterState}) {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   // 필수 파라미터가 없는 경우에 대한 처리
    // }

    // !!!PageInputVo 입력!!!
    inputVo = const page_widget.InputVo();
  }

  // [public 변수]
  // BLoC 객체 샘플 :
  // final gc_template_classes.RefreshableBloc refreshableBloc = gc_template_classes.RefreshableBloc();

  late BuildContext context;

  // (위젯 입력값)
  late page_widget.InputVo inputVo;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // (pageOutFrameBusiness)
  final gw_slw_page_outer_frame.SlwPageOuterFrameBusiness pageOutFrameBusiness =
      gw_slw_page_outer_frame.SlwPageOuterFrameBusiness();

  bool withdrawalAgree = false;
  final gc_template_classes.RefreshableBloc withdrawalAgreeBloc =
      gc_template_classes.RefreshableBloc();

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  // (계정 비번으로 회원탈퇴)
  bool accountWithdrawalAsyncClicked = false;

  Future<void> accountWithdrawalAsync() async {
    if (accountWithdrawalAsyncClicked) {
      return;
    }
    accountWithdrawalAsyncClicked = true;

    var signInInfo = spw_auth_member_info.SharedPreferenceWrapper.get();

    if (signInInfo == null) {
      // 비회원일 때
      showToast(
        "로그인이 필요합니다.",
        context: context,
        animation: StyledToastAnimation.scale,
      );
      accountWithdrawalAsyncClicked = false;
      context.pop();
      return;
    }

    if (!withdrawalAgree) {
      // 회원탈퇴 동의 체크가 안됨
      showToast(
        "동의 버튼 체크가 필요합니다.",
        context: context,
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
        context: context,
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
      if (outputVo.checkPositiveBtn) {
        GlobalKey<all_dialog_loading_spinner.MainWidgetState>
            allDialogLoadingSpinnerStateGk = GlobalKey();

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => all_dialog_loading_spinner.MainWidget(
                  key: allDialogLoadingSpinnerStateGk,
                  inputVo: all_dialog_loading_spinner.InputVo(
                      onDialogCreated: () {}),
                ));

        // 네트워크 요청
        var responseVo =
            await api_main_server.deleteService1TkV1AuthWithdrawalAsync(
          requestHeaderVo: api_main_server
              .DeleteService1TkV1AuthWithdrawalAsyncRequestHeaderVo(
                  authorization:
                      "${signInInfo.tokenType} ${signInInfo.accessToken}"),
        );

        allDialogLoadingSpinnerStateGk.currentState?.mainBusiness.closeDialog(
            mainWidgetState: allDialogLoadingSpinnerStateGk.currentState!);

        if (responseVo.dioException == null) {
          // Dio 네트워크 응답
          var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

          if (networkResponseObjectOk.responseStatusCode == 200) {
            // 정상 응답
            // 로그아웃 처리
            spw_auth_member_info.SharedPreferenceWrapper.set(value: null);
            final GlobalKey<all_dialog_info.MainWidgetState>
                allDialogInfoStateGk =
                GlobalKey<all_dialog_info.MainWidgetState>();
            if (!context.mounted) return;
            await showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) => all_dialog_info.MainWidget(
                      key: allDialogInfoStateGk,
                      inputVo: all_dialog_info.InputVo(
                        dialogTitle: "회원 탈퇴 완료",
                        dialogContent: "회원 탈퇴가 완료되었습니다.\n안녕히 가세요.",
                        checkBtnTitle: "확인",
                        onDialogCreated: () {},
                      ),
                    ));
            if (!context.mounted) return;
            // 홈 페이지로 이동
            context.goNamed(all_page_home.pageName);
          } else if (networkResponseObjectOk.responseStatusCode == 401) {
            // 비회원 처리됨
            if (!context.mounted) return;
            showToast(
              "로그인이 필요합니다.",
              context: context,
              animation: StyledToastAnimation.scale,
            );
            context.pop();
            return;
          } else {
            // 비정상 응답
            final GlobalKey<all_dialog_info.MainWidgetState>
                allDialogInfoStateGk =
                GlobalKey<all_dialog_info.MainWidgetState>();
            if (!context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: context,
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
        } else {
          final GlobalKey<all_dialog_info.MainWidgetState>
              allDialogInfoStateGk =
              GlobalKey<all_dialog_info.MainWidgetState>();
          if (!context.mounted) return;
          showDialog(
              barrierDismissible: true,
              context: context,
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
      }
    });
  }

  // (동의 버튼 클릭시)
  void toggleAgreeButton() {
    withdrawalAgree = !withdrawalAgree;
    withdrawalAgreeBloc.refreshUi();
  }

// [private 함수]
}
