// (external)
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// (all)
import 'apis/api_main_server.dart' as api_main_server;
import '../spws/spw_sign_in_member_info.dart' as spw_sign_in_member_info;
import '../../global_data/gd_const_config.dart' as gd_const_config;
import '../../global_functions/gf_my_functions.dart' as gf_my_functions;

// [네트워크 요청 객체 파일]
// 네트워크 요청 객체 선언, 생성, 설정 파일
// 로컬 주소 사용시 윈도우 환경이라면 127.0.0.1, 그외 환경이라면 라우터 내의 ip 를 사용해야합니다.

// 요청 객체는 아래에 선언 및 초기 설정 이후, api_ dart 파일에서 사용됨

// -----------------------------------------------------------------------------
// !!!서버별 네트워크 요청 객체를 선언, 생성합니다.!!
// (메인 서버 Dio)
var mainServerDio = Dio(BaseOptions(
    baseUrl: (gd_const_config.isDebugMode)
        // 개발 서버
        ? "http://127.0.0.1:8080"
        // 배포 서버
        : "http://127.0.0.1:8080",

    // 기본 타임아웃 설정
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),

    // Dio는 상태 코드가 200부터 299까지인 경우에만 응답 데이터를 받기에 그외에도 데이터를 받기 위한 설정
    receiveDataWhenStatusError: true,
    validateStatus: (status) {
      // 모든 status 를 에러로 인식하지 않도록 처리
      // 301, 1003 등의 코드는 여전히 에러로 인식하므로 일반적으로 사용되는 코드만 사용하도록 서버 측과의 협의가 필요
      return true;
    }));

// (Google Access Token 발급 서버)
var accountsGoogleCom = Dio(BaseOptions(
    baseUrl: (gd_const_config.isDebugMode)
        // 개발 서버
        ? "https://accounts.google.com"
        // 배포 서버
        : "https://accounts.google.com",

    // 기본 타임아웃 설정
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),

    // Dio는 상태 코드가 200부터 299까지인 경우에만 응답 데이터를 받기에 그외에도 데이터를 받기 위한 설정
    receiveDataWhenStatusError: true,
    validateStatus: (status) {
      // 모든 status 를 에러로 인식하지 않도록 처리
      // 301, 1003 등의 코드는 여전히 에러로 인식하므로 일반적으로 사용되는 코드만 사용하도록 서버 측과의 협의가 필요
      return true;
    }));

// (Apple Access Token 발급 서버)
var appleidAppleCom = Dio(BaseOptions(
    baseUrl: (gd_const_config.isDebugMode)
        // 개발 서버
        ? "https://appleid.apple.com"
        // 배포 서버
        : "https://appleid.apple.com",

    // 기본 타임아웃 설정
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),

    // Dio는 상태 코드가 200부터 299까지인 경우에만 응답 데이터를 받기에 그외에도 데이터를 받기 위한 설정
    receiveDataWhenStatusError: true,
    validateStatus: (status) {
      // 모든 status 를 에러로 인식하지 않도록 처리
      // 301, 1003 등의 코드는 여전히 에러로 인식하므로 일반적으로 사용되는 코드만 사용하도록 서버 측과의 협의가 필요
      return true;
    }));

// (Naver Access Token 발급 서버)
var nidNaverCom = Dio(BaseOptions(
    baseUrl: (gd_const_config.isDebugMode)
        // 개발 서버
        ? "https://nid.naver.com"
        // 배포 서버
        : "https://nid.naver.com",

    // 기본 타임아웃 설정
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),

    // Dio는 상태 코드가 200부터 299까지인 경우에만 응답 데이터를 받기에 그외에도 데이터를 받기 위한 설정
    receiveDataWhenStatusError: true,
    validateStatus: (status) {
      // 모든 status 를 에러로 인식하지 않도록 처리
      // 301, 1003 등의 코드는 여전히 에러로 인식하므로 일반적으로 사용되는 코드만 사용하도록 서버 측과의 협의가 필요
      return true;
    }));

// (KakaoTalk Access Token 발급 서버)
var kauthKakaoCom = Dio(BaseOptions(
    baseUrl: (gd_const_config.isDebugMode)
        // 개발 서버
        ? "https://kauth.kakao.com"
        // 배포 서버
        : "https://kauth.kakao.com",

    // 기본 타임아웃 설정
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),

    // Dio는 상태 코드가 200부터 299까지인 경우에만 응답 데이터를 받기에 그외에도 데이터를 받기 위한 설정
    receiveDataWhenStatusError: true,
    validateStatus: (status) {
      // 모든 status 를 에러로 인식하지 않도록 처리
      // 301, 1003 등의 코드는 여전히 에러로 인식하므로 일반적으로 사용되는 코드만 사용하도록 서버 측과의 협의가 필요
      return true;
    }));

// -----------------------------------------------------------------------------
// !!!네트워크 요청 객체에 대한 초기 설정을 해줍니다.!!
// 아래 함수는 main 함수에서 실행됩니다.
void setDioObjects() {
  // (로깅 인터셉터 설정)
  mainServerDio.interceptors.add(PrettyDioLogger(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    error: true,
    compact: true,
  ));

  accountsGoogleCom.interceptors.add(PrettyDioLogger(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    error: true,
    compact: true,
  ));

  appleidAppleCom.interceptors.add(PrettyDioLogger(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    error: true,
    compact: true,
  ));

  nidNaverCom.interceptors.add(PrettyDioLogger(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    error: true,
    compact: true,
  ));

  kauthKakaoCom.interceptors.add(PrettyDioLogger(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    error: true,
    compact: true,
  ));

  // (커스텀 인터셉터 설정)
  mainServerDio.interceptors.add(InterceptorsWrapper(onRequest: (
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // (매 네트워크 요청마다 실행되어 여기를 거친 후 서버로 요청을 보냄)
    // 요청 경로 (ex : http://127.0.0.1:8080/tk/ra/test/request/post-request)
    // String requestPath = options.path;

    // 요청 헤더 (ex : {"Authorization" : "Bearer 12345"})
    // Map<String, dynamic> requestHeaderMap = options.headers;

    // 요청 바디 (ex : {"testBody" : "test text body"})
    // dynamic requestBody = options.data;

    // !!!매 네트워크 요청마다 수행할 로직 설정!!

    // 서버로 요청 전송
    handler.next(options);
  }, onResponse: (
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    // (매 네트워크 응답이 왔을 때 실행되어 여기를 거친 후 요청을 보냈던 코드로 복귀)
    // 응답 코드 (ex : 200)
    // int? responseStatusCode = response.statusCode;

    // 응답 헤더 (ex : {"Authorization" : "Bearer 12345"})
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    // 응답 바디 (ex : {"testBody" : "test text body"})
    // dynamic responseBody = response.data;

    // !!!매 네트워크 응답마다 수행할 로직 설정!!

    // (Authorization JWT 토큰 관련 처리)
    // 가정 : 서버는 RequestHeader 로 {"Authorization" : "Bearer aaaaaaaaaa"} 와 같이 JWT 를 보냈을 때는 토큰 적합성 검사를 합니다.
    // 만약 Authorization 헤더를 보내지 않았다면 적합성 검사를 하지 않습니다.
    // 적합성 검사 수행시 만료된 액세스 토큰이라면 responseHeader 로 {"api-error-codes" : "a"} 가 반환이 되고,
    // 만약 만료되지 않았지만 탈퇴한 회원의 액세스 토큰이라면 responseHeader 로 {"api-error-codes", "b"} 가 반환이 됩니다.
    // 최종 결과로 로그인이 만료되었다면, spw_sign_in_member_info 가 null 로 변경됩니다.
    // 200 이 반환되었어도 로그아웃 된 경우가 있으므로, Authorization 을 입력한 API 의 response 에서는 spw_sign_in_member_info 의 로그인 상태를 확인하세요.
    if (responseHeaderMap.containsKey("api-error-codes")) {
      // JWT 토큰 관련 서버 에러 발생

      List<String> apiErrorCodes = responseHeaderMap["api-error-codes"];

      if (apiErrorCodes.contains("a")) {
        // Request Header 에 Authorization 입력시, 만료된 AccessToken. (reissue, logout API 는 제외)

        // 액세스 토큰 재발급
        spw_sign_in_member_info.SharedPreferenceWrapperVo? signInMemberInfo =
            spw_sign_in_member_info.SharedPreferenceWrapper.get();

        if (signInMemberInfo == null) {
          // 정상적으로 프로세스를 진행할 수 없으므로 그냥 스킵
          // 호출 코드로 응답 전달
          handler.next(response);
          return;
        } else {
          // 리플레시 토큰 만료 여부 확인
          bool isRefreshTokenExpired = DateFormat('yyyy-MM-dd HH:mm:ss.SSS')
              .parse(signInMemberInfo.refreshTokenExpireWhen).isBefore(DateTime.now());

          if (isRefreshTokenExpired) {
            // 리플래시 토큰이 사용 불가이므로 로그아웃 처리

            // login_user_info SSW 비우기 (= 로그아웃 처리)
            spw_sign_in_member_info.SharedPreferenceWrapper.set(null);

            // 호출 코드로 응답 전달
            handler.resolve(response);
            return;
          } else {
            // 리플레시 토큰 아직 만료되지 않음

            // 액세스 토큰 재발급 요청
            // onResponse 가 다시 실행 되어 handler.next 가 실행된 이후에 다시 여기로 복귀하는 것을 주의할것.
            var postReissueResponse = await api_main_server.postReissueAsync(
                api_main_server.PostReissueAsyncRequestHeaderVo(
                    "${signInMemberInfo.tokenType} ${signInMemberInfo.accessToken}"),
                api_main_server.PostReissueAsyncRequestBodyVo(
                    "${signInMemberInfo.tokenType} ${signInMemberInfo.refreshToken}"));

            // 네트워크 요청 결과 처리
            if (postReissueResponse.dioException == null) {
              // Dio 네트워크 응답
              var networkResponseObjectOk =
                  postReissueResponse.networkResponseObjectOk!;

              if (networkResponseObjectOk.responseStatusCode == 200) {
                // 정상 응답

                // 응답 Body
                var postReissueResponseBody =
                    networkResponseObjectOk.responseBody!
                        as api_main_server.PostReissueAsyncResponseBodyVo;

                // SSW 정보 갱신
                List<
                        spw_sign_in_member_info
                        .SharedPreferenceWrapperVoOAuth2Info>
                    myOAuth2ObjectList = [];
                for (api_main_server
                    .PostReissueAsyncResponseBodyVoOAuth2Info myOAuth2
                    in postReissueResponseBody.myOAuth2List) {
                  myOAuth2ObjectList.add(spw_sign_in_member_info
                      .SharedPreferenceWrapperVoOAuth2Info(
                          myOAuth2.oauth2TypeCode, myOAuth2.oauth2Id));
                }
                signInMemberInfo.memberUid = postReissueResponseBody.memberUid;
                signInMemberInfo.nickName = postReissueResponseBody.nickName;
                signInMemberInfo.roleCodeList =
                    postReissueResponseBody.roleCodeList;
                signInMemberInfo.tokenType = postReissueResponseBody.tokenType;
                signInMemberInfo.accessToken =
                    postReissueResponseBody.accessToken;
                signInMemberInfo.accessTokenExpireWhen =
                    postReissueResponseBody.accessTokenExpireWhen;
                signInMemberInfo.refreshToken =
                    postReissueResponseBody.refreshToken;
                signInMemberInfo.refreshTokenExpireWhen =
                    networkResponseObjectOk
                        .responseBody!.refreshTokenExpireWhen;
                signInMemberInfo.myEmailList =
                    postReissueResponseBody.myEmailList;
                signInMemberInfo.myPhoneNumberList =
                    postReissueResponseBody.myPhoneNumberList;
                signInMemberInfo.myOAuth2List = myOAuth2ObjectList;
                spw_sign_in_member_info.SharedPreferenceWrapper.set(
                    signInMemberInfo);

                // 새로운 AccessToken 으로 재요청
                try {
                  // 기존 Authorization 헤더를 지우고, 이전 요청과 동일한 요청 수행
                  RequestOptions options = response.requestOptions;
                  options.headers.remove("Authorization");
                  options.headers["Authorization"] = "${signInMemberInfo.tokenType} ${signInMemberInfo.accessToken}";
                  Response retryResponse = await mainServerDio.request(
                    options.path,
                    data: options.data,
                    options: Options(
                      method: options.method,
                      headers: options.headers,
                      contentType: options.contentType,
                    ),
                  );

                  // 재요청이 정상 완료 되었으므로 결과를 본 request 코드에 넘겨주기
                  handler.resolve(retryResponse);
                  return;
                } on DioException {
                  // 재요청 실패
                  handler.reject(DioException(
                      error: "Network Error",
                      requestOptions: RequestOptions()));
                  return;
                }
              } else {
                // 비정상 응답
                if (networkResponseObjectOk.responseHeaders.apiErrorCodes ==
                    null) {
                  // 비정상 응답이면서 서버에서 에러 원인 코드가 전달되지 않았을 때
                  handler.reject(DioException(
                      error: "Network Error",
                      requestOptions: RequestOptions()));
                  return;
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

                    // login_user_info SSW 비우기 (= 로그아웃 처리)
                    spw_sign_in_member_info.SharedPreferenceWrapper.set(null);

                    // 호출 코드로 응답 전달
                    handler.resolve(response);
                    return;
                  } else {
                    // 알 수 없는 에러 코드일 때
                    handler.reject(DioException(
                        error: "Network Error",
                        requestOptions: RequestOptions()));
                    return;
                  }
                }
              }
            } else {
              // Dio 네트워크 에러
              handler.reject(DioException(
                  error: "Network Error", requestOptions: RequestOptions()));
              return;
            }
          }
        }
      } else if (apiErrorCodes.contains("b")) {
        // Request Header 에 Authorization 입력시, 존재하지 않는 유저 (reissue, logout API 는 제외)

        // login_user_info SSW 비우기 (= 로그아웃 처리)
        spw_sign_in_member_info.SharedPreferenceWrapper.set(null);

        // 호출 코드로 응답 전달
        handler.resolve(response);
        return;
      } else {
        // 처리할 필요가 없는 에러 코드
        // 호출 코드로 응답 전달
        handler.next(response);
        return;
      }
    } else {
      // JWT 토큰 관련 서버 에러가 없음
      // 호출 코드로 응답 전달
      handler.next(response);
      return;
    }
  }));
}
