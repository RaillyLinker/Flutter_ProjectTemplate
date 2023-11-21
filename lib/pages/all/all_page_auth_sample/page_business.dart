// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

// (page)
import 'page_view.dart' as page_view;
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../../repositories/network/apis/api_main_server.dart'
    as api_main_server;
import '../../../../repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import '../../../dialogs/all/all_dialog_info/page_entrance.dart'
    as all_dialog_info;
import '../../../dialogs/all/all_dialog_loading_spinner/page_entrance.dart'
    as all_dialog_loading_spinner;
import '../../../pages/all/all_page_login/page_entrance.dart' as all_page_login;
import '../../../pages/all/all_page_member_info/page_entrance.dart'
    as all_page_member_info;
import '../../../pages/all/all_page_authorization_test_sample_list/page_entrance.dart'
    as all_page_authorization_test_sample_list;
import '../../../global_widgets/gw_custom_widgets.dart' as gw_custom_widgets;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageBusiness {
  PageBusiness(this._context) {
    pageViewModel = PageViewModel(_context);
  }

  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // 페이지 생명주기 관련 states
  final gc_template_classes.PageLifeCycleStates pageLifeCycleStates =
      gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터 (아래 goRouterState 에서 가져와 대입하기)
  late page_entrance.PageInputVo pageInputVo;

  // 페이지 뷰모델 객체
  late PageViewModel pageViewModel;

  ////
  // [페이지 생명주기]
  // - 페이지 최초 실행 : onPageCreateAsync -> onPageResumeAsync
  // - 다른 페이지 호출 / 복귀, 화면 끄기 / 켜기, 모바일에서 다른 앱으로 이동 및 복귀시 :
  // onPagePauseAsync -> onPageResumeAsync -> onPagePauseAsync -> onPageResumeAsync 반복
  // - 페이지 종료 : onPageWillPopAsync -(return true 일 때)-> onPagePauseAsync -> onPageDestroyAsync 실행

  // (onPageCreateAsync 실행 전 PageInputVo 체크)
  // onPageCreateAsync 과 완전히 동일하나, 입력값 체크만을 위해 분리한 생명주기
  Future<void> onCheckPageInputVoAsync(GoRouterState goRouterState) async {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   // 필수 파라미터가 없는 경우에 대한 처리
    // }

    // !!!PageInputVo 입력!!!
    pageInputVo = page_entrance.PageInputVo();
  }

  // (페이지 최초 실행)
  Future<void> onPageCreateAsync() async {
    // !!!페이지 최초 실행 로직 작성!!!
  }

  // (페이지 최초 실행 or 다른 페이지에서 복귀)
  Future<void> onPageResumeAsync() async {
    // !!!위젯 최초 실행 및, 다른 페이지에서 복귀 로직 작성!!!

    // 화면 갱신
    await refreshMainListAsync();
  }

  // (페이지 종료 or 다른 페이지로 이동 (강제 종료는 탐지 못함))
  Future<void> onPagePauseAsync() async {
    // !!!위젯 종료 및, 다른 페이지로 이동 로직 작성!!!
  }

  // (페이지 종료 (강제 종료, web 에서 브라우저 뒤로가기 버튼을 눌렀을 때는 탐지 못함))
  Future<void> onPageDestroyAsync() async {
    // !!!페이지 종료 로직 작성!!!
  }

  // (Page Pop 요청)
  // context.pop() 호출 직후 호출
  // return 이 true 라면 onWidgetPause 부터 onPageDestroyAsync 까지 실행 되며 페이지 종료
  // return 이 false 라면 pop 되지 않고 그대로 대기
  Future<bool> onPageWillPopAsync() async {
    // !!!onWillPop 로직 작성!!!

    return true;
  }

////
// [비즈니스 함수]
// !!!외부에서 사용할 비즈니스 로직은 아래에 공개 함수로 구현!!!
  // (메인 리스트 갱신 함수)
  Future<void> refreshMainListAsync() async {
    // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
    spw_auth_member_info.SharedPreferenceWrapperVo? nowLoginMemberInfo =
        gf_my_functions.getNowVerifiedMemberInfo();

    pageViewModel.loginMemberInfo = nowLoginMemberInfo;

    List<page_view.MainListWidgetViewModelMainItemVo> nowAllSampleList = [];
    nowAllSampleList.add(page_view.MainListWidgetViewModelMainItemVo(
        "인증 / 인가 네트워크 요청 테스트 샘플 리스트", "인증 / 인가 상태에서 네트워크 요청 및 응답 처리 테스트 샘플 리스트",
        gw_custom_widgets.HoverListTileWrapperBusiness(
            onRouteListItemClick: () async {
      // 인증/인가 테스트 샘플 페이지로 이동
      _context.pushNamed(all_page_authorization_test_sample_list.pageName);
    })));
    if (pageViewModel.loginMemberInfo == null) {
      nowAllSampleList.add(page_view.MainListWidgetViewModelMainItemVo(
          "로그인 페이지", "로그인 페이지로 이동합니다.",
          gw_custom_widgets.HoverListTileWrapperBusiness(
              onRouteListItemClick: () async {
        // 계정 로그인 페이지로 이동
        _context.pushNamed(all_page_login.pageName);
      })));
    } else {
      nowAllSampleList.add(
          page_view.MainListWidgetViewModelMainItemVo("로그아웃", "로그아웃 처리를 합니다.",
              gw_custom_widgets.HoverListTileWrapperBusiness(
                  onRouteListItemClick: () async {
        // 계정 로그아웃 처리
        var loadingSpinner = all_dialog_loading_spinner.PageEntrance(
          all_dialog_loading_spinner.PageInputVo(),
        );

        showDialog(
            barrierDismissible: false,
            context: _context,
            builder: (context) => loadingSpinner).then((outputVo) {});

        spw_auth_member_info.SharedPreferenceWrapperVo? loginMemberInfo =
            spw_auth_member_info.SharedPreferenceWrapper.get();

        if (loginMemberInfo != null) {
          // 서버 Logout API 실행
          spw_auth_member_info.SharedPreferenceWrapperVo? loginMemberInfo =
              spw_auth_member_info.SharedPreferenceWrapper.get();
          await api_main_server.postService1TkV1AuthLogoutAsync(
              requestHeaderVo: api_main_server
                  .PostService1TkV1AuthLogoutAsyncRequestHeaderVo(
                      authorization:
                          "${loginMemberInfo!.tokenType} ${loginMemberInfo.accessToken}"));

          // login_user_info SPW 비우기
          spw_auth_member_info.SharedPreferenceWrapper.set(value: null);
        }

        loadingSpinner.pageBusiness.closeDialog();

        refreshMainListAsync();
      })));
      nowAllSampleList.add(page_view.MainListWidgetViewModelMainItemVo(
          "모든 디바이스에서 로그아웃", "현재 로그인된 모든 디바이스의 리프레시 토큰을 만료 처리 합니다.",
          gw_custom_widgets.HoverListTileWrapperBusiness(
              onRouteListItemClick: () async {
        // 모든 디바이스에서 계정 로그아웃 처리
        var loadingSpinner = all_dialog_loading_spinner.PageEntrance(
          all_dialog_loading_spinner.PageInputVo(),
        );

        if (!_context.mounted) return;
        showDialog(
            barrierDismissible: false,
            context: _context,
            builder: (context) => loadingSpinner).then((outputVo) {});

        spw_auth_member_info.SharedPreferenceWrapperVo? loginMemberInfo =
            spw_auth_member_info.SharedPreferenceWrapper.get();

        if (loginMemberInfo != null) {
          // All Logout API 실행
          spw_auth_member_info.SharedPreferenceWrapperVo? loginMemberInfo =
              spw_auth_member_info.SharedPreferenceWrapper.get();

          await api_main_server.deleteService1TkV1AuthAllAuthorizationTokenAsync(
              requestHeaderVo: api_main_server
                  .DeleteService1TkV1AuthAllAuthorizationTokenAsyncRequestHeaderVo(
                      authorization:
                          "${loginMemberInfo!.tokenType} ${loginMemberInfo.accessToken}"));

          // login_user_info SPW 비우기
          spw_auth_member_info.SharedPreferenceWrapper.set(value: null);
        }

        loadingSpinner.pageBusiness.closeDialog();

        refreshMainListAsync();
      })));
      nowAllSampleList.add(page_view.MainListWidgetViewModelMainItemVo(
          "인증 토큰 갱신", "인증 토큰을 갱신합니다.",
          gw_custom_widgets.HoverListTileWrapperBusiness(
              onRouteListItemClick: () async {
        // (토큰 리플레시)
        var loadingSpinner = all_dialog_loading_spinner.PageEntrance(
          all_dialog_loading_spinner.PageInputVo(),
        );

        if (!_context.mounted) return;
        showDialog(
            barrierDismissible: false,
            context: _context,
            builder: (context) => loadingSpinner).then((outputVo) {});

        spw_auth_member_info.SharedPreferenceWrapperVo? loginMemberInfo =
            spw_auth_member_info.SharedPreferenceWrapper.get();

        if (loginMemberInfo == null) {
          refreshMainListAsync();
        } else {
          // 리플레시 토큰 만료 여부 확인
          bool isRefreshTokenExpired = DateFormat('yyyy-MM-dd HH:mm:ss.SSS')
              .parse(loginMemberInfo.refreshTokenExpireWhen)
              .isBefore(DateTime.now());

          if (isRefreshTokenExpired) {
            // 리플래시 토큰이 사용 불가이므로 로그아웃 처리
            // login_user_info SPW 비우기
            spw_auth_member_info.SharedPreferenceWrapper.set(value: null);

            loadingSpinner.pageBusiness.closeDialog();

            refreshMainListAsync();
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

            loadingSpinner.pageBusiness.closeDialog();

            // 네트워크 요청 결과 처리
            if (postAutoLoginOutputVo.dioException == null) {
              // Dio 네트워크 응답
              var networkResponseObjectOk =
                  postAutoLoginOutputVo.networkResponseObjectOk!;

              if (networkResponseObjectOk.responseStatusCode == 200) {
                // 정상 응답

                // 응답 Body
                var postReissueResponseBody =
                    networkResponseObjectOk.responseBody! as api_main_server
                        .PostService1TkV1AuthReissueAsyncResponseBodyVo;

                // SPW 정보 갱신
                List<spw_auth_member_info.SharedPreferenceWrapperVoOAuth2Info>
                    myOAuth2ObjectList = [];
                for (api_main_server
                    .PostReissueAsyncResponseBodyVoOAuth2Info myOAuth2
                    in postReissueResponseBody.myOAuth2List) {
                  myOAuth2ObjectList.add(
                      spw_auth_member_info.SharedPreferenceWrapperVoOAuth2Info(
                    myOAuth2.uid,
                    myOAuth2.oauth2TypeCode,
                    myOAuth2.oauth2Id,
                  ));
                }

                List<spw_auth_member_info.SharedPreferenceWrapperVoProfileInfo>
                    myProfileList = [];
                for (api_main_server
                    .PostReissueAsyncResponseBodyVoProfile myProfile
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
                  myEmailList.add(
                      spw_auth_member_info.SharedPreferenceWrapperVoEmailInfo(
                    uid: myEmail.uid,
                    emailAddress: myEmail.emailAddress,
                    isFront: myEmail.isFront,
                  ));
                }

                List<spw_auth_member_info.SharedPreferenceWrapperVoPhoneInfo>
                    myPhoneNumberList = [];
                for (api_main_server.PostReissueAsyncResponseBodyVoPhone myPhone
                    in postReissueResponseBody.myPhoneNumberList) {
                  myPhoneNumberList.add(
                      spw_auth_member_info.SharedPreferenceWrapperVoPhoneInfo(
                    uid: myPhone.uid,
                    phoneNumber: myPhone.phoneNumber,
                    isFront: myPhone.isFront,
                  ));
                }

                loginMemberInfo.memberUid = postReissueResponseBody.memberUid;
                loginMemberInfo.nickName = postReissueResponseBody.nickName;
                loginMemberInfo.roleList = postReissueResponseBody.roleList;
                loginMemberInfo.tokenType = postReissueResponseBody.tokenType;
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

                refreshMainListAsync();
              } else {
                var postReissueResponseHeader =
                    networkResponseObjectOk.responseHeaders! as api_main_server
                        .PostService1TkV1AuthReissueAsyncResponseHeaderVo;

                // 비정상 응답
                if (postReissueResponseHeader.apiResultCode == null) {
                  // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
                  if (!_context.mounted) return;
                  showDialog(
                      barrierDismissible: false,
                      context: _context,
                      builder: (context) => all_dialog_info.PageEntrance(
                            all_dialog_info.PageInputVo("네트워크 에러",
                                "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "확인"),
                          ));
                } else {
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

                        refreshMainListAsync();
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
              // Dio 네트워크 에러
              if (!_context.mounted) return;
              showDialog(
                  barrierDismissible: false,
                  context: _context,
                  builder: (context) => all_dialog_info.PageEntrance(
                        all_dialog_info.PageInputVo(
                            "네트워크 에러", "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "확인"),
                      ));
            }
          }
        }
      })));
      nowAllSampleList.add(page_view.MainListWidgetViewModelMainItemVo(
          "회원 정보 페이지로 이동", "회원 정보 페이지로 이동합니다.",
          gw_custom_widgets.HoverListTileWrapperBusiness(
              onRouteListItemClick: () async {
        // 회원정보 페이지로 이동
        if (!_context.mounted) return;
        _context.pushNamed(all_page_member_info.pageName);
      })));
    }

    pageViewModel.mainListWidgetViewModel
        .mainListWidgetViewModelMainItemVoList = nowAllSampleList;

    pageViewModel.memberInfoWidgetViewModel.memberUid =
        pageViewModel.loginMemberInfo?.memberUid.toString();
    pageViewModel.memberInfoWidgetViewModel.tokenType =
        pageViewModel.loginMemberInfo?.tokenType.toString();
    pageViewModel.memberInfoWidgetViewModel.accessToken =
        pageViewModel.loginMemberInfo?.accessToken.toString();
    pageViewModel.memberInfoWidgetViewModel.accessTokenExpireWhen =
        pageViewModel.loginMemberInfo?.accessTokenExpireWhen.toString();
    pageViewModel.memberInfoWidgetViewModel.refreshToken =
        pageViewModel.loginMemberInfo?.refreshToken.toString();
    pageViewModel.memberInfoWidgetViewModel.refreshTokenExpireWhen =
        pageViewModel.loginMemberInfo?.refreshTokenExpireWhen.toString();

    pageViewModel.mainListWidgetStateGk.currentState?.refresh();
    pageViewModel.memberInfoWidgetStateGk.currentState?.refresh();
  }

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!!
}

// (페이지 뷰 모델 클래스)
// 페이지 전역의 데이터는 여기에 정의되며, Business 인스턴스 안의 pageViewModel 변수로 저장 됩니다.
class PageViewModel {
  PageViewModel(this._context);

  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!페이지 데이터 정의!!!
  // ex :
  // GlobalKey<SampleWidgetState> sampleWidgetStateGk = GlobalKey();
  // SampleWidgetViewModel sampleWidgetViewModel = SampleWidgetViewModel();

  GlobalKey<page_view.MemberInfoWidgetState> memberInfoWidgetStateGk =
      GlobalKey();
  page_view.MemberInfoWidgetViewModel memberInfoWidgetViewModel =
      page_view.MemberInfoWidgetViewModel();

  GlobalKey<page_view.MainListWidgetState> mainListWidgetStateGk = GlobalKey();
  page_view.MainListWidgetViewModel mainListWidgetViewModel =
      page_view.MainListWidgetViewModel();

  // PageOutFrameViewModel
  gw_page_out_frames.PageOutFrameBusiness pageOutFrameBusiness =
      gw_page_out_frames.PageOutFrameBusiness();

  // 현재 페이지의 유저 정보
  spw_auth_member_info.SharedPreferenceWrapperVo? loginMemberInfo;
}
