// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget.dart' as page_widget;

// (all)
import '../../../global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import '../../../global_widgets/todo_do_delete.dart' as gw_sfw_wrapper;
import '../../../dialogs/all/all_dialog_info/dialog_widget.dart'
    as all_dialog_info;
import '../../../dialogs/all/all_dialog_info/dialog_widget_business.dart'
    as all_dialog_info_business;
import '../../../dialogs/all/all_dialog_loading_spinner/dialog_widget.dart'
    as all_dialog_loading_spinner;
import '../../../dialogs/all/all_dialog_loading_spinner/dialog_widget_business.dart'
    as all_dialog_loading_spinner_business;
import '../../../../repositories/network/apis/api_main_server.dart'
    as api_main_server;
import '../../../pages/all/all_page_get_request_sample/page_widget.dart'
    as all_page_get_request_sample;
import '../../../pages/all/all_page_post_request_sample1/page_entrance.dart'
    as all_page_post_request_sample1;
import '../../../pages/all/all_page_post_request_sample2/page_entrance.dart'
    as all_page_post_request_sample2;
import '../../../pages/all/all_page_post_request_sample3/page_entrance.dart'
    as all_page_post_request_sample3;
import '../../../pages/all/all_page_post_request_sample4/page_entrance.dart'
    as all_page_post_request_sample4;

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

  page_widget.InputVo? onCheckPageInputVo(
      {required BuildContext context, required GoRouterState goRouterState}) {
    // !!!pageInputVo 체크!!! - 필수 정보 누락시 null 반환
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   return null;
    // }

    // !!!PageInputVo 입력!!!
    return const page_widget.InputVo();
  }

  // [public 변수]
  // (페이지 뷰모델 객체)
  late PageWidgetViewModel viewModel;

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  void onGetRequestItemClicked() {
    viewModel.context.pushNamed(all_page_get_request_sample.pageName);
  }

  void onPostRequest1ItemClicked() {
    viewModel.context.pushNamed(all_page_post_request_sample1.pageName);
  }

  void onPostRequest2ItemClicked() {
    viewModel.context.pushNamed(all_page_post_request_sample2.pageName);
  }

  void onPostRequest3ItemClicked() {
    viewModel.context.pushNamed(all_page_post_request_sample3.pageName);
  }

  void onPostRequest4ItemClicked() {
    viewModel.context.pushNamed(all_page_post_request_sample4.pageName);
  }

  void onPostRequestErrorItemClicked() async {
    // 로딩 다이얼로그 표시
    all_dialog_loading_spinner_business.DialogWidgetBusiness
        allDialogLoadingSpinnerBusiness =
        all_dialog_loading_spinner_business.DialogWidgetBusiness();

    showDialog(
        barrierDismissible: false,
        context: viewModel.context,
        builder: (context) => all_dialog_loading_spinner.DialogWidget(
            business: allDialogLoadingSpinnerBusiness,
            inputVo: const all_dialog_loading_spinner.InputVo(),
            onDialogCreated: () {})).then((outputVo) {});

    var response =
        await api_main_server.postService1TkV1RequestTestGenerateErrorAsync();

    // 로딩 다이얼로그 제거
    allDialogLoadingSpinnerBusiness.closeDialog();

    if (response.dioException == null) {
      // Dio 네트워크 응답

      // (확인 다이얼로그 호출)
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
                inputVo: all_dialog_info.InputVo(
                    dialogTitle: "응답 결과",
                    dialogContent:
                        "Http Status Code : ${response.networkResponseObjectOk!.responseStatusCode}\n\nResponse Body:\n${response.networkResponseObjectOk!.responseBody}",
                    checkBtnTitle: "확인"),
                onDialogCreated: () {},
              )).then((outputVo) {});
    } else {
      // Dio 네트워크 에러
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
  }

  void onGetStringResponseItemClicked() async {
    // 로딩 다이얼로그 표시
    all_dialog_loading_spinner_business.DialogWidgetBusiness
        allDialogLoadingSpinnerBusiness =
        all_dialog_loading_spinner_business.DialogWidgetBusiness();

    showDialog(
        barrierDismissible: false,
        context: viewModel.context,
        builder: (context) => all_dialog_loading_spinner.DialogWidget(
            business: allDialogLoadingSpinnerBusiness,
            inputVo: const all_dialog_loading_spinner.InputVo(),
            onDialogCreated: () {})).then((outputVo) {});

    var response =
        await api_main_server.getService1TkV1RequestTestReturnTextStringAsync();

    // 로딩 다이얼로그 제거
    allDialogLoadingSpinnerBusiness.closeDialog();

    if (response.dioException == null) {
      // Dio 네트워크 응답

      var networkResponseObjectOk = response.networkResponseObjectOk!;

      if (networkResponseObjectOk.responseStatusCode == 200) {
        // 정상 응답

        // 응답 body
        var responseBodyString = networkResponseObjectOk.responseBody as String;

        // 확인 다이얼로그 호출
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
                  inputVo: all_dialog_info.InputVo(
                      dialogTitle: "응답 결과",
                      dialogContent:
                          "Http Status Code : ${networkResponseObjectOk.responseStatusCode}\n\nResponse Body:\n$responseBodyString",
                      checkBtnTitle: "확인"),
                  onDialogCreated: () {},
                )).then((outputVo) {});
      } else {
        // 비정상 응답
        final all_dialog_info_business.DialogWidgetBusiness
            allDialogInfoBusiness =
            all_dialog_info_business.DialogWidgetBusiness();
        BuildContext context = viewModel.context;
        if (!context.mounted) return;
        showDialog(
            barrierDismissible: false,
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
    } else {
      // Dio 네트워크 에러
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
  }

  void onGetHtmlResponseItemClicked() async {
    // 로딩 다이얼로그 표시
    all_dialog_loading_spinner_business.DialogWidgetBusiness
        allDialogLoadingSpinnerBusiness =
        all_dialog_loading_spinner_business.DialogWidgetBusiness();

    showDialog(
        barrierDismissible: false,
        context: viewModel.context,
        builder: (context) => all_dialog_loading_spinner.DialogWidget(
            business: allDialogLoadingSpinnerBusiness,
            inputVo: const all_dialog_loading_spinner.InputVo(),
            onDialogCreated: () {})).then((outputVo) {});

    var response =
        await api_main_server.getService1TkV1RequestTestReturnTextHtmlAsync();

    // 로딩 다이얼로그 제거
    allDialogLoadingSpinnerBusiness.closeDialog();

    if (response.dioException == null) {
      // Dio 네트워크 응답

      var networkResponseObjectOk = response.networkResponseObjectOk!;

      if (networkResponseObjectOk.responseStatusCode == 200) {
        // 정상 응답

        // 응답 body
        var responseBodyHtml = networkResponseObjectOk.responseBody as String;

        // 확인 다이얼로그 호출
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
                  inputVo: all_dialog_info.InputVo(
                      dialogTitle: "응답 결과",
                      dialogContent:
                          "Http Status Code : ${networkResponseObjectOk.responseStatusCode}\n\nResponse Body:\n$responseBodyHtml",
                      checkBtnTitle: "확인"),
                  onDialogCreated: () {},
                )).then((outputVo) {});
      } else {
        // 비정상 응답
        final all_dialog_info_business.DialogWidgetBusiness
            allDialogInfoBusiness =
            all_dialog_info_business.DialogWidgetBusiness();
        BuildContext context = viewModel.context;
        if (!context.mounted) return;
        showDialog(
            barrierDismissible: false,
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
    } else {
      // Dio 네트워크 에러
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
  }

// !!!사용 함수 추가하기!!!
}

// (페이지에서 사용할 변수 저장 클래스)
class PageWidgetViewModel {
  PageWidgetViewModel(
      {required this.context, required page_widget.InputVo? inputVo}) {
    if (inputVo == null) {
      // !!!InputVo 가 충족 되지 않은 경우에 대한 처리!!!
      context.pop();
    } else {
      this.inputVo = inputVo;
    }
  }

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // (페이지 컨텍스트 객체)
  BuildContext context;

  // (위젯 입력값)
  late page_widget.InputVo inputVo;

// !!!페이지에서 사용할 변수를 아래에 선언하기!!!

  // (pageOutFrameBusiness)
  final gw_slw_page_outer_frame.SlwPageOuterFrameBusiness pageOutFrameBusiness =
      gw_slw_page_outer_frame.SlwPageOuterFrameBusiness();
  final GlobalKey<gw_sfw_wrapper.SfwListViewBuilderState>
      sfwListViewBuilderStateGk = GlobalKey();
}
