// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

// (inner Folder)
import 'page_widget.dart' as page_widget;
import 'inner_widgets/iw_sample_list/sf_widget_state.dart'
    as iw_sample_list_state;
import 'inner_widgets/iw_sample_list/sf_widget.dart' as iw_sample_list;
import 'inner_widgets/iw_member_info_widget/sf_widget.dart'
    as iw_member_info_widget;
import 'inner_widgets/iw_member_info_widget/sf_widget_state.dart'
    as iw_member_info_widget_state;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget_business.dart'
    as gw_page_outer_frame_business;
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;
import '../../../../repositories/network/apis/api_main_server.dart'
    as api_main_server;
import '../../../../repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import '../../../dialogs/all/all_dialog_info/dialog_widget.dart'
    as all_dialog_info;
import '../../../dialogs/all/all_dialog_info/dialog_widget_state.dart'
    as all_dialog_info_state;
import '../../../dialogs/all/all_dialog_loading_spinner/dialog_widget.dart'
    as all_dialog_loading_spinner;
import '../../../dialogs/all/all_dialog_loading_spinner/dialog_widget_state.dart'
    as all_dialog_loading_spinner_state;
import '../../../pages/all/all_page_login/page_entrance.dart' as all_page_login;
import '../../../pages/all/all_page_member_info/page_entrance.dart'
    as all_page_member_info;
import '../../../pages/all/all_page_authorization_test_sample_list/page_widget.dart'
    as all_page_authorization_test_sample_list;

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

    // (페이지 복귀 시마다 아이템 리스트 갱신 조건 확인)
    refreshMemberScreenInfo();
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
  final gw_page_outer_frame_business.SlWidgetBusiness pageOutFrameBusiness =
      gw_page_outer_frame_business.SlWidgetBusiness();

  final GlobalKey<iw_sample_list_state.SfWidgetState> iwSampleListStateGk =
      GlobalKey();

  final GlobalKey<iw_member_info_widget_state.SfWidgetState>
      iwMemberInfoWidgetStateGk = GlobalKey();

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  // (조건에 따른 페이지 아이템 리스트 반환)
  List<iw_sample_list.SampleItem> getItemList() {
    final List<iw_sample_list.SampleItem> itemList = [];

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "인증 / 인가 네트워크 요청 테스트 샘플 리스트",
        itemDescription: "인증 / 인가 상태에서 네트워크 요청 및 응답 처리 테스트 샘플 리스트",
        onItemClicked: () {
          // 인증/인가 테스트 샘플 페이지로 이동
          onAuthTestSampleItemClicked();
        }));

    // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
    spw_auth_member_info.SharedPreferenceWrapperVo? nowLoginMemberInfo =
        gf_my_functions.getNowVerifiedMemberInfo();

    if (nowLoginMemberInfo == null) {
      // 비 로그인 상태
      itemList.add(iw_sample_list.SampleItem(
          itemTitle: "로그인 페이지",
          itemDescription: "로그인 페이지로 이동합니다.",
          onItemClicked: () {
            // 계정 로그인 페이지로 이동
            onLoginSampleItemClicked();
          }));
    } else {
      // 로그인 상태
      itemList.add(iw_sample_list.SampleItem(
          itemTitle: "로그아웃",
          itemDescription: "로그아웃 처리를 합니다.",
          onItemClicked: () {
            onLogOutSampleItemClickedAsync();
          }));

      itemList.add(iw_sample_list.SampleItem(
          itemTitle: "인증 토큰 갱신",
          itemDescription: "인증 토큰을 갱신합니다.",
          onItemClicked: () {
            onJwtRefreshSampleItemClickedAsync();
          }));

      itemList.add(iw_sample_list.SampleItem(
          itemTitle: "회원 정보 페이지로 이동",
          itemDescription: "회원 정보 페이지로 이동합니다.",
          onItemClicked: () {
            // 회원정보 페이지로 이동
            onUserInfoItemClickedAsync();
          }));
    }

    return itemList;
  }

  void onAuthTestSampleItemClicked() {
    context.pushNamed(all_page_authorization_test_sample_list.pageName);
  }

  void onLoginSampleItemClicked() {
    context.pushNamed(all_page_login.pageName);
  }

  // (계정 로그아웃 처리)
  Future<void> onLogOutSampleItemClickedAsync() async {
    GlobalKey<all_dialog_loading_spinner_state.DialogWidgetState>
        allDialogLoadingSpinnerStateGk = GlobalKey();

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => all_dialog_loading_spinner.DialogWidget(
            globalKey: allDialogLoadingSpinnerStateGk,
            inputVo: const all_dialog_loading_spinner.InputVo(),
            onDialogCreated: () async {})).then((outputVo) {});

    // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
    spw_auth_member_info.SharedPreferenceWrapperVo? loginMemberInfo =
        gf_my_functions.getNowVerifiedMemberInfo();

    if (loginMemberInfo != null) {
      // 서버 Logout API 실행
      await api_main_server.postService1TkV1AuthLogoutAsync(
          requestHeaderVo:
              api_main_server.PostService1TkV1AuthLogoutAsyncRequestHeaderVo(
                  authorization:
                      "${loginMemberInfo.tokenType} ${loginMemberInfo.accessToken}"));

      // login_user_info SPW 비우기
      spw_auth_member_info.SharedPreferenceWrapper.set(value: null);
    }

    allDialogLoadingSpinnerStateGk.currentState?.closeDialog();

    // 화면 정보 갱신
    refreshMemberScreenInfo();
  }

  // (토큰 리플레시)
  Future<void> onJwtRefreshSampleItemClickedAsync() async {
    GlobalKey<all_dialog_loading_spinner_state.DialogWidgetState>
        allDialogLoadingSpinnerStateGk = GlobalKey();

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => all_dialog_loading_spinner.DialogWidget(
            globalKey: allDialogLoadingSpinnerStateGk,
            inputVo: const all_dialog_loading_spinner.InputVo(),
            onDialogCreated: () async {})).then((outputVo) {});

    // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
    spw_auth_member_info.SharedPreferenceWrapperVo? loginMemberInfo =
        gf_my_functions.getNowVerifiedMemberInfo();

    if (loginMemberInfo == null) {
      refreshMemberScreenInfo();
    } else {
      // 리플레시 토큰 만료 여부 확인
      bool isRefreshTokenExpired = DateFormat('yyyy-MM-dd HH:mm:ss.SSS')
          .parse(loginMemberInfo.refreshTokenExpireWhen)
          .isBefore(DateTime.now());

      if (isRefreshTokenExpired) {
        // 리플래시 토큰이 사용 불가이므로 로그아웃 처리
        // login_user_info SPW 비우기
        spw_auth_member_info.SharedPreferenceWrapper.set(value: null);
        allDialogLoadingSpinnerStateGk.currentState?.closeDialog();

        refreshMemberScreenInfo();
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
            var postReissueResponseBody = networkResponseObjectOk.responseBody!
                as api_main_server
                .PostService1TkV1AuthReissueAsyncResponseBodyVo;

            // SPW 정보 갱신
            List<spw_auth_member_info.SharedPreferenceWrapperVoOAuth2Info>
                myOAuth2ObjectList = [];
            for (api_main_server
                .PostReissueAsyncResponseBodyVoOAuth2Info myOAuth2
                in postReissueResponseBody.myOAuth2List) {
              myOAuth2ObjectList
                  .add(spw_auth_member_info.SharedPreferenceWrapperVoOAuth2Info(
                myOAuth2.uid,
                myOAuth2.oauth2TypeCode,
                myOAuth2.oauth2Id,
              ));
            }

            List<spw_auth_member_info.SharedPreferenceWrapperVoProfileInfo>
                myProfileList = [];
            for (api_main_server.PostReissueAsyncResponseBodyVoProfile myProfile
                in postReissueResponseBody.myProfileList) {
              myProfileList.add(
                  spw_auth_member_info.SharedPreferenceWrapperVoProfileInfo(
                myProfile.uid,
                myProfile.imageFullUrl,
                myProfile.isFront,
              ));
            }

            List<spw_auth_member_info.SharedPreferenceWrapperVoEmailInfo>
                myEmailList = [];
            for (api_main_server.PostReissueAsyncResponseBodyVoEmail myEmail
                in postReissueResponseBody.myEmailList) {
              myEmailList
                  .add(spw_auth_member_info.SharedPreferenceWrapperVoEmailInfo(
                uid: myEmail.uid,
                emailAddress: myEmail.emailAddress,
                isFront: myEmail.isFront,
              ));
            }

            List<spw_auth_member_info.SharedPreferenceWrapperVoPhoneInfo>
                myPhoneNumberList = [];
            for (api_main_server.PostReissueAsyncResponseBodyVoPhone myPhone
                in postReissueResponseBody.myPhoneNumberList) {
              myPhoneNumberList
                  .add(spw_auth_member_info.SharedPreferenceWrapperVoPhoneInfo(
                uid: myPhone.uid,
                phoneNumber: myPhone.phoneNumber,
                isFront: myPhone.isFront,
              ));
            }

            loginMemberInfo.memberUid = postReissueResponseBody.memberUid;
            loginMemberInfo.nickName = postReissueResponseBody.nickName;
            loginMemberInfo.roleList = postReissueResponseBody.roleList;
            loginMemberInfo.tokenType = postReissueResponseBody.tokenType;
            loginMemberInfo.accessToken = postReissueResponseBody.accessToken;
            loginMemberInfo.accessTokenExpireWhen =
                postReissueResponseBody.accessTokenExpireWhen;
            loginMemberInfo.refreshToken = postReissueResponseBody.refreshToken;
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

            allDialogLoadingSpinnerStateGk.currentState?.closeDialog();

            refreshMemberScreenInfo();
          } else {
            var postReissueResponseHeader =
                networkResponseObjectOk.responseHeaders! as api_main_server
                    .PostService1TkV1AuthReissueAsyncResponseHeaderVo;

            // 비정상 응답
            if (postReissueResponseHeader.apiResultCode == null) {
              allDialogLoadingSpinnerStateGk.currentState?.closeDialog();

              // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
              GlobalKey<all_dialog_info_state.DialogWidgetState>
                  allDialogInfoGk = GlobalKey();
              if (!context.mounted) return;
              showDialog(
                  barrierDismissible: false,
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
              allDialogLoadingSpinnerStateGk.currentState?.closeDialog();

              // 서버 지정 에러 코드를 전달 받았을 때
              String apiResultCode = postReissueResponseHeader.apiResultCode!;

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

                    refreshMemberScreenInfo();
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

          // Dio 네트워크 에러
          final GlobalKey<all_dialog_info_state.DialogWidgetState>
              allDialogInfoGk = GlobalKey();
          if (!context.mounted) return;
          showDialog(
              barrierDismissible: false,
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
  }

  void onUserInfoItemClickedAsync() {
    context.pushNamed(all_page_member_info.pageName);
  }

  iw_member_info_widget.MemberInfoVo? getMemberInfoVo() {
    // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
    spw_auth_member_info.SharedPreferenceWrapperVo? loginMemberInfo =
        gf_my_functions.getNowVerifiedMemberInfo();

    if (loginMemberInfo == null) {
      return null;
    } else {
      return iw_member_info_widget.MemberInfoVo(
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

  void refreshMemberScreenInfo() {
    iwSampleListStateGk.currentState?.itemList = getItemList();
    iwSampleListStateGk.currentState?.refreshUi();

    iwMemberInfoWidgetStateGk.currentState?.memberInfoVo = getMemberInfoVo();
    iwMemberInfoWidgetStateGk.currentState?.refreshUi();
  }

// [private 함수]
}
