// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../../repositories/spws/spw_sign_in_member_info.dart'
    as spw_sign_in_member_info;
import '../../../../repositories/network/apis/api_main_server.dart'
    as api_main_server;
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;
import '../../../dialogs/all/all_dialog_info/page_entrance.dart'
    as all_dialog_info;
import '../../../dialogs/all/all_dialog_loading_spinner/page_entrance.dart'
    as all_dialog_loading_spinner;
import '../../../pages/all/all_page_sign_in/page_entrance.dart'
    as all_page_sign_in;
import '../../../pages/all/all_page_authorization_test_sample/page_entrance.dart'
    as all_page_authorization_test_sample;
import '../../../pages/all/all_page_membership_withdrawal/page_entrance.dart'
    as all_page_membership_withdrawal;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../pages/all/all_page_change_password/page_entrance.dart'
    as all_page_change_password;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 및 뷰모델 담당
// PageBusiness 인스턴스는 PageView 가 재생성 되어도 재활용이 되며 PageViewModel 인스턴스 역시 유지됨.
class PageBusiness {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // 페이지 뷰모델 (StateFul 위젯 State 데이터는 모두 여기에 저장됨)
  late PageViewModel pageViewModel;

  // BLoC 객체 모음
  late BLocObjects blocObjects;

  // 생성자 설정
  PageBusiness(this._context, GoRouterState goRouterState) {
    pageViewModel = PageViewModel(goRouterState);
  }

  ////
  // [페이지 생명주기]
  // - 페이지 최초 실행 : onPageCreateAsync -> onPageResumeAsync
  // - 다른 페이지 호출 / 복귀, 화면 끄기 / 켜기, 모바일에서 다른 앱으로 이동 및 복귀시 :
  // onPagePauseAsync -> onPageResumeAsync -> onPagePauseAsync -> onPageResumeAsync 반복
  // - 페이지 종료 : onPageWillPopAsync -(return true 일 때)-> onPagePauseAsync -> onPageDestroyAsync 실행

  // (페이지 최초 실행)
  Future<void> onPageCreateAsync() async {
    // !!!페이지 최초 실행 로직 작성!!

    // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
    spw_sign_in_member_info.SharedPreferenceWrapperVo? nowSignInMemberInfo =
        gf_my_functions.getNowVerifiedMemberInfo();

    // 화면 갱신
    await refreshScreenDataAsync(nowSignInMemberInfo);
  }

  // (페이지 최초 실행 or 다른 페이지에서 복귀)
  Future<void> onPageResumeAsync() async {
    // !!!위젯 최초 실행 및, 다른 페이지에서 복귀 로직 작성!!

    // 검증된 현재 회원 정보 가져오기 (비회원이라면 null)
    spw_sign_in_member_info.SharedPreferenceWrapperVo? nowSignInMemberInfo =
        gf_my_functions.getNowVerifiedMemberInfo();

    String? nowMemberUid =
        ((nowSignInMemberInfo == null) ? null : nowSignInMemberInfo.memberUid);

    if (pageViewModel.screenMemberUid != nowMemberUid) {
      // 현재 유저 정보와 페이지에 저장된 유저 정보가 다를 때

      // 화면 갱신
      await refreshScreenDataAsync(nowSignInMemberInfo);
    }
  }

  // (페이지 종료 or 다른 페이지로 이동 (강제 종료는 탐지 못함))
  Future<void> onPagePauseAsync() async {
    // !!!위젯 종료 및, 다른 페이지로 이동 로직 작성!!
  }

  // (페이지 종료 (강제 종료는 탐지 못함))
  Future<void> onPageDestroyAsync() async {
    // !!!페이지 종료 로직 작성!!

    // 검색창 컨트롤러 닫기
    pageViewModel.sampleSearchBarTextEditController.dispose();
  }

  // (Page Pop 요청)
  // context.pop() 호출 직후 호출
  // return 이 true 라면 onWidgetPause 부터 onPageDestroyAsync 까지 실행 되며 페이지 종료
  // return 이 false 라면 pop 되지 않고 그대로 대기
  Future<bool> onPageWillPopAsync() async {
    // !!!onWillPop 로직 작성!!

    return true;
  }

////
// [비즈니스 함수]
// !!!외부에서 사용할 비즈니스 로직은 아래에 공개 함수로 구현!!
// ex :
//   void changeSampleNumber(int newSampleNumber) {
//     // 뷰모델 state 변경
//     pageViewModel.sampleNumber = newSampleNumber;
//     // 위젯 변경 트리거 발동
//     bLocObjects.blocSample.add(!bLocObjects.blocSample.state);
//   }

  // (화면 전역 갱신 함수)
  // 화면 전역의 StateFul 위젯의 정보 변경 처리는 여기에 모아 두어야 전체 Refresh 가 편함.
  Future<void> refreshScreenDataAsync(
      spw_sign_in_member_info.SharedPreferenceWrapperVo?
          nowSignInMemberInfo) async {
    pageViewModel.signInMemberInfo = nowSignInMemberInfo;
    blocObjects.blocSignInMemberInfo
        .add(!blocObjects.blocSignInMemberInfo.state);

    List<SampleItem> nowAllSampleList = [];
    nowAllSampleList.add(SampleItem(
        SampleItemEnum.goToAuthorizationTestSamplePage,
        "Go to Authorization Test Sample Page",
        "Sample Network Requests by Authentication/Authorization"));
    if (nowSignInMemberInfo == null) {
      nowAllSampleList.add(SampleItem(SampleItemEnum.goToSignInPage,
          "Go to Sign in page", "Go to login page"));
    } else {
      nowAllSampleList
          .add(SampleItem(SampleItemEnum.signOut, "Sign out", "Sign out"));
      nowAllSampleList.add(SampleItem(SampleItemEnum.refreshAuthToken,
          "Refresh AuthToken", "Authentication Token Renewal"));
      nowAllSampleList.add(SampleItem(
          SampleItemEnum.goToMembershipWithdrawalPage,
          "Go to Membership Withdrawal Page",
          "Go to Membership Withdrawal Page"));
      nowAllSampleList.add(SampleItem(SampleItemEnum.goToChangeNicknamePage,
          "Go to Change Nickname Page", "Go to the nickname change page"));
      nowAllSampleList.add(SampleItem(SampleItemEnum.goToChangePasswordPage,
          "Go to Change Password Page", "Go to the password change page"));
      nowAllSampleList.add(SampleItem(SampleItemEnum.goToAddEmailPage,
          "Go to Add Email Page", "Go to Add Email page"));
      nowAllSampleList.add(SampleItem(SampleItemEnum.goToDeleteEmailPage,
          "Go to Delete Email Page", "Go to Email Delete page"));
      nowAllSampleList.add(SampleItem(SampleItemEnum.goToAddPhoneNumberPage,
          "Go to Add PhoneNumber Page", "Go to Add Phone Number page"));
      nowAllSampleList.add(SampleItem(
          SampleItemEnum.goToDeletePhoneNumberPage,
          "Go to Delete PhoneNumber Page",
          "Go to the Delete Phone Number page"));
    }

    pageViewModel.allSampleList = nowAllSampleList;
    blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);

    String? nowMemberUid =
        ((nowSignInMemberInfo == null) ? null : nowSignInMemberInfo.memberUid);
    pageViewModel.screenMemberUid = nowMemberUid;
  }

  // (리스트 아이템 클릭 리스너)
  void onRouteListItemClick(int index) {
    SampleItem sampleItem = pageViewModel.allSampleList[index];

    switch (sampleItem.sampleItemEnum) {
      case SampleItemEnum.goToAuthorizationTestSamplePage:
        {
          // 인증/인가 테스트 샘플 페이지로 이동
          _context.pushNamed(all_page_authorization_test_sample.pageName);
        }
        break;
      case SampleItemEnum.goToSignInPage:
        {
          // 계정 로그인 페이지로 이동
          _context.pushNamed(all_page_sign_in.pageName);
        }
        break;
      case SampleItemEnum.signOut:
        {
          // 계정 로그아웃 처리
          var loadingSpinner = all_dialog_loading_spinner.PageEntrance(
              all_dialog_loading_spinner.PageInputVo(), (pageBusiness) async {
            spw_sign_in_member_info.SharedPreferenceWrapperVo?
                signInMemberInfo =
                spw_sign_in_member_info.SharedPreferenceWrapper.get();

            if (signInMemberInfo != null) {
              // 서버 Logout API 실행
              spw_sign_in_member_info.SharedPreferenceWrapperVo?
                  signInMemberInfo =
                  spw_sign_in_member_info.SharedPreferenceWrapper.get();
              await api_main_server.postSignOutAsync(
                  api_main_server.PostSignOutAsyncRequestHeaderVo(
                      "${signInMemberInfo!.tokenType} ${signInMemberInfo.accessToken}"));

              // login_user_info SPW 비우기
              spw_sign_in_member_info.SharedPreferenceWrapper.set(null);

              pageBusiness.closeDialog();

              // 비회원으로 전체 화면 갱신
              refreshScreenDataAsync(null);
            }
          });

          showDialog(
              barrierDismissible: false,
              context: _context,
              builder: (context) => loadingSpinner).then((outputVo) {});
        }
        break;
      case SampleItemEnum.refreshAuthToken:
        {
          // (토큰 리플레시)
          var loadingSpinner = all_dialog_loading_spinner.PageEntrance(
              all_dialog_loading_spinner.PageInputVo(), (pageBusiness) async {
            spw_sign_in_member_info.SharedPreferenceWrapperVo?
                signInMemberInfo =
                spw_sign_in_member_info.SharedPreferenceWrapper.get();

            if (signInMemberInfo == null) {
              throw Exception("signInMemberInfo must not be null");
            } else {
              // 리플레시 토큰 만료 여부 확인
              bool isRefreshTokenExpired = DateFormat('yyyy-MM-dd HH:mm:ss.SSS')
                  .parse(signInMemberInfo.refreshTokenExpireWhen)
                  .isBefore(DateTime.now());

              if (isRefreshTokenExpired) {
                // 리플래시 토큰이 사용 불가이므로 로그아웃 처리
                // login_user_info SPW 비우기
                spw_sign_in_member_info.SharedPreferenceWrapper.set(null);

                pageBusiness.closeDialog();

                // 비회원으로 전체 화면 갱신
                refreshScreenDataAsync(null);
              } else {
                var postAutoLoginOutputVo = await api_main_server.postReissueAsync(
                    api_main_server.PostReissueAsyncRequestHeaderVo(
                        "${signInMemberInfo.tokenType} ${signInMemberInfo.accessToken}"),
                    api_main_server.PostReissueAsyncRequestBodyVo(
                        "${signInMemberInfo.tokenType} ${signInMemberInfo.refreshToken}"));

                pageBusiness.closeDialog();

                // 네트워크 요청 결과 처리
                if (postAutoLoginOutputVo.dioException == null) {
                  // Dio 네트워크 응답
                  var networkResponseObjectOk =
                      postAutoLoginOutputVo.networkResponseObjectOk!;

                  if (networkResponseObjectOk.responseStatusCode == 200) {
                    // 정상 응답
                    // SPW 정보 갱신
                    List<
                            spw_sign_in_member_info
                            .SharedPreferenceWrapperVoOAuth2Info>
                        myOAuth2ObjectList = [];
                    for (api_main_server
                        .PostReissueAsyncResponseBodyVoOAuth2Info myOAuth2
                        in postAutoLoginOutputVo.networkResponseObjectOk!
                            .responseBody!.myOAuth2List) {
                      myOAuth2ObjectList.add(spw_sign_in_member_info
                          .SharedPreferenceWrapperVoOAuth2Info(
                              myOAuth2.oauth2TypeCode, myOAuth2.oauth2Id));
                    }
                    signInMemberInfo.memberUid = postAutoLoginOutputVo
                        .networkResponseObjectOk!.responseBody!.memberUid;
                    signInMemberInfo.nickName = postAutoLoginOutputVo
                        .networkResponseObjectOk!.responseBody!.nickName;
                    signInMemberInfo.roleCodeList = postAutoLoginOutputVo
                        .networkResponseObjectOk!.responseBody!.roleCodeList;
                    signInMemberInfo.tokenType = postAutoLoginOutputVo
                        .networkResponseObjectOk!.responseBody!.tokenType;
                    signInMemberInfo.accessToken = postAutoLoginOutputVo
                        .networkResponseObjectOk!.responseBody!.accessToken;
                    signInMemberInfo.accessTokenExpireWhen =
                        postAutoLoginOutputVo.networkResponseObjectOk!
                            .responseBody!.accessTokenExpireWhen;
                    signInMemberInfo.refreshToken = postAutoLoginOutputVo
                        .networkResponseObjectOk!.responseBody!.refreshToken;
                    signInMemberInfo.refreshTokenExpireWhen =
                        postAutoLoginOutputVo.networkResponseObjectOk!
                            .responseBody!.refreshTokenExpireWhen;
                    signInMemberInfo.myEmailList = postAutoLoginOutputVo
                        .networkResponseObjectOk!.responseBody!.myEmailList;
                    signInMemberInfo.myPhoneNumberList = postAutoLoginOutputVo
                        .networkResponseObjectOk!
                        .responseBody!
                        .myPhoneNumberList;
                    signInMemberInfo.myOAuth2List = myOAuth2ObjectList;
                    spw_sign_in_member_info.SharedPreferenceWrapper.set(
                        signInMemberInfo);

                    refreshScreenDataAsync(signInMemberInfo);
                  } else {
                    // 비정상 응답
                    if (networkResponseObjectOk.responseHeaders.apiErrorCodes ==
                        null) {
                      // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
                      if (!_context.mounted) return;
                      showDialog(
                          barrierDismissible: false,
                          context: _context,
                          builder: (context) => all_dialog_info.PageEntrance(
                              all_dialog_info.PageInputVo(
                                  "네트워크 에러",
                                  "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                                  "확인"),
                              (pageBusiness) {}));
                    } else {
                      // 서버 지정 에러 코드를 전달 받았을 때
                      List<String> apiErrorCodes =
                          networkResponseObjectOk.responseHeaders.apiErrorCodes;
                      if (apiErrorCodes.contains("1") || // 유효하지 않은 리플래시 토큰
                              apiErrorCodes.contains("2") || // 리플래시 토큰 만료
                              apiErrorCodes
                                  .contains("3") || // 리플래시 토큰이 액세스 토큰과 매칭되지 않음
                              apiErrorCodes.contains("4") // 가입되지 않은 회원
                          ) {
                        // 리플래시 토큰이 사용 불가이므로 로그아웃 처리
                        // login_user_info SPW 비우기
                        spw_sign_in_member_info.SharedPreferenceWrapper.set(
                            null);

                        // 비회원으로 전체 화면 갱신
                        refreshScreenDataAsync(null);
                      } else {
                        // 알 수 없는 에러 코드일 때
                        throw Exception("unKnown Error Code");
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
                              "네트워크 에러",
                              "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                              "확인"),
                          (pageBusiness) {}));
                }
              }
            }
          });

          showDialog(
              barrierDismissible: false,
              context: _context,
              builder: (context) => loadingSpinner).then((outputVo) {});
        }
        break;
      case SampleItemEnum.goToMembershipWithdrawalPage:
        {
          // 회원탈퇴 페이지로 이동
          _context.pushNamed(all_page_membership_withdrawal.pageName);
        }
        break;
      case SampleItemEnum.goToChangeNicknamePage:
        {
          // 닉네임 변경 페이지로 이동
          // todo
        }
        break;
      case SampleItemEnum.goToChangePasswordPage:
        {
          // 비밀번호 변경 페이지로 이동
          _context.pushNamed(all_page_change_password.pageName);
        }
        break;
      case SampleItemEnum.goToAddEmailPage:
        {
          // 이메일 추가 페이지로 이동
          // todo
        }
        break;
      case SampleItemEnum.goToDeleteEmailPage:
        {
          // 이메일 삭제 페이지로 이동
          // todo
        }
        break;
      case SampleItemEnum.goToAddPhoneNumberPage:
        {
          // 전화번호 추가 페이지로 이동
          // todo
        }
        break;
      case SampleItemEnum.goToDeletePhoneNumberPage:
        {
          // 전화번호 삭제 페이지로 이동
          // todo
        }
        break;
    }
  }

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!
}

// (페이지 뷰 모델 데이터 형태)
// 페이지의 모든 화면 관련 데이터는 여기에 정의되며, Business 인스턴스 안에 객체로 저장 됩니다.
class PageViewModel {
  // 페이지 생명주기 관련 states
  var pageLifeCycleStates = gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터 (아래 goRouterState 에서 가져와 대입하기)
  late page_entrance.PageInputVo pageInputVo;
  GoRouterState goRouterState;

  // !!!페이지 데이터 정의!!
  // ex :
  // int sampleNumber = 0;

  // 현 페이지를 갱신한 시점의 멤버 고유값 (비회원은 null)
  String? screenMemberUid;

  spw_sign_in_member_info.SharedPreferenceWrapperVo? signInMemberInfo;

  // 샘플 목록 필터링용 검색창 컨트롤러 (검색창의 텍스트 정보를 가지고 있으므로 뷰모델에 저장, 여기 있어야 위젯이 변경되어도 검색어가 유지됨)
  TextEditingController sampleSearchBarTextEditController =
      TextEditingController();

  // (샘플 페이지 원본 리스트)
  List<SampleItem> allSampleList = [];

  PageViewModel(this.goRouterState);
}

class SampleItem {
  // 샘플 고유값
  SampleItemEnum sampleItemEnum;

  // 샘플 타이틀
  String sampleItemTitle;

  // 샘플 설명
  String sampleItemDescription;

  // 권한 체크 여부
  bool isChecked = false;

  SampleItem(
      this.sampleItemEnum, this.sampleItemTitle, this.sampleItemDescription);
}

enum SampleItemEnum {
  goToAuthorizationTestSamplePage,
  goToSignInPage,
  signOut,
  refreshAuthToken,
  goToMembershipWithdrawalPage,
  goToChangeNicknamePage,
  goToChangePasswordPage,
  goToAddEmailPage,
  goToDeleteEmailPage,
  goToAddPhoneNumberPage,
  goToDeletePhoneNumberPage,
}

// (BLoC 클래스 모음)
// 아래엔 런타임 위젯 변경의 트리거가 되는 BLoC 클래스들을 작성해 둡니다.
// !!!각 BLoC 클래스는 아래 예시를 '그대로' 복사 붙여넣기를 하여 클래스 이름만 변경합니다.!!
// ex :
// class BlocSample extends Bloc<bool, bool> {
//   BlocSample() : super(true) {
//     on<bool>((event, emit) {
//       emit(event);
//     });
//   }
// }

class BlocSignInMemberInfo extends Bloc<bool, bool> {
  BlocSignInMemberInfo() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

class BlocSampleList extends Bloc<bool, bool> {
  BlocSampleList() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

// (BLoC 프로바이더 클래스)
// 본 페이지에서 사용할 BLoC 객체를 모아두어 PageEntrance 에서 페이지 전역 설정에 사용 됩니다.
class BLocProviders {
// !!!위에 정의된 BLoC 클래스들에 대한 Provider 객체들을 아래 리스트에 모두 넣어줄 것!!
  List<BlocProvider<dynamic>> blocProviders = [
    // ex :
    // BlocProvider<BlocSample>(create: (context) => BlocSample()),
    BlocProvider<BlocSampleList>(create: (context) => BlocSampleList()),
    BlocProvider<BlocSignInMemberInfo>(
        create: (context) => BlocSignInMemberInfo()),
  ];
}

class BLocObjects {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!
  // ex :
  // late BlocSample blocSample;
  late BlocSampleList blocSampleList;
  late BlocSignInMemberInfo blocSignInMemberInfo;

  // 생성자 설정
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocSampleList = BlocProvider.of<BlocSampleList>(_context);
    blocSignInMemberInfo = BlocProvider.of<BlocSignInMemberInfo>(_context);
  }
}
