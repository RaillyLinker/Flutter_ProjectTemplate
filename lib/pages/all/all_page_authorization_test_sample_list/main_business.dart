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
import 'package:flutter_project_template/repositories/network/apis/api_main_server.dart'
    as api_main_server;
import 'package:flutter_project_template/repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import 'package:flutter_project_template/dialogs/all/all_dialog_info/main_widget.dart'
    as all_dialog_info;
import 'package:flutter_project_template/dialogs/all/all_dialog_loading_spinner/main_widget.dart'
    as all_dialog_loading_spinner;

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
          itemTitle: "비 로그인 접속 테스트",
          itemDescription: "비 로그인 상태에서도 호출 가능한 API",
          onItemClicked: () {
            // 서버 접속 테스트
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
                            .getService1TkV1AuthForNoLoggedInAsync();

                        // 로딩 다이얼로그 제거
                        allDialogLoadingSpinnerStateGk
                            .currentState?.mainBusiness
                            .closeDialog();

                        if (response.dioException == null) {
                          // Dio 네트워크 응답

                          var networkResponseObjectOk =
                              response.networkResponseObjectOk!;

                          var responseBody =
                              networkResponseObjectOk.responseBody;

                          // (확인 다이얼로그 호출)
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
                                      dialogTitle: "응답 결과",
                                      dialogContent:
                                          "Http Status Code : ${networkResponseObjectOk.responseStatusCode}\n\nResponse Body:\n${responseBody.toString()}",
                                      checkBtnTitle: "확인",
                                      onDialogCreated: () {},
                                    ),
                                  )).then((outputVo) {});
                        } else {
                          // Dio 네트워크 에러
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
                      }),
                    )).then((outputVo) {});
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "로그인 접속 테스트",
          itemDescription: "로그인 상태에서 호출 가능한 API",
          onItemClicked: () {
            // 무권한 로그인 진입 테스트
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
                        spw_auth_member_info.SharedPreferenceWrapperVo?
                            loginMemberInfo =
                            spw_auth_member_info.SharedPreferenceWrapper.get();

                        String? authorization = (loginMemberInfo == null)
                            ? null
                            : "${loginMemberInfo.tokenType} ${loginMemberInfo.accessToken}";

                        var response = await api_main_server
                            .getService1TkV1AuthForLoggedInAsync(
                                requestHeaderVo: api_main_server
                                    .GetService1TkV1AuthForLoggedInAsyncRequestHeaderVo(
                                        authorization: authorization));

                        // 로딩 다이얼로그 제거
                        allDialogLoadingSpinnerStateGk
                            .currentState?.mainBusiness
                            .closeDialog();

                        if (response.dioException == null) {
                          // Dio 네트워크 응답

                          var networkResponseObjectOk =
                              response.networkResponseObjectOk!;

                          var responseBody =
                              networkResponseObjectOk.responseBody;

                          // (확인 다이얼로그 호출)
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
                                      dialogTitle: "응답 결과",
                                      dialogContent:
                                          "Http Status Code : ${networkResponseObjectOk.responseStatusCode}\n\nResponse Body:\n${responseBody.toString()}",
                                      checkBtnTitle: "확인",
                                      onDialogCreated: () {},
                                    ),
                                  )).then((outputVo) {});
                        } else {
                          // Dio 네트워크 에러
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
                      }),
                    )).then((outputVo) {});
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "Developer 권한 진입 테스트",
          itemDescription: "ADMIN 혹은 DEVELOPER 권한이 있는 상태에서 호출 가능한 API",
          onItemClicked: () {
            // DEVELOPER 권한 진입 테스트
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
                        spw_auth_member_info.SharedPreferenceWrapperVo?
                            loginMemberInfo =
                            spw_auth_member_info.SharedPreferenceWrapper.get();

                        String? authorization = (loginMemberInfo == null)
                            ? null
                            : "${loginMemberInfo.tokenType} ${loginMemberInfo.accessToken}";

                        var response = await api_main_server
                            .getService1TkV1AuthForDeveloperAsync(
                                requestHeaderVo: api_main_server
                                    .GetService1TkV1AuthForDeveloperAsyncRequestHeaderVo(
                                        authorization: authorization));

                        // 로딩 다이얼로그 제거
                        allDialogLoadingSpinnerStateGk
                            .currentState?.mainBusiness
                            .closeDialog();

                        if (response.dioException == null) {
                          // Dio 네트워크 응답

                          var networkResponseObjectOk =
                              response.networkResponseObjectOk!;

                          var responseBody =
                              networkResponseObjectOk.responseBody;

                          // (확인 다이얼로그 호출)
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
                                      dialogTitle: "응답 결과",
                                      dialogContent:
                                          "Http Status Code : ${networkResponseObjectOk.responseStatusCode}\n\nResponse Body:\n${responseBody.toString()}",
                                      checkBtnTitle: "확인",
                                      onDialogCreated: () {},
                                    ),
                                  )).then((outputVo) {});
                        } else {
                          // Dio 네트워크 에러
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
                      }),
                    )).then((outputVo) {});
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "ADMIN 권한 진입 테스트",
          itemDescription: "ADMIN 권한이 있는 상태에서 호출 가능한 API",
          onItemClicked: () {
            // ADMIN 권한 진입 테스트
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
                        spw_auth_member_info.SharedPreferenceWrapperVo?
                            loginMemberInfo =
                            spw_auth_member_info.SharedPreferenceWrapper.get();

                        String? authorization = (loginMemberInfo == null)
                            ? null
                            : "${loginMemberInfo.tokenType} ${loginMemberInfo.accessToken}";

                        var response = await api_main_server
                            .getService1TkV1AuthForAdminAsync(
                                requestHeaderVo: api_main_server
                                    .GetService1TkV1AuthForAdminAsyncRequestHeaderVo(
                                        authorization: authorization));

                        // 로딩 다이얼로그 제거
                        allDialogLoadingSpinnerStateGk
                            .currentState?.mainBusiness
                            .closeDialog();

                        if (response.dioException == null) {
                          // Dio 네트워크 응답

                          var networkResponseObjectOk =
                              response.networkResponseObjectOk!;

                          var responseBody =
                              networkResponseObjectOk.responseBody;

                          // (확인 다이얼로그 호출)
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
                                      dialogTitle: "응답 결과",
                                      dialogContent:
                                          "Http Status Code : ${networkResponseObjectOk.responseStatusCode}\n\nResponse Body:\n${responseBody.toString()}",
                                      checkBtnTitle: "확인",
                                      onDialogCreated: () {},
                                    ),
                                  )).then((outputVo) {});
                        } else {
                          // Dio 네트워크 에러
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
