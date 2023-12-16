// (external)
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

// (inner_folder)
import 'main_widget.dart' as main_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;
import 'package:flutter_project_template/global_functions/gf_my_functions.dart'
    as gf_my_functions;
import 'package:flutter_project_template/repositories/network/apis/api_main_server.dart'
    as api_main_server;
import 'package:flutter_project_template/repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import 'package:flutter_project_template/dialogs/all/all_dialog_info/main_widget.dart'
    as all_dialog_info;
import 'package:flutter_project_template/dialogs/all/all_dialog_loading_spinner/main_widget.dart'
    as all_dialog_loading_spinner;
import 'package:flutter_project_template/pages/all/all_page_login/page_entrance.dart'
    as all_page_login;
import 'package:flutter_project_template/pages/all/all_page_member_info/main_widget.dart'
    as all_page_member_info;
import 'package:flutter_project_template/pages/all/all_page_authorization_test_sample_list/main_widget.dart'
    as all_page_authorization_test_sample_list;

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

    memberInfoViewModel = getMemberInfoVo();
  }

  // (종료 시점 단 한번 실행)
  void dispose() {
    // !!!dispose 로직 작성!!!
  }

  // (위젯이 처음 build 된 후 단 한번 실행)
  Future<void> onCreateWidget() async {
    // !!!onFocusGainedAsync 로직 작성!!!
  }

  Future<void> onFocusGainedAsync() async {
    // !!!onFocusGainedAsync 로직 작성!!!
    hoveringTileViewModelList = getNewItemWidgetList();
    hoveringTileViewModelListAreaGk.currentState?.refreshUi();

    memberInfoViewModel = getMemberInfoVo();
    memberInfoAreaGk.currentState?.refreshUi();
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

  // (최초 실행 플래그)
  bool needInitState = true;

  // (입력값 미충족 여부)
  bool inputError = false;

  // (context 객체)
  late BuildContext mainContext;

  // (pageOutFrameBusiness)
  final gw_slw_page_outer_frame.SlwPageOuterFrameBusiness pageOutFrameBusiness =
      gw_slw_page_outer_frame.SlwPageOuterFrameBusiness();

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState>
      hoveringTileViewModelListAreaGk = GlobalKey();
  late BuildContext hoveringTileListAreaContext;
  List<HoveringListTileViewModel> hoveringTileViewModelList = [];

  // (멤버 정보)
  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> memberInfoAreaGk =
      GlobalKey();
  late BuildContext memberInfoAreaContext;
  MemberInfoViewModel? memberInfoViewModel;

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
          itemTitle: "인증 / 인가 네트워크 요청 테스트 샘플 리스트",
          itemDescription: "인증 / 인가 상태에서 네트워크 요청 및 응답 처리 테스트 샘플 리스트",
          onItemClicked: () {
            // 인증/인가 테스트 샘플 페이지로 이동
            mainContext
                .pushNamed(all_page_authorization_test_sample_list.pageName);
          }),
    );

    // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
    spw_auth_member_info.SharedPreferenceWrapperVo? nowLoginMemberInfo =
        gf_my_functions.getNowVerifiedMemberInfo();

    if (nowLoginMemberInfo == null) {
      // 비 로그인 상태
      hoveringListTileViewModel.add(
        HoveringListTileViewModel(
            itemTitle: "로그인 페이지",
            itemDescription: "로그인 페이지로 이동합니다.",
            onItemClicked: () {
              // 계정 로그인 페이지로 이동
              mainContext.pushNamed(all_page_login.pageName);
            }),
      );
    } else {
      // 로그인 상태
      hoveringListTileViewModel.add(
        HoveringListTileViewModel(
            itemTitle: "로그아웃",
            itemDescription: "로그아웃 처리를 합니다.",
            onItemClicked: () async {
              GlobalKey<all_dialog_loading_spinner.MainWidgetState>
                  allDialogLoadingSpinnerStateGk = GlobalKey();

              showDialog(
                  barrierDismissible: false,
                  context: mainContext,
                  builder: (context) => all_dialog_loading_spinner.MainWidget(
                        key: allDialogLoadingSpinnerStateGk,
                        inputVo: all_dialog_loading_spinner.InputVo(
                            onDialogCreated: () async {}),
                      )).then((outputVo) {});

              // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
              spw_auth_member_info.SharedPreferenceWrapperVo? loginMemberInfo =
                  gf_my_functions.getNowVerifiedMemberInfo();

              if (loginMemberInfo != null) {
                // 서버 Logout API 실행
                await api_main_server.postService1TkV1AuthLogoutAsync(
                    requestHeaderVo: api_main_server
                        .PostService1TkV1AuthLogoutAsyncRequestHeaderVo(
                            authorization:
                                "${loginMemberInfo.tokenType} ${loginMemberInfo.accessToken}"));

                // login_user_info SPW 비우기
                spw_auth_member_info.SharedPreferenceWrapper.set(value: null);
              }

              allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                  .closeDialog();

              // 화면 정보 갱신
              hoveringTileViewModelList = getNewItemWidgetList();
              hoveringTileViewModelListAreaGk.currentState?.refreshUi();

              memberInfoViewModel = getMemberInfoVo();
              memberInfoAreaGk.currentState?.refreshUi();
            }),
      );

      hoveringListTileViewModel.add(
        HoveringListTileViewModel(
            itemTitle: "인증 토큰 갱신",
            itemDescription: "인증 토큰을 갱신합니다.",
            onItemClicked: () async {
              GlobalKey<all_dialog_loading_spinner.MainWidgetState>
                  allDialogLoadingSpinnerStateGk = GlobalKey();

              showDialog(
                  barrierDismissible: false,
                  context: mainContext,
                  builder: (context) => all_dialog_loading_spinner.MainWidget(
                        key: allDialogLoadingSpinnerStateGk,
                        inputVo: all_dialog_loading_spinner.InputVo(
                            onDialogCreated: () async {}),
                      )).then((outputVo) {});

              // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
              spw_auth_member_info.SharedPreferenceWrapperVo? loginMemberInfo =
                  gf_my_functions.getNowVerifiedMemberInfo();

              if (loginMemberInfo == null) {
                hoveringTileViewModelList = getNewItemWidgetList();
                hoveringTileViewModelListAreaGk.currentState?.refreshUi();

                memberInfoViewModel = getMemberInfoVo();
                memberInfoAreaGk.currentState?.refreshUi();
              } else {
                // 리플레시 토큰 만료 여부 확인
                bool isRefreshTokenExpired =
                    DateFormat('yyyy-MM-dd HH:mm:ss.SSS')
                        .parse(loginMemberInfo.refreshTokenExpireWhen)
                        .isBefore(DateTime.now());

                if (isRefreshTokenExpired) {
                  // 리플래시 토큰이 사용 불가이므로 로그아웃 처리
                  // login_user_info SPW 비우기
                  spw_auth_member_info.SharedPreferenceWrapper.set(value: null);
                  allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                      .closeDialog();

                  hoveringTileViewModelList = getNewItemWidgetList();
                  hoveringTileViewModelListAreaGk.currentState?.refreshUi();

                  memberInfoViewModel = getMemberInfoVo();
                  memberInfoAreaGk.currentState?.refreshUi();
                } else {
                  var postAutoLoginOutputVo =
                      await api_main_server.postService1TkV1AuthReissueAsync(
                          requestHeaderVo: api_main_server
                              .PostService1TkV1AuthReissueAsyncRequestHeaderVo(
                                  authorization:
                                      "${loginMemberInfo.tokenType} ${loginMemberInfo.accessToken}"),
                          requestBodyVo: api_main_server
                              .PostService1TkV1AuthReissueAsyncRequestBodyVo(
                                  refreshToken:
                                      "${loginMemberInfo.tokenType} ${loginMemberInfo.refreshToken}"));

                  // 네트워크 요청 결과 처리
                  if (postAutoLoginOutputVo.dioException == null) {
                    // Dio 네트워크 응답
                    var networkResponseObjectOk =
                        postAutoLoginOutputVo.networkResponseObjectOk!;

                    if (networkResponseObjectOk.responseStatusCode == 200) {
                      // 정상 응답

                      // 응답 Body
                      var postReissueResponseBody = networkResponseObjectOk
                              .responseBody! as api_main_server
                          .PostService1TkV1AuthReissueAsyncResponseBodyVo;

                      // SPW 정보 갱신
                      List<
                              spw_auth_member_info
                              .SharedPreferenceWrapperVoOAuth2Info>
                          myOAuth2ObjectList = [];
                      for (api_main_server
                          .PostReissueAsyncResponseBodyVoOAuth2Info myOAuth2
                          in postReissueResponseBody.myOAuth2List) {
                        myOAuth2ObjectList.add(spw_auth_member_info
                            .SharedPreferenceWrapperVoOAuth2Info(
                          myOAuth2.uid,
                          myOAuth2.oauth2TypeCode,
                          myOAuth2.oauth2Id,
                        ));
                      }

                      List<
                              spw_auth_member_info
                              .SharedPreferenceWrapperVoProfileInfo>
                          myProfileList = [];
                      for (api_main_server
                          .PostReissueAsyncResponseBodyVoProfile myProfile
                          in postReissueResponseBody.myProfileList) {
                        myProfileList.add(spw_auth_member_info
                            .SharedPreferenceWrapperVoProfileInfo(
                          myProfile.uid,
                          myProfile.imageFullUrl,
                          myProfile.isFront,
                        ));
                      }

                      List<
                          spw_auth_member_info
                          .SharedPreferenceWrapperVoEmailInfo> myEmailList = [];
                      for (api_main_server
                          .PostReissueAsyncResponseBodyVoEmail myEmail
                          in postReissueResponseBody.myEmailList) {
                        myEmailList.add(spw_auth_member_info
                            .SharedPreferenceWrapperVoEmailInfo(
                          uid: myEmail.uid,
                          emailAddress: myEmail.emailAddress,
                          isFront: myEmail.isFront,
                        ));
                      }

                      List<
                              spw_auth_member_info
                              .SharedPreferenceWrapperVoPhoneInfo>
                          myPhoneNumberList = [];
                      for (api_main_server
                          .PostReissueAsyncResponseBodyVoPhone myPhone
                          in postReissueResponseBody.myPhoneNumberList) {
                        myPhoneNumberList.add(spw_auth_member_info
                            .SharedPreferenceWrapperVoPhoneInfo(
                          uid: myPhone.uid,
                          phoneNumber: myPhone.phoneNumber,
                          isFront: myPhone.isFront,
                        ));
                      }

                      loginMemberInfo.memberUid =
                          postReissueResponseBody.memberUid;
                      loginMemberInfo.nickName =
                          postReissueResponseBody.nickName;
                      loginMemberInfo.roleList =
                          postReissueResponseBody.roleList;
                      loginMemberInfo.tokenType =
                          postReissueResponseBody.tokenType;
                      loginMemberInfo.accessToken =
                          postReissueResponseBody.accessToken;
                      loginMemberInfo.accessTokenExpireWhen =
                          postReissueResponseBody.accessTokenExpireWhen;
                      loginMemberInfo.refreshToken =
                          postReissueResponseBody.refreshToken;
                      loginMemberInfo.refreshTokenExpireWhen =
                          postReissueResponseBody.refreshTokenExpireWhen;
                      loginMemberInfo.myOAuth2List = myOAuth2ObjectList;
                      loginMemberInfo.myProfileList = myProfileList;
                      loginMemberInfo.myEmailList = myEmailList;
                      loginMemberInfo.myPhoneNumberList = myPhoneNumberList;
                      loginMemberInfo.authPasswordIsNull =
                          postReissueResponseBody.authPasswordIsNull;

                      spw_auth_member_info.SharedPreferenceWrapper.set(
                          value: loginMemberInfo);

                      allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                          .closeDialog();

                      hoveringTileViewModelList = getNewItemWidgetList();
                      hoveringTileViewModelListAreaGk.currentState?.refreshUi();

                      memberInfoViewModel = getMemberInfoVo();
                      memberInfoAreaGk.currentState?.refreshUi();
                    } else {
                      var postReissueResponseHeader = networkResponseObjectOk
                              .responseHeaders! as api_main_server
                          .PostService1TkV1AuthReissueAsyncResponseHeaderVo;

                      // 비정상 응답
                      if (postReissueResponseHeader.apiResultCode == null) {
                        allDialogLoadingSpinnerStateGk
                            .currentState?.mainBusiness
                            .closeDialog();

                        // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
                        final GlobalKey<all_dialog_info.MainWidgetState>
                            allDialogInfoStateGk =
                            GlobalKey<all_dialog_info.MainWidgetState>();
                        if (!mainContext.mounted) return;
                        showDialog(
                            barrierDismissible: false,
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
                      } else {
                        allDialogLoadingSpinnerStateGk
                            .currentState?.mainBusiness
                            .closeDialog();

                        // 서버 지정 에러 코드를 전달 받았을 때
                        String apiResultCode =
                            postReissueResponseHeader.apiResultCode!;

                        switch (apiResultCode) {
                          case "1": // 탈퇴된 회원
                          case "2": // 유효하지 않은 리프레시 토큰
                          case "3": // 리프레시 토큰 만료
                          case "4": // 리프레시 토큰이 액세스 토큰과 매칭되지 않음
                            {
                              // 리플래시 토큰이 사용 불가이므로 로그아웃 처리
                              // login_user_info SPW 비우기
                              spw_auth_member_info.SharedPreferenceWrapper.set(
                                  value: null);

                              hoveringTileViewModelList =
                                  getNewItemWidgetList();
                              hoveringTileViewModelListAreaGk.currentState
                                  ?.refreshUi();

                              memberInfoViewModel = getMemberInfoVo();
                              memberInfoAreaGk.currentState?.refreshUi();
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
                    allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                        .closeDialog();

                    // Dio 네트워크 에러
                    final GlobalKey<all_dialog_info.MainWidgetState>
                        allDialogInfoStateGk =
                        GlobalKey<all_dialog_info.MainWidgetState>();
                    if (!mainContext.mounted) return;
                    showDialog(
                        barrierDismissible: false,
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
                }
              }
            }),
      );

      hoveringListTileViewModel.add(
        HoveringListTileViewModel(
            itemTitle: "회원 정보 페이지로 이동",
            itemDescription: "회원 정보 페이지로 이동합니다.",
            onItemClicked: () {
              // 회원정보 페이지로 이동
              mainContext.pushNamed(all_page_member_info.pageName);
            }),
      );
    }

    return hoveringListTileViewModel;
  }

  // (멤버 정보 반환)
  MemberInfoViewModel? getMemberInfoVo() {
    // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
    spw_auth_member_info.SharedPreferenceWrapperVo? loginMemberInfo =
        gf_my_functions.getNowVerifiedMemberInfo();

    if (loginMemberInfo == null) {
      return null;
    } else {
      return MemberInfoViewModel(
        memberUid: loginMemberInfo.memberUid.toString(),
        tokenType: loginMemberInfo.tokenType.toString(),
        accessToken: loginMemberInfo.accessToken.toString(),
        accessTokenExpireWhen: loginMemberInfo.accessTokenExpireWhen.toString(),
        refreshToken: loginMemberInfo.refreshToken.toString(),
        refreshTokenExpireWhen:
            loginMemberInfo.refreshTokenExpireWhen.toString(),
      );
    }
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

class MemberInfoViewModel {
  const MemberInfoViewModel(
      {required this.memberUid,
      required this.tokenType,
      required this.accessToken,
      required this.accessTokenExpireWhen,
      required this.refreshToken,
      required this.refreshTokenExpireWhen});

  final String memberUid;
  final String tokenType;
  final String accessToken;
  final String accessTokenExpireWhen;
  final String refreshToken;
  final String refreshTokenExpireWhen;
}
