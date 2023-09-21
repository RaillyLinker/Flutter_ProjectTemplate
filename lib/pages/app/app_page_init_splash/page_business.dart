// (external)
import 'dart:io';
import 'dart:async';
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
import '../../../../../repositories/spws/spw_sign_in_member_info.dart'
    as spw_sign_in_member_info;
import '../../../../../repositories/network/apis/api_main_server.dart'
    as api_main_server;
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;
import '../../../dialogs/all/all_dialog_info/page_entrance.dart'
    as all_dialog_info;
import '../../../global_classes/gc_my_classes.dart' as gc_my_classes;
import '../../../dialogs/all/all_dialog_yes_or_no/page_entrance.dart'
    as all_dialog_yes_or_no;
import '../../../pages/all/all_page_home/page_entrance.dart' as all_page_home;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../global_data/gd_const_config.dart' as gd_const_config;
import '../../../../repositories/spws/spw_program_start_first_time.dart'
    as spw_program_start_first_time;

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

  // 화면 대기 시간 카운트 객체
  Timer? _screenWaitingTimer;

  // 앱 초기화 로직 스레드 합류 객체 (비동기로 진행되는 화면 대기 타이머와 초기화 로직이 모두 끝나면 콜백이 실행됨)
  late final gc_my_classes.ThreadConfluenceObj
      _appInitLogicThreadConfluenceObj =
      gc_my_classes.ThreadConfluenceObj(2, () {
    _onAppInitLogicThreadComplete();
  });

  // 생성자 설정
  PageBusiness(this._context, page_entrance.PageInputVo pageInputVo) {
    pageViewModel = PageViewModel(pageInputVo);
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
    await _checkAppVersionAsync();
  }

  // (페이지 최초 실행 or 다른 페이지에서 복귀)
  Future<void> onPageResumeAsync() async {
    // !!!위젯 최초 실행 및, 다른 페이지에서 복귀 로직 작성!!
    // 화면 대기시간 카운팅 개시/재개 (비동기 카운팅)
    _countDownScreenWaitingTime();
  }

  // (페이지 종료 or 다른 페이지로 이동 (강제 종료는 탐지 못함))
  Future<void> onPagePauseAsync() async {
    // !!!위젯 종료 및, 다른 페이지로 이동 로직 작성!!
    // 화면 대기시간 카운팅 멈추기
    _screenWaitingTimer?.cancel();
  }

  // (페이지 종료 (강제 종료는 탐지 못함))
  Future<void> onPageDestroyAsync() async {
    // !!!페이지 종료 로직 작성!!
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

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!

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
        blocObjects.blocCountDownNumber
            .add(!blocObjects.blocCountDownNumber.state);

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
                        "need update",
                        "The required version is not met.\nPlease update the application.\n\nGo to the App Store.",
                        "Check"),
                    (pageBusiness) {})).then((value) {
              // 앱 업데이트 스토어로 이동
              try {
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
                        "need update",
                        "The required version is not met.\nPlease update the application.\n\nGo to the Download Site.",
                        "Check"),
                    (pageBusiness) {})).then((value) {
              // 앱 업데이트 사이트로 이동
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
                    "Network Error",
                    "network connection is unstable.\nplease try again.",
                    "Retry",
                    "Exit"),
                (pageBusiness) {})).then((outputVo) async {
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
                  "Network Error",
                  "network connection is unstable.\nplease try again.",
                  "Retry",
                  "Exit"),
              (pageBusiness) {})).then((outputVo) async {
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
    spw_sign_in_member_info.SharedPreferenceWrapperVo? signInMemberInfo =
        spw_sign_in_member_info.SharedPreferenceWrapper.get();
    if (signInMemberInfo != null) {
      // 리플레시 토큰 만료 여부 확인
      bool isRefreshTokenExpired = gf_my_functions.isDateExpired(
          DateTime.now(),
          DateFormat('yyyy-MM-dd HH:mm:ss.SSS')
              .parse(signInMemberInfo.refreshTokenExpireWhen));

      if (isRefreshTokenExpired) {
        // 리플래시 토큰이 사용 불가이므로 로그아웃 처리
        // login_user_info SPW 비우기
        spw_sign_in_member_info.SharedPreferenceWrapper.set(null);

        await _checkProgramFirstTimeAsync();
      } else {
        var postAutoLoginOutputVo = await api_main_server.postReissueAsync(
            api_main_server.PostReissueAsyncRequestHeaderVo(
                "${signInMemberInfo.tokenType} ${signInMemberInfo.accessToken}"),
            api_main_server.PostReissueAsyncRequestBodyVo(
                "${signInMemberInfo.tokenType} ${signInMemberInfo.refreshToken}"));

        // 네트워크 요청 결과 처리
        if (postAutoLoginOutputVo.dioException == null) {
          // Dio 네트워크 응답
          var networkResponseObjectOk =
              postAutoLoginOutputVo.networkResponseObjectOk!;

          if (networkResponseObjectOk.responseStatusCode == 200) {
            // 액세스 토큰 재발급 정상 응답

            var postAutoLoginResponseBody =
                networkResponseObjectOk.responseBody!
                    as api_main_server.PostReissueAsyncResponseBodyVo;

            pageViewModel.signInRetryCount = 0;

            // SSW 정보 갱신
            List<spw_sign_in_member_info.SharedPreferenceWrapperVoOAuth2Info>
                myOAuth2ObjectList = [];
            for (api_main_server
                .PostReissueAsyncResponseBodyVoOAuth2Info myOAuth2
                in postAutoLoginResponseBody.myOAuth2List) {
              myOAuth2ObjectList.add(
                  spw_sign_in_member_info.SharedPreferenceWrapperVoOAuth2Info(
                      myOAuth2.oauth2TypeCode, myOAuth2.oauth2Id));
            }
            signInMemberInfo.memberUid = postAutoLoginResponseBody.memberUid;
            signInMemberInfo.nickName = postAutoLoginResponseBody.nickName;
            signInMemberInfo.roleCodeList =
                postAutoLoginResponseBody.roleCodeList;
            signInMemberInfo.tokenType = postAutoLoginResponseBody.tokenType;
            signInMemberInfo.accessToken =
                postAutoLoginResponseBody.accessToken;
            signInMemberInfo.accessTokenExpireWhen =
                postAutoLoginResponseBody.accessTokenExpireWhen;
            signInMemberInfo.refreshToken =
                postAutoLoginResponseBody.refreshToken;
            signInMemberInfo.refreshTokenExpireWhen =
                postAutoLoginResponseBody.refreshTokenExpireWhen;
            signInMemberInfo.myEmailList =
                postAutoLoginResponseBody.myEmailList;
            signInMemberInfo.myPhoneNumberList =
                postAutoLoginResponseBody.myPhoneNumberList;
            signInMemberInfo.myOAuth2List = myOAuth2ObjectList;
            spw_sign_in_member_info.SharedPreferenceWrapper.set(
                signInMemberInfo);

            await _checkProgramFirstTimeAsync();
          } else {
            // 액세스 토큰 재발급 비정상 응답
            if (networkResponseObjectOk.responseHeaders.apiErrorCodes == null) {
              // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때

              if (pageViewModel.signInRetryCount ==
                  pageViewModel.signInRetryCountLimit) {
                pageViewModel.signInRetryCount = 0;
                if (!_context.mounted) return;
                await showDialog(
                    barrierDismissible: true,
                    context: _context,
                    builder: (context) => all_dialog_info.PageEntrance(
                        all_dialog_info.PageInputVo(
                            "Server Sign in Error",
                            "network connection is unstable.\nSwitch to non-member status.",
                            "Check"),
                        (pageBusiness) {}));

                // login_user_info SSW 비우기 (= 로그아웃 처리)
                spw_sign_in_member_info.SharedPreferenceWrapper.set(null);
                await _checkProgramFirstTimeAsync();
                return;
              }

              if (!_context.mounted) return;
              showDialog(
                  barrierDismissible: false,
                  context: _context,
                  builder: (context) => all_dialog_yes_or_no.PageEntrance(
                      all_dialog_yes_or_no.PageInputVo(
                          "Network Error",
                          "network connection is unstable.\nplease try again.",
                          "Retry",
                          "Exit"),
                      (pageBusiness) {})).then((outputVo) async {
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
              List<String> apiErrorCodes =
                  networkResponseObjectOk.responseHeaders.apiErrorCodes;
              if (apiErrorCodes.contains("1") || // 유효하지 않은 리플래시 토큰
                      apiErrorCodes.contains("2") || // 리플래시 토큰 만료
                      apiErrorCodes.contains("3") || // 리플래시 토큰이 액세스 토큰과 매칭되지 않음
                      apiErrorCodes.contains("4") // 가입되지 않은 회원
                  ) {
                // 리플래시 토큰이 사용 불가이므로 로그아웃 처리

                // login_user_info SSW 비우기 (= 로그아웃 처리)
                spw_sign_in_member_info.SharedPreferenceWrapper.set(null);
                await _checkProgramFirstTimeAsync();
              } else {
                // 알 수 없는 에러 코드일 때
                throw Exception("unKnown Error Code");
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
                    all_dialog_info.PageInputVo(
                        "Server Sign in Error",
                        "network connection is unstable.\nSwitch to non-member status.",
                        "Check"),
                    (pageBusiness) {}));

            // login_user_info SSW 비우기 (= 로그아웃 처리)
            spw_sign_in_member_info.SharedPreferenceWrapper.set(null);
            await _checkProgramFirstTimeAsync();
            return;
          }

          // Dio 네트워크 에러
          if (!_context.mounted) return;
          showDialog(
              barrierDismissible: false,
              context: _context,
              builder: (context) => all_dialog_yes_or_no.PageEntrance(
                  all_dialog_yes_or_no.PageInputVo(
                      "Network Error",
                      "network connection is unstable.\nplease try again.",
                      "Retry",
                      "Exit"),
                  (pageBusiness) {})).then((outputVo) async {
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
      await _checkProgramFirstTimeAsync();
    }
  }

  // (프로그램 최초 실행 여부 체크)
  Future<void> _checkProgramFirstTimeAsync() async {
    var programStartFirstTimeValueMap =
        spw_program_start_first_time.SharedPreferenceWrapper.get();

    if (programStartFirstTimeValueMap == null ||
        programStartFirstTimeValueMap.value) {
      // 프로그램이 디바이스에서 처음 실행된 경우

      // 앱 최초 실행 여부 플래그를 false로 변경
      spw_program_start_first_time.SharedPreferenceWrapper.set(
          spw_program_start_first_time.SharedPreferenceWrapperVo(false));

      // !!프로그램 최초 실행 작업 수행!!

      // 초기화 작업 완료 (스레드 합류)
      _appInitLogicThreadConfluenceObj.threadComplete();
    } else {
      // 프로그램이 디바이스에서 처음 실행되지 않은 경우

      // 초기화 작업 완료 (스레드 합류)
      _appInitLogicThreadConfluenceObj.threadComplete();
    }
  }

  // (앱 초기화 로직 스레드가 모두 완료되었을 때)
  void _onAppInitLogicThreadComplete() {
    // 다음 페이지(홈 페이지)로 이동
    _context.goNamed(all_page_home.pageName);
  }
}

// (페이지 뷰 모델 스키마)
// 페이지의 모든 화면 관련 데이터는 여기에 정의되며, Business 인스턴스 안에 객체로 저장 됩니다.
class PageViewModel {
  // 페이지 생명주기 관련 states
  var pageLifeCycleStates = gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터
  page_entrance.PageInputVo pageInputVo;

  // !!!페이지 데이터 정의!!
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

  PageViewModel(this.pageInputVo);
}

class AnimationLogoControllers {
  AnimationController animationController;
  Animation<double> fadeAnimation;
  Animation<double> scaleAnimation;

  AnimationLogoControllers(
      this.animationController, this.fadeAnimation, this.scaleAnimation);
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

// [카운트 다운 숫자]
class BlocCountDownNumber extends Bloc<bool, bool> {
  BlocCountDownNumber() : super(true) {
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
    BlocProvider<BlocCountDownNumber>(
        create: (context) => BlocCountDownNumber()),
  ];
}

class BLocObjects {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!
  // ex :
  // late BlocSample blocSample;
  late BlocCountDownNumber blocCountDownNumber;

  // 생성자 설정
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocCountDownNumber = BlocProvider.of<BlocCountDownNumber>(_context);
  }
}
