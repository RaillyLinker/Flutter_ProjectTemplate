// (external)
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;
import '../../../../../repositories/network/apis/api_main_server.dart'
    as api_main_server;
import '../../../../../repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import '../../../dialogs/all/all_dialog_info/page_entrance.dart'
    as all_dialog_info;
import '../../../dialogs/all/all_dialog_yes_or_no/page_entrance.dart'
    as all_dialog_yes_or_no;
import '../../../global_classes/gc_my_classes.dart' as gc_my_classes;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../global_data/gd_const_config.dart' as gd_const_config;
import '../../../pages/all/all_page_home/page_entrance.dart' as all_page_home;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]
// todo : BLoC to Stateful

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 context 안에 저장되어, 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageBusiness {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // BLoC 객체 모음
  late BLocObjects blocObjects;

  // 페이지 생명주기 관련 states
  var pageLifeCycleStates = gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터 (아래 goRouterState 에서 가져와 대입하기)
  late page_entrance.PageInputVo pageInputVo;

  // 페이지 뷰모델 객체
  PageViewModel pageViewModel = PageViewModel();

  // 화면 대기 시간 카운트 객체
  Timer? _screenWaitingTimer;

  // 앱 초기화 로직 스레드 합류 객체 (비동기로 진행되는 화면 대기 타이머와 초기화 로직이 모두 끝나면 콜백이 실행됨)
  // _appInitLogicThreadConfluenceObj.threadComplete(); 이 함수가 2번 호출되어야 콜백이 실행됨
  late final gc_my_classes.ThreadConfluenceObj
      _appInitLogicThreadConfluenceObj =
      gc_my_classes.ThreadConfluenceObj(2, () {
    _onAppInitLogicThreadComplete();
  });

  // 생성자 설정
  PageBusiness(this._context);

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

    await _checkAppVersionAsync();
  }

  // (페이지 최초 실행 or 다른 페이지에서 복귀)
  Future<void> onPageResumeAsync() async {
    // !!!위젯 최초 실행 및, 다른 페이지에서 복귀 로직 작성!!!
    // 화면 대기시간 카운팅 개시/재개 (비동기 카운팅)
    _countDownScreenWaitingTime();
  }

  // (페이지 종료 or 다른 페이지로 이동 (강제 종료는 탐지 못함))
  Future<void> onPagePauseAsync() async {
    // !!!위젯 종료 및, 다른 페이지로 이동 로직 작성!!!
    // 화면 대기시간 카운팅 멈추기
    _screenWaitingTimer?.cancel();
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
// ex :
//   void changeSampleNumber(int newSampleNumber) {
//     // BLoC 위젯 관련 상태 변수 변경
//     pageViewModel.sampleNumber = newSampleNumber;
//     // BLoC 위젯 변경 트리거 발동
//     blocObjects.blocSample.refresh();
//   }

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!!

  // (스크린 대기시간 비동기 카운트 다운)
  void _countDownScreenWaitingTime() {
    if (pageViewModel.countNumber <= 0) {
      _screenWaitingTimer?.cancel();
      // 스레드 완료를 알리기
      _appInitLogicThreadConfluenceObj.threadComplete();
    } else {
      _screenWaitingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        // 뷰모델 State 변경 및 자동 이벤트 발동
        pageViewModel.countNumber = pageViewModel.countNumber - 1;
        blocObjects.blocCountDownNumber.refresh();

        if (pageViewModel.countNumber <= 0) {
          // 카운팅 완료
          timer.cancel();
          // 스레드 완료를 알리기
          _appInitLogicThreadConfluenceObj.threadComplete();
        }
      });
    }
  }

  // (앱 버전 확인)
  Future<void> _checkAppVersionAsync() async {
    // 플랫폼 코드 (1 : web, 2 : android, 3 : ios, 4 : windows, 5 : macos, 6 : linux)
    int platformCode;

    // pubspec.yaml - version (ex : 1.0.0)
    String currentAppVersion;

    // 플랫폼별 정보 대입
    if (kIsWeb) {
      // Web 일때
      platformCode = 1;
      currentAppVersion = gd_const_config.webClientVersion;
    } else {
      if (Platform.isAndroid) {
        // Android 일때
        platformCode = 2;
        currentAppVersion = gd_const_config.androidClientVersion;
      } else if (Platform.isIOS) {
        // Ios 일때
        platformCode = 3;
        currentAppVersion = gd_const_config.iosClientVersion;
      } else if (Platform.isWindows) {
        // Windows 일때
        platformCode = 4;
        currentAppVersion = gd_const_config.windowsClientVersion;
      } else if (Platform.isMacOS) {
        // MacOS 일때
        platformCode = 5;
        currentAppVersion = gd_const_config.macOsClientVersion;
      } else if (Platform.isLinux) {
        // Linux 일때
        platformCode = 6;
        currentAppVersion = gd_const_config.linuxClientVersion;
      } else {
        // 그외
        throw Exception("unSupported Platform");
      }
    }

    // 서버 앱 버전 정보 가져오기
    var responseVo = await api_main_server.getClientApplicationVersionInfoAsync(
        api_main_server.GetMobileAppVersionInfoAsyncRequestQueryVo(
            platformCode));

    // 네트워크 요청 결과 처리
    if (responseVo.dioException == null) {
      // Dio 네트워크 응답
      var networkResponseObjectOk = responseVo.networkResponseObjectOk!;

      if (networkResponseObjectOk.responseStatusCode == 200) {
        // 정상 코드
        var responseBody = networkResponseObjectOk.responseBody!
            as api_main_server.GetMobileAppVersionInfoAsyncResponseBodyVo;

        var currVersionSplit = currentAppVersion.split(".");
        var minUpdateVersionSplit = responseBody.minUpgradeVersion.split(".");

        // 현재 버전이 서버 업데이트 기준 미달인지 여부 = 강제 업데이트 수행
        bool needUpdate = !(int.parse(currVersionSplit[0]) >=
                int.parse(minUpdateVersionSplit[0]) &&
            int.parse(currVersionSplit[1]) >=
                int.parse(minUpdateVersionSplit[1]) &&
            int.parse(currVersionSplit[2]) >=
                int.parse(minUpdateVersionSplit[2]));

        if (needUpdate) {
          // 업데이트 필요
          if (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.android) {
            // 모바일 환경 : 업데이트 스토어로 이동
            if (!_context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_info.PageEntrance(
                      all_dialog_info.PageInputVo(
                          "업데이트 필요", "새 버전 업데이트가 필요합니다.", "확인"),
                    )).then((value) {
              // 앱 업데이트 스토어로 이동
              try {
                // !!!스토어 리다이렉트 경로 설정!!!
                StoreRedirect.redirect(androidAppId: "todo", iOSAppId: "todo")
                    .then((value) {
                  exit(0);
                });
              } catch (e) {
                exit(0);
              }
            });
          } else {
            // PC 환경 : 업데이트 정보를 알려주고 종료
            if (!_context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_info.PageEntrance(
                      all_dialog_info.PageInputVo(
                          "업데이트 필요", "새 버전 업데이트가 필요합니다.", "확인"),
                    )).then((value) {
              // !!!앱 업데이트 사이트로 이동!!!
              launchUrl(Uri.parse('https://todo.com')).then((value) {
                exit(0);
              });
            });
          }
        } else {
          // 업데이트 필요 없음

          // 자동 로그인 확인 및 처리
          await _checkAutoLoginAsync();
        }
      } else {
        // 정상 코드가 아님
        if (!_context.mounted) return;
        showDialog(
            barrierDismissible: false,
            context: _context,
            builder: (context) => all_dialog_yes_or_no.PageEntrance(
                  all_dialog_yes_or_no.PageInputVo(
                      "네트워크 에러", "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "다시 시도", "종료"),
                )).then((outputVo) async {
          if (outputVo == null || !outputVo.checkPositiveBtn) {
            // 아무것도 누르지 않거나 negative 버튼을 눌렀을 때

            exit(0);
          } else {
            // positive 버튼을 눌렀을 때

            // 다시 실행
            await _checkAppVersionAsync();
          }
        });
      }
    } else {
      // Dio 네트워크 에러
      if (!_context.mounted) return;
      showDialog(
          barrierDismissible: false,
          context: _context,
          builder: (context) => all_dialog_yes_or_no.PageEntrance(
                all_dialog_yes_or_no.PageInputVo(
                    "네트워크 에러", "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "다시 시도", "종료"),
              )).then((outputVo) async {
        if (outputVo == null || !outputVo.checkPositiveBtn) {
          // 아무것도 누르지 않거나 negative 버튼을 눌렀을 때

          exit(0);
        } else {
          // positive 버튼을 눌렀을 때

          // 다시 실행
          await _checkAppVersionAsync();
        }
      });
    }
  }

  // (자동 로그인 확인)
  Future<void> _checkAutoLoginAsync() async {
    spw_auth_member_info.SharedPreferenceWrapperVo? loginMemberInfo =
        spw_auth_member_info.SharedPreferenceWrapper.get();
    if (loginMemberInfo != null) {
      // 리플레시 토큰 만료 여부 확인
      bool isRefreshTokenExpired = DateFormat('yyyy-MM-dd HH:mm:ss.SSS')
          .parse(loginMemberInfo.refreshTokenExpireWhen)
          .isBefore(DateTime.now());

      if (isRefreshTokenExpired) {
        // 리플래시 토큰이 사용 불가이므로 로그아웃 처리
        // login_user_info SPW 비우기
        spw_auth_member_info.SharedPreferenceWrapper.set(null);

        _appInitLogicThreadConfluenceObj.threadComplete();
      } else {
        var postAutoLoginOutputVo =
            await api_main_server.postService1TkV1AuthReissueAsync(
                api_main_server.PostService1TkV1AuthReissueAsyncRequestHeaderVo(
                    "${loginMemberInfo.tokenType} ${loginMemberInfo.accessToken}"),
                api_main_server.PostService1TkV1AuthReissueAsyncRequestBodyVo(
                    "${loginMemberInfo.tokenType} ${loginMemberInfo.refreshToken}"));

        // 네트워크 요청 결과 처리
        if (postAutoLoginOutputVo.dioException == null) {
          // Dio 네트워크 응답
          var networkResponseObjectOk =
              postAutoLoginOutputVo.networkResponseObjectOk!;

          if (networkResponseObjectOk.responseStatusCode == 200) {
            // 액세스 토큰 재발급 정상 응답

            var postReissueResponseBody = networkResponseObjectOk.responseBody!
                as api_main_server
                .PostService1TkV1AuthReissueAsyncResponseBodyVo;

            pageViewModel.signInRetryCount = 0;

            // SSW 정보 갱신
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
                myEmail.uid,
                myEmail.emailAddress,
                myEmail.isFront,
              ));
            }

            List<spw_auth_member_info.SharedPreferenceWrapperVoPhoneInfo>
                myPhoneNumberList = [];
            for (api_main_server.PostReissueAsyncResponseBodyVoPhone myPhone
                in postReissueResponseBody.myPhoneNumberList) {
              myPhoneNumberList
                  .add(spw_auth_member_info.SharedPreferenceWrapperVoPhoneInfo(
                myPhone.uid,
                myPhone.phoneNumber,
                myPhone.isFront,
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

            spw_auth_member_info.SharedPreferenceWrapper.set(loginMemberInfo);

            _appInitLogicThreadConfluenceObj.threadComplete();
          } else {
            // 액세스 토큰 재발급 비정상 응답
            var responseHeaders = networkResponseObjectOk.responseHeaders
                as api_main_server
                .PostService1TkV1AuthReissueAsyncResponseHeaderVo;

            if (responseHeaders.apiResultCode == null) {
              // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때

              if (pageViewModel.signInRetryCount ==
                  pageViewModel.signInRetryCountLimit) {
                pageViewModel.signInRetryCount = 0;
                if (!_context.mounted) return;
                await showDialog(
                    barrierDismissible: true,
                    context: _context,
                    builder: (context) => all_dialog_info.PageEntrance(
                          all_dialog_info.PageInputVo("로그인 실패",
                              "저장된 로그인 정보를 사용할 수 없습니다.\n비회원 상태로 전환합니다.", "확인"),
                        ));

                // login_user_info SSW 비우기 (= 로그아웃 처리)
                spw_auth_member_info.SharedPreferenceWrapper.set(null);
                _appInitLogicThreadConfluenceObj.threadComplete();
                return;
              }

              if (!_context.mounted) return;
              showDialog(
                  barrierDismissible: false,
                  context: _context,
                  builder: (context) => all_dialog_yes_or_no.PageEntrance(
                        all_dialog_yes_or_no.PageInputVo("네트워크 에러",
                            "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "다시 시도", "종료"),
                      )).then((outputVo) async {
                if (outputVo == null || !outputVo.checkPositiveBtn) {
                  // 아무것도 누르지 않거나 negative 버튼을 눌렀을 때

                  exit(0);
                } else {
                  // positive 버튼을 눌렀을 때
                  pageViewModel.signInRetryCount++;

                  // 다시 실행
                  await _checkAutoLoginAsync();
                }
              });
            } else {
              // 서버 지정 에러 코드를 전달 받았을 때
              String apiResultCode = responseHeaders.apiResultCode!;

              switch (apiResultCode) {
                case "1": // 탈퇴된 회원
                case "2": // 유효하지 않은 리프레시 토큰
                case "3": // 리프레시 토큰 만료
                case "4": // 리프레시 토큰이 액세스 토큰과 매칭되지 않음
                  {
                    // 리플래시 토큰이 사용 불가이므로 로그아웃 처리

                    // login_user_info SSW 비우기 (= 로그아웃 처리)
                    spw_auth_member_info.SharedPreferenceWrapper.set(null);
                    _appInitLogicThreadConfluenceObj.threadComplete();
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
          if (pageViewModel.signInRetryCount ==
              pageViewModel.signInRetryCountLimit) {
            pageViewModel.signInRetryCount = 0;
            if (!_context.mounted) return;
            await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_info.PageEntrance(
                      all_dialog_info.PageInputVo("로그인 실패",
                          "저장된 로그인 정보를 사용할 수 없습니다.\n비회원 상태로 전환합니다.", "확인"),
                    ));

            // login_user_info SSW 비우기 (= 로그아웃 처리)
            spw_auth_member_info.SharedPreferenceWrapper.set(null);
            _appInitLogicThreadConfluenceObj.threadComplete();
            return;
          }

          // Dio 네트워크 에러
          if (!_context.mounted) return;
          showDialog(
              barrierDismissible: false,
              context: _context,
              builder: (context) => all_dialog_yes_or_no.PageEntrance(
                    all_dialog_yes_or_no.PageInputVo("네트워크 에러",
                        "네트워크 상태가 불안정합니다.\n다시 시도해주세요.", "다시 시도", "종료"),
                  )).then((outputVo) async {
            if (outputVo == null || !outputVo.checkPositiveBtn) {
              // 아무것도 누르지 않거나 negative 버튼을 눌렀을 때

              exit(0);
            } else {
              // positive 버튼을 눌렀을 때
              pageViewModel.signInRetryCount++;

              // 다시 실행
              await _checkAutoLoginAsync();
            }
          });
        }
      }
    } else {
      // 자동 로그인 불필요
      _appInitLogicThreadConfluenceObj.threadComplete();
    }
  }

  // (앱 초기화 로직 스레드가 모두 완료되었을 때)
  void _onAppInitLogicThreadComplete() {
    // 다음 페이지(홈 페이지)로 이동
    _context.goNamed(all_page_home.pageName);
  }
}

// (페이지 뷰 모델 클래스)
// 페이지 전역의 데이터는 여기에 정의되며, Business 인스턴스 안의 pageViewModel 변수로 저장 됩니다.
class PageViewModel {
  // 페이지 생명주기 관련 states
  var pageLifeCycleStates = gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터 (아래 goRouterState 에서 가져와 대입하기)
  late page_entrance.PageInputVo pageInputVo;

  // !!!페이지 데이터 정의!!!
  // ex :
  // int sampleNumber = 0;

  // 프로그램 최초 실행 로직 수행 여부
  bool doStartProgramLogic = false;

  AnimationLogoControllers? animationLogoControllers;

  // (페이지 대기 카운트 숫자)
  int countNumber = 1;

  // (네트워크 에러로 인한 로그인 재시도 횟수)
  int signInRetryCount = 0;

  int signInRetryCountLimit = 2;

  PageViewModel();
}

class AnimationLogoControllers {
  AnimationController animationController;
  Animation<double> fadeAnimation;
  Animation<double> scaleAnimation;

  AnimationLogoControllers(
      this.animationController, this.fadeAnimation, this.scaleAnimation);
}

// (BLoC 클래스)
// ex :
// class BlocSample extends Bloc<bool, bool> {
//   // BLoC 위젯 갱신 함수
//   void refresh() {
//     add(!state);
//   }
//
//   BlocSample() : super(true) {
//     on<bool>((event, emit) {
//       emit(event);
//     });
//   }
// }

// [카운트 다운 숫자]
class BlocCountDownNumber extends Bloc<bool, bool> {
  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }

  BlocCountDownNumber() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

// (BLoC 프로바이더 클래스)
// 본 페이지에서 사용할 BLoC 객체를 모아두어 PageEntrance 에서 페이지 전역 설정에 사용 됩니다.
class BLocProviders {
// !!!이 페이지에서 사용할 "모든" BLoC 클래스들에 대한 Provider 객체들을 아래 리스트에 넣어줄 것!!!
  List<BlocProvider<dynamic>> blocProviders = [
    // ex :
    // BlocProvider<BlocSample>(create: (context) => BlocSample())
    BlocProvider<BlocCountDownNumber>(
        create: (context) => BlocCountDownNumber()),
  ];
}

class BLocObjects {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!!
  // ex :
  // late BlocSample blocSample;
  late BlocCountDownNumber blocCountDownNumber;

  // 생성자 설정
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocCountDownNumber = BlocProvider.of<BlocCountDownNumber>(_context);
  }
}
