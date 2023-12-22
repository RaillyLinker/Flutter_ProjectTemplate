// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner_folder)
import 'main_widget.dart' as main_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;
import 'package:flutter_project_template/dialogs/all/all_dialog_info/main_widget.dart'
    as all_dialog_info;
import 'package:flutter_project_template/dialogs/all/all_dialog_loading_spinner/main_widget.dart'
    as all_dialog_loading_spinner;
import 'package:flutter_project_template/repositories/network/apis/api_main_server.dart'
    as api_main_server;
import 'package:flutter_project_template/pages/all/all_page_get_request_sample/main_widget.dart'
    as all_page_get_request_sample;
import 'package:flutter_project_template/pages/all/all_page_post_request_sample1/main_widget.dart'
    as all_page_post_request_sample1;
import 'package:flutter_project_template/pages/all/all_page_post_request_sample2/main_widget.dart'
    as all_page_post_request_sample2;
import 'package:flutter_project_template/pages/all/all_page_post_request_sample3/main_widget.dart'
    as all_page_post_request_sample3;
import 'package:flutter_project_template/pages/all/all_page_post_request_sample4/main_widget.dart'
    as all_page_post_request_sample4;

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
    hoveringTileViewModelList = getNewItemWidgetList();
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

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState>
      hoveringTileViewModelListAreaGk = GlobalKey();
  late BuildContext hoveringTileListAreaContext;
  List<HoveringListTileViewModel> hoveringTileViewModelList = [];

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!비즈니스 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (메인 위젯 화면 갱신)
  late VoidCallback refreshUi;

  // (현 상황에 맞는 아이템 리스트 반환)
  List<HoveringListTileViewModel> getNewItemWidgetList() {
    List<HoveringListTileViewModel> hoveringListTileViewModel = [];
    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "Get 메소드 요청 샘플",
          itemDescription: "Get 요청 테스트 (Query Parameter)",
          onItemClicked: () {
            mainContext.pushNamed(all_page_get_request_sample.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "Post 메소드 요청 샘플 1 (application/json)",
          itemDescription: "Post 요청 테스트 (Request Body)",
          onItemClicked: () {
            mainContext.pushNamed(all_page_post_request_sample1.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "Post 메소드 요청 샘플 2 (x-www-form-urlencoded)",
          itemDescription: "Post 메소드 요청 테스트 (x-www-form-urlencoded)",
          onItemClicked: () {
            mainContext.pushNamed(all_page_post_request_sample2.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "Post 메소드 요청 샘플 3 (multipart/form-data)",
          itemDescription: "Post 메소드 요청 테스트 (multipart/form-data)",
          onItemClicked: () {
            mainContext.pushNamed(all_page_post_request_sample3.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "Post 메소드 요청 샘플 4 (multipart/form-data - JsonString)",
          itemDescription:
              "Post 메소드 요청 JsonString Parameter (multipart/form-data)",
          onItemClicked: () {
            mainContext.pushNamed(all_page_post_request_sample4.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "Post 메소드 에러 발생 샘플",
          itemDescription: "에러 발생시의 신호를 응답하는 Post 메소드 샘플",
          onItemClicked: () {
            // 로딩 다이얼로그 표시
            GlobalKey<all_dialog_loading_spinner.MainWidgetState>
                allDialogLoadingSpinnerStateGk = GlobalKey();

            showDialog(
                barrierDismissible: false,
                context: mainContext,
                builder: (context) => all_dialog_loading_spinner.MainWidget(
                      key: allDialogLoadingSpinnerStateGk,
                      inputVo: all_dialog_loading_spinner.InputVo(
                          onDialogCreated: () async {
                        var response = await api_main_server
                            .postService1TkV1RequestTestGenerateErrorAsync();

                        // 로딩 다이얼로그 제거
                        allDialogLoadingSpinnerStateGk
                            .currentState?.mainBusiness
                            .closeDialog();

                        if (response.dioException == null) {
                          // Dio 네트워크 응답

                          // (확인 다이얼로그 호출)
                          final GlobalKey<all_dialog_info.MainWidgetState>
                              allDialogInfoStateGk =
                              GlobalKey<all_dialog_info.MainWidgetState>();
                          BuildContext context = mainContext;
                          if (!context.mounted) return;
                          showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) => all_dialog_info.MainWidget(
                                    key: allDialogInfoStateGk,
                                    inputVo: all_dialog_info.InputVo(
                                      dialogTitle: "응답 결과",
                                      dialogContent:
                                          "Http Status Code : ${response.networkResponseObjectOk!.responseStatusCode}\n\nResponse Body:\n${response.networkResponseObjectOk!.responseBody}",
                                      checkBtnTitle: "확인",
                                      onDialogCreated: () {},
                                    ),
                                  )).then((outputVo) {});
                        } else {
                          // Dio 네트워크 에러
                          final GlobalKey<all_dialog_info.MainWidgetState>
                              allDialogInfoStateGk =
                              GlobalKey<all_dialog_info.MainWidgetState>();
                          BuildContext context = mainContext;
                          if (!context.mounted) return;
                          showDialog(
                              barrierDismissible: true,
                              context: context,
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
                      }),
                    )).then((outputVo) {});
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "Get 메소드 String 응답 샘플",
          itemDescription: "String 을 반환하는 Get 메소드 샘플",
          onItemClicked: () {
            // 로딩 다이얼로그 표시
            GlobalKey<all_dialog_loading_spinner.MainWidgetState>
                allDialogLoadingSpinnerStateGk = GlobalKey();

            showDialog(
                barrierDismissible: false,
                context: mainContext,
                builder: (context) => all_dialog_loading_spinner.MainWidget(
                      key: allDialogLoadingSpinnerStateGk,
                      inputVo: all_dialog_loading_spinner.InputVo(
                          onDialogCreated: () async {
                        var response = await api_main_server
                            .getService1TkV1RequestTestReturnTextStringAsync();

                        // 로딩 다이얼로그 제거
                        allDialogLoadingSpinnerStateGk
                            .currentState?.mainBusiness
                            .closeDialog();

                        if (response.dioException == null) {
                          // Dio 네트워크 응답

                          var networkResponseObjectOk =
                              response.networkResponseObjectOk!;

                          if (networkResponseObjectOk.responseStatusCode ==
                              200) {
                            // 정상 응답

                            // 응답 body
                            var responseBodyString =
                                networkResponseObjectOk.responseBody as String;

                            // 확인 다이얼로그 호출
                            final GlobalKey<all_dialog_info.MainWidgetState>
                                allDialogInfoStateGk =
                                GlobalKey<all_dialog_info.MainWidgetState>();
                            BuildContext context = mainContext;
                            if (!context.mounted) return;
                            showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (context) =>
                                    all_dialog_info.MainWidget(
                                      key: allDialogInfoStateGk,
                                      inputVo: all_dialog_info.InputVo(
                                        dialogTitle: "응답 결과",
                                        dialogContent:
                                            "Http Status Code : ${networkResponseObjectOk.responseStatusCode}\n\nResponse Body:\n$responseBodyString",
                                        checkBtnTitle: "확인",
                                        onDialogCreated: () {},
                                      ),
                                    )).then((outputVo) {});
                          } else {
                            // 비정상 응답
                            final GlobalKey<all_dialog_info.MainWidgetState>
                                allDialogInfoStateGk =
                                GlobalKey<all_dialog_info.MainWidgetState>();
                            BuildContext context = mainContext;
                            if (!context.mounted) return;
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) =>
                                    all_dialog_info.MainWidget(
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
                          // Dio 네트워크 에러
                          final GlobalKey<all_dialog_info.MainWidgetState>
                              allDialogInfoStateGk =
                              GlobalKey<all_dialog_info.MainWidgetState>();
                          BuildContext context = mainContext;
                          if (!context.mounted) return;
                          showDialog(
                              barrierDismissible: true,
                              context: context,
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
                      }),
                    )).then((outputVo) {});
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "Get 메소드 Html 응답 샘플",
          itemDescription: "HTML String 을 반환하는 Get 메소드 샘플",
          onItemClicked: () {
            // 로딩 다이얼로그 표시
            GlobalKey<all_dialog_loading_spinner.MainWidgetState>
                allDialogLoadingSpinnerStateGk = GlobalKey();

            showDialog(
                barrierDismissible: false,
                context: mainContext,
                builder: (context) => all_dialog_loading_spinner.MainWidget(
                      key: allDialogLoadingSpinnerStateGk,
                      inputVo: all_dialog_loading_spinner.InputVo(
                          onDialogCreated: () async {
                        var response = await api_main_server
                            .getService1TkV1RequestTestReturnTextHtmlAsync();

                        // 로딩 다이얼로그 제거
                        allDialogLoadingSpinnerStateGk
                            .currentState?.mainBusiness
                            .closeDialog();

                        if (response.dioException == null) {
                          // Dio 네트워크 응답

                          var networkResponseObjectOk =
                              response.networkResponseObjectOk!;

                          if (networkResponseObjectOk.responseStatusCode ==
                              200) {
                            // 정상 응답

                            // 응답 body
                            var responseBodyHtml =
                                networkResponseObjectOk.responseBody as String;

                            // 확인 다이얼로그 호출
                            final GlobalKey<all_dialog_info.MainWidgetState>
                                allDialogInfoStateGk =
                                GlobalKey<all_dialog_info.MainWidgetState>();
                            BuildContext context = mainContext;
                            if (!context.mounted) return;
                            showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (context) =>
                                    all_dialog_info.MainWidget(
                                      key: allDialogInfoStateGk,
                                      inputVo: all_dialog_info.InputVo(
                                        dialogTitle: "응답 결과",
                                        dialogContent:
                                            "Http Status Code : ${networkResponseObjectOk.responseStatusCode}\n\nResponse Body:\n$responseBodyHtml",
                                        checkBtnTitle: "확인",
                                        onDialogCreated: () {},
                                      ),
                                    )).then((outputVo) {});
                          } else {
                            // 비정상 응답
                            final GlobalKey<all_dialog_info.MainWidgetState>
                                allDialogInfoStateGk =
                                GlobalKey<all_dialog_info.MainWidgetState>();
                            BuildContext context = mainContext;
                            if (!context.mounted) return;
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) =>
                                    all_dialog_info.MainWidget(
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
                          // Dio 네트워크 에러
                          final GlobalKey<all_dialog_info.MainWidgetState>
                              allDialogInfoStateGk =
                              GlobalKey<all_dialog_info.MainWidgetState>();
                          BuildContext context = mainContext;
                          if (!context.mounted) return;
                          showDialog(
                              barrierDismissible: true,
                              context: context,
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
                      }),
                    )).then((outputVo) {});
          }),
    );

    return hoveringListTileViewModel;
  }

  // [private 함수]
  void _doNothing() {}
}

class HoveringListTileViewModel {
  HoveringListTileViewModel(
      {required this.itemTitle,
      required this.itemDescription,
      required this.onItemClicked});

  // [public 변수]
  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> hoveringTileAreaGk =
      GlobalKey();
  late BuildContext hoveringTileAreaContext;
  bool isHovering = false;

  final String itemTitle;
  final String itemDescription;
  final void Function() onItemClicked;
}
