// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// (inner Folder)
import 'page_widget.dart' as page_widget;

// (all)
import '../../../global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../../repositories/network/apis/api_main_server.dart'
    as api_main_server;
import '../../../../repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import '../../../dialogs/all/all_dialog_info/dialog_widget.dart'
    as all_dialog_info;
import '../../../dialogs/all/all_dialog_info/dialog_widget_business.dart'
    as all_dialog_info_business;
import '../../../dialogs/all/all_dialog_loading_spinner/dialog_widget.dart'
    as all_dialog_loading_spinner;
import '../../../dialogs/all/all_dialog_loading_spinner/dialog_widget_business.dart'
    as all_dialog_loading_spinner_business;

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

    setListItem();
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
  late BuildContext context;

  // (위젯 입력값)
  late page_widget.InputVo inputVo;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // (pageOutFrameBusiness)
  final gw_slw_page_outer_frame.SlwPageOuterFrameBusiness pageOutFrameBusiness =
      gw_slw_page_outer_frame.SlwPageOuterFrameBusiness();

  List<SampleItemViewModel> itemList = [];
  gc_template_classes.RefreshableBloc itemListBloc =
      gc_template_classes.RefreshableBloc();

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  void setListItem() {
    itemList = [];
    itemList.add(SampleItemViewModel(
        itemTitle: "비 로그인 접속 테스트",
        itemDescription: "비 로그인 상태에서도 호출 가능한 API",
        onItemClicked: () async {
          // 서버 접속 테스트
          // 로딩 다이얼로그 표시
          all_dialog_loading_spinner_business.DialogWidgetBusiness
              allDialogLoadingSpinnerBusiness =
              all_dialog_loading_spinner_business.DialogWidgetBusiness();

          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => all_dialog_loading_spinner.DialogWidget(
                  business: allDialogLoadingSpinnerBusiness,
                  inputVo: const all_dialog_loading_spinner.InputVo(),
                  onDialogCreated: () {})).then((outputVo) {});

          var response =
              await api_main_server.getService1TkV1AuthForNoLoggedInAsync();

          // 로딩 다이얼로그 제거
          allDialogLoadingSpinnerBusiness.closeDialog();

          if (response.dioException == null) {
            // Dio 네트워크 응답

            var networkResponseObjectOk = response.networkResponseObjectOk!;

            var responseBody = networkResponseObjectOk.responseBody;

            // (확인 다이얼로그 호출)
            final all_dialog_info_business.DialogWidgetBusiness
                allDialogInfoBusiness =
                all_dialog_info_business.DialogWidgetBusiness();
            if (!context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) => all_dialog_info.DialogWidget(
                      business: allDialogInfoBusiness,
                      inputVo: all_dialog_info.InputVo(
                          dialogTitle: "응답 결과",
                          dialogContent:
                              "Http Status Code : ${networkResponseObjectOk.responseStatusCode}\n\nResponse Body:\n${responseBody.toString()}",
                          checkBtnTitle: "확인"),
                      onDialogCreated: () {},
                    )).then((outputVo) {});
          } else {
            // Dio 네트워크 에러
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
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "로그인 접속 테스트",
        itemDescription: "로그인 상태에서 호출 가능한 API",
        onItemClicked: () async {
          // 무권한 로그인 진입 테스트
          // 로딩 다이얼로그 표시
          all_dialog_loading_spinner_business.DialogWidgetBusiness
              allDialogLoadingSpinnerBusiness =
              all_dialog_loading_spinner_business.DialogWidgetBusiness();

          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => all_dialog_loading_spinner.DialogWidget(
                  business: allDialogLoadingSpinnerBusiness,
                  inputVo: const all_dialog_loading_spinner.InputVo(),
                  onDialogCreated: () {})).then((outputVo) {});

          spw_auth_member_info.SharedPreferenceWrapperVo? loginMemberInfo =
              spw_auth_member_info.SharedPreferenceWrapper.get();

          String? authorization = (loginMemberInfo == null)
              ? null
              : "${loginMemberInfo.tokenType} ${loginMemberInfo.accessToken}";

          var response =
              await api_main_server.getService1TkV1AuthForLoggedInAsync(
                  requestHeaderVo: api_main_server
                      .GetService1TkV1AuthForLoggedInAsyncRequestHeaderVo(
                          authorization: authorization));

          // 로딩 다이얼로그 제거
          allDialogLoadingSpinnerBusiness.closeDialog();

          if (response.dioException == null) {
            // Dio 네트워크 응답

            var networkResponseObjectOk = response.networkResponseObjectOk!;

            var responseBody = networkResponseObjectOk.responseBody;

            // (확인 다이얼로그 호출)
            final all_dialog_info_business.DialogWidgetBusiness
                allDialogInfoBusiness =
                all_dialog_info_business.DialogWidgetBusiness();
            if (!context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) => all_dialog_info.DialogWidget(
                      business: allDialogInfoBusiness,
                      inputVo: all_dialog_info.InputVo(
                          dialogTitle: "응답 결과",
                          dialogContent:
                              "Http Status Code : ${networkResponseObjectOk.responseStatusCode}\n\nResponse Body:\n${responseBody.toString()}",
                          checkBtnTitle: "확인"),
                      onDialogCreated: () {},
                    )).then((outputVo) {});
          } else {
            // Dio 네트워크 에러
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
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "Developer 권한 진입 테스트",
        itemDescription: "ADMIN 혹은 DEVELOPER 권한이 있는 상태에서 호출 가능한 API",
        onItemClicked: () async {
          // DEVELOPER 권한 진입 테스트
          // 로딩 다이얼로그 표시
          all_dialog_loading_spinner_business.DialogWidgetBusiness
              allDialogLoadingSpinnerBusiness =
              all_dialog_loading_spinner_business.DialogWidgetBusiness();

          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => all_dialog_loading_spinner.DialogWidget(
                  business: allDialogLoadingSpinnerBusiness,
                  inputVo: const all_dialog_loading_spinner.InputVo(),
                  onDialogCreated: () {})).then((outputVo) {});

          spw_auth_member_info.SharedPreferenceWrapperVo? loginMemberInfo =
              spw_auth_member_info.SharedPreferenceWrapper.get();

          String? authorization = (loginMemberInfo == null)
              ? null
              : "${loginMemberInfo.tokenType} ${loginMemberInfo.accessToken}";

          var response =
              await api_main_server.getService1TkV1AuthForDeveloperAsync(
                  requestHeaderVo: api_main_server
                      .GetService1TkV1AuthForDeveloperAsyncRequestHeaderVo(
                          authorization: authorization));

          // 로딩 다이얼로그 제거
          allDialogLoadingSpinnerBusiness.closeDialog();

          if (response.dioException == null) {
            // Dio 네트워크 응답

            var networkResponseObjectOk = response.networkResponseObjectOk!;

            var responseBody = networkResponseObjectOk.responseBody;

            // (확인 다이얼로그 호출)
            final all_dialog_info_business.DialogWidgetBusiness
                allDialogInfoBusiness =
                all_dialog_info_business.DialogWidgetBusiness();
            if (!context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) => all_dialog_info.DialogWidget(
                      business: allDialogInfoBusiness,
                      inputVo: all_dialog_info.InputVo(
                          dialogTitle: "응답 결과",
                          dialogContent:
                              "Http Status Code : ${networkResponseObjectOk.responseStatusCode}\n\nResponse Body:\n${responseBody.toString()}",
                          checkBtnTitle: "확인"),
                      onDialogCreated: () {},
                    )).then((outputVo) {});
          } else {
            // Dio 네트워크 에러
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
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "ADMIN 권한 진입 테스트",
        itemDescription: "ADMIN 권한이 있는 상태에서 호출 가능한 API",
        onItemClicked: () async {
          // ADMIN 권한 진입 테스트
          // 로딩 다이얼로그 표시
          all_dialog_loading_spinner_business.DialogWidgetBusiness
              allDialogLoadingSpinnerBusiness =
              all_dialog_loading_spinner_business.DialogWidgetBusiness();

          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => all_dialog_loading_spinner.DialogWidget(
                  business: allDialogLoadingSpinnerBusiness,
                  inputVo: const all_dialog_loading_spinner.InputVo(),
                  onDialogCreated: () {})).then((outputVo) {});

          spw_auth_member_info.SharedPreferenceWrapperVo? loginMemberInfo =
              spw_auth_member_info.SharedPreferenceWrapper.get();

          String? authorization = (loginMemberInfo == null)
              ? null
              : "${loginMemberInfo.tokenType} ${loginMemberInfo.accessToken}";

          var response = await api_main_server.getService1TkV1AuthForAdminAsync(
              requestHeaderVo: api_main_server
                  .GetService1TkV1AuthForAdminAsyncRequestHeaderVo(
                      authorization: authorization));

          // 로딩 다이얼로그 제거
          allDialogLoadingSpinnerBusiness.closeDialog();

          if (response.dioException == null) {
            // Dio 네트워크 응답

            var networkResponseObjectOk = response.networkResponseObjectOk!;

            var responseBody = networkResponseObjectOk.responseBody;

            // (확인 다이얼로그 호출)
            final all_dialog_info_business.DialogWidgetBusiness
                allDialogInfoBusiness =
                all_dialog_info_business.DialogWidgetBusiness();
            if (!context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) => all_dialog_info.DialogWidget(
                      business: allDialogInfoBusiness,
                      inputVo: all_dialog_info.InputVo(
                          dialogTitle: "응답 결과",
                          dialogContent:
                              "Http Status Code : ${networkResponseObjectOk.responseStatusCode}\n\nResponse Body:\n${responseBody.toString()}",
                          checkBtnTitle: "확인"),
                      onDialogCreated: () {},
                    )).then((outputVo) {});
          } else {
            // Dio 네트워크 에러
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
        }));

    itemListBloc.refreshUi();
  }

// [private 함수]
}

class SampleItemViewModel {
  SampleItemViewModel(
      {required this.itemTitle,
      required this.itemDescription,
      required this.onItemClicked});

  // 샘플 타이틀
  final String itemTitle;

  // 샘플 설명
  final String itemDescription;

  final void Function() onItemClicked;

  bool isHovering = false;
  gc_template_classes.RefreshableBloc isHoveringBloc =
      gc_template_classes.RefreshableBloc();
}
