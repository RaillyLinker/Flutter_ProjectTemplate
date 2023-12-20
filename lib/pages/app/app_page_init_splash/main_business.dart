// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:sync/semaphore.dart';
import 'package:url_launcher/url_launcher.dart';

// (inner_folder)
import 'main_widget.dart' as main_widget;

// (all)
import 'package:flutter_project_template/repositories/network/apis/api_main_server.dart'
    as api_main_server;
import 'package:flutter_project_template/repositories/spws/spw_auth_member_info.dart'
    as spw_auth_member_info;
import 'package:flutter_project_template/dialogs/all/all_dialog_info/main_widget.dart'
    as all_dialog_info;
import 'package:flutter_project_template/dialogs/all/all_dialog_yes_or_no/main_widget.dart'
    as all_dialog_yes_or_no;
import 'package:flutter_project_template/global_data/gd_const_config.dart'
    as gd_const_config;
import 'package:flutter_project_template/pages/all/all_page_home/main_widget.dart'
    as all_page_home;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;

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
  }

  // (종료 시점 단 한번 실행)
  void dispose() {
    // !!!dispose 로직 작성!!!
  }

  // (시스템 밝기 설정 변경시 실행)
  void didChangePlatformBrightness() {
    // !!!didChangePlatformBrightness 로직 작성!!!
  }

  // (시스템 언어/국가 설정 변경시 실행)
  void didChangeLocales() {
    // !!!didChangeLocales 로직 작성!!!
  }

  // (화면 크기 변경시 실행)
  void didChangeMetrics() {
    // !!!didChangeMetrics 로직 작성!!!
  }

  // (최초 실행시 단 한번 실행) - 위젯 build 바로 직전, 모든 것이 준비 되었을 때
  void onCreate() {
    // !!!onCreate 로직 작성!!!
    _checkAppVersionAsync();
  }

  Future<void> onFocusGainedAsync() async {
    // !!!onFocusGainedAsync 로직 작성!!!

    // 화면 대기시간 카운팅 개시/재개 (비동기 카운팅)
    if (countNumber > 0) {
      _screenWaitingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        // 뷰모델 State 변경 및 자동 이벤트 발동
        countNumber = countNumber - 1;
        countNumberAreaGk.currentState?.refreshUi();

        if (countNumber <= 0) {
          // 카운팅 완료
          timer.cancel();

          _screenWaitingTimer = null;
          timerComplete = true;
          _onApplicationInitLogicComplete();
        }
      });
    } else {
      timerComplete = true;
      _onApplicationInitLogicComplete();
    }
  }

  Future<void> onFocusLostAsync() async {
    // !!!onFocusLostAsync 로직 작성!!!

    // 화면 대기시간 카운팅 멈추기
    _screenWaitingTimer?.cancel();
    _screenWaitingTimer = null;
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

  // (페이지 설정 정보)
  // onCreate, onFocusGainedAsync, didChangePlatformBrightness, didChangeLocales 실행 직전 마다 갱신됨
  // 페이지 국가 설정 (KR, US, JP, ...)
  // WidgetsBinding.instance.platformDispatcher.locale.countryCode 에서 나오는 값
  late String? countrySetting;

  // 페이지 언어 설정 (ko, en, ja, ...)
  // WidgetsBinding.instance.platformDispatcher.locale.languageCode 에서 나오는 값
  late String languageSetting;

  // 페이지 밝기 모드 설정 (dark, light)
  late String brightnessModeSetting;

  // 화면 너비
  late double screenWidth;

  // 화면 높이
  late double screenHeight;

  // 화면 대기 시간 카운트 객체
  Timer? _screenWaitingTimer;

  // 프로그램 최초 실행 로직 수행 여부
  bool doStartProgramLogic = false;

  // (페이지 대기 카운트 숫자)
  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> countNumberAreaGk =
      GlobalKey();
  late BuildContext countNumberAreaContext;
  int countNumber = 1;

  // (네트워크 에러로 인한 로그인 재시도 횟수)
  int signInRetryCount = 0;

  int signInRetryCountLimit = 2;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!비즈니스 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (메인 위젯 화면 갱신)
  late VoidCallback refreshUi;

  // [private 함수]
  void _doNothing() {}

  // (앱 버전 확인)
  Future<void> _checkAppVersionAsync() async {
    print("d");
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
        requestQueryVo:
            api_main_server.GetMobileAppVersionInfoAsyncRequestQueryVo(
                platformCode: platformCode));

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
                        dialogTitle: "업데이트 필요",
                        dialogContent: "새 버전 업데이트가 필요합니다.",
                        checkBtnTitle: "확인",
                        onDialogCreated: () {},
                      ),
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
                        dialogTitle: "업데이트 필요",
                        dialogContent: "새 버전 업데이트가 필요합니다.",
                        checkBtnTitle: "확인",
                        onDialogCreated: () {},
                      ),
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
        final GlobalKey<all_dialog_yes_or_no.MainWidgetState>
            allDialogYesOrNoStateGk = GlobalKey();
        if (!mainContext.mounted) return;
        showDialog(
            barrierDismissible: false,
            context: mainContext,
            builder: (context) => all_dialog_yes_or_no.MainWidget(
                  key: allDialogYesOrNoStateGk,
                  inputVo: all_dialog_yes_or_no.InputVo(
                    dialogTitle: "네트워크 에러",
                    dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                    positiveBtnTitle: "다시 시도",
                    negativeBtnTitle: "종료",
                    onDialogCreated: () {},
                  ),
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
      final GlobalKey<all_dialog_yes_or_no.MainWidgetState>
          allDialogYesOrNoStateGk = GlobalKey();
      if (!mainContext.mounted) return;
      showDialog(
          barrierDismissible: false,
          context: mainContext,
          builder: (context) => all_dialog_yes_or_no.MainWidget(
                key: allDialogYesOrNoStateGk,
                inputVo: all_dialog_yes_or_no.InputVo(
                  dialogTitle: "네트워크 에러",
                  dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                  positiveBtnTitle: "다시 시도",
                  negativeBtnTitle: "종료",
                  onDialogCreated: () {},
                ),
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
        spw_auth_member_info.SharedPreferenceWrapper.set(value: null);

        initLogicComplete = true;
        _onApplicationInitLogicComplete();
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
            // 액세스 토큰 재발급 정상 응답

            var postReissueResponseBody = networkResponseObjectOk.responseBody!
                as api_main_server
                .PostService1TkV1AuthReissueAsyncResponseBodyVo;

            signInRetryCount = 0;

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

            initLogicComplete = true;
            _onApplicationInitLogicComplete();
          } else {
            // 액세스 토큰 재발급 비정상 응답
            var responseHeaders = networkResponseObjectOk.responseHeaders
                as api_main_server
                .PostService1TkV1AuthReissueAsyncResponseHeaderVo;

            if (responseHeaders.apiResultCode == null) {
              // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때

              if (signInRetryCount == signInRetryCountLimit) {
                signInRetryCount = 0;
                final GlobalKey<all_dialog_info.MainWidgetState>
                    allDialogInfoStateGk =
                    GlobalKey<all_dialog_info.MainWidgetState>();
                if (!mainContext.mounted) return;
                await showDialog(
                    barrierDismissible: true,
                    context: mainContext,
                    builder: (context) => all_dialog_info.MainWidget(
                          key: allDialogInfoStateGk,
                          inputVo: all_dialog_info.InputVo(
                            dialogTitle: "로그인 실패",
                            dialogContent:
                                "저장된 로그인 정보를 사용할 수 없습니다.\n비회원 상태로 전환합니다.",
                            checkBtnTitle: "확인",
                            onDialogCreated: () {},
                          ),
                        ));

                // login_user_info SSW 비우기 (= 로그아웃 처리)
                spw_auth_member_info.SharedPreferenceWrapper.set(value: null);
                initLogicComplete = true;
                _onApplicationInitLogicComplete();
                return;
              }

              final GlobalKey<all_dialog_yes_or_no.MainWidgetState>
                  allDialogYesOrNoStateGk = GlobalKey();
              if (!mainContext.mounted) return;
              showDialog(
                  barrierDismissible: false,
                  context: mainContext,
                  builder: (context) => all_dialog_yes_or_no.MainWidget(
                        key: allDialogYesOrNoStateGk,
                        inputVo: all_dialog_yes_or_no.InputVo(
                          dialogTitle: "네트워크 에러",
                          dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                          positiveBtnTitle: "다시 시도",
                          negativeBtnTitle: "종료",
                          onDialogCreated: () {},
                        ),
                      )).then((outputVo) async {
                if (outputVo == null || !outputVo.checkPositiveBtn) {
                  // 아무것도 누르지 않거나 negative 버튼을 눌렀을 때

                  exit(0);
                } else {
                  // positive 버튼을 눌렀을 때
                  signInRetryCount++;

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
                    spw_auth_member_info.SharedPreferenceWrapper.set(
                        value: null);
                    initLogicComplete = true;
                    _onApplicationInitLogicComplete();
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
          if (signInRetryCount == signInRetryCountLimit) {
            signInRetryCount = 0;
            final GlobalKey<all_dialog_info.MainWidgetState>
                allDialogInfoStateGk =
                GlobalKey<all_dialog_info.MainWidgetState>();
            if (!mainContext.mounted) return;
            await showDialog(
                barrierDismissible: true,
                context: mainContext,
                builder: (context) => all_dialog_info.MainWidget(
                      key: allDialogInfoStateGk,
                      inputVo: all_dialog_info.InputVo(
                        dialogTitle: "로그인 실패",
                        dialogContent:
                            "저장된 로그인 정보를 사용할 수 없습니다.\n비회원 상태로 전환합니다.",
                        checkBtnTitle: "확인",
                        onDialogCreated: () {},
                      ),
                    ));

            // login_user_info SSW 비우기 (= 로그아웃 처리)
            spw_auth_member_info.SharedPreferenceWrapper.set(value: null);
            initLogicComplete = true;
            _onApplicationInitLogicComplete();
            return;
          }

          // Dio 네트워크 에러
          final GlobalKey<all_dialog_yes_or_no.MainWidgetState>
              allDialogYesOrNoStateGk = GlobalKey();
          if (!mainContext.mounted) return;
          showDialog(
              barrierDismissible: false,
              context: mainContext,
              builder: (context) => all_dialog_yes_or_no.MainWidget(
                    key: allDialogYesOrNoStateGk,
                    inputVo: all_dialog_yes_or_no.InputVo(
                      dialogTitle: "네트워크 에러",
                      dialogContent: "네트워크 상태가 불안정합니다.\n다시 시도해주세요.",
                      positiveBtnTitle: "다시 시도",
                      negativeBtnTitle: "종료",
                      onDialogCreated: () {},
                    ),
                  )).then((outputVo) async {
            if (outputVo == null || !outputVo.checkPositiveBtn) {
              // 아무것도 누르지 않거나 negative 버튼을 눌렀을 때

              exit(0);
            } else {
              // positive 버튼을 눌렀을 때
              signInRetryCount++;

              // 다시 실행
              await _checkAutoLoginAsync();
            }
          });
        }
      }
    } else {
      // 자동 로그인 불필요
      initLogicComplete = true;
      _onApplicationInitLogicComplete();
    }
  }

  // (앱 초기화 로직 코드가 모두 완료 되었을 때)
  final Semaphore _onApplicationInitLogicCompleteSemaphore = Semaphore(1);
  bool timerComplete = false;
  bool initLogicComplete = false;

  void _onApplicationInitLogicComplete() {
    _onApplicationInitLogicCompleteSemaphore.acquire();
    if (!timerComplete || !initLogicComplete) {
      _onApplicationInitLogicCompleteSemaphore.acquire();
      return;
    }

    _onApplicationInitLogicCompleteSemaphore.acquire();

    // 다음 페이지(홈 페이지)로 이동
    mainContext.goNamed(all_page_home.pageName);
  }
}
