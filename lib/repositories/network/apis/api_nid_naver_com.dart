// (external)
import 'package:dio/dio.dart';

// (all)
import 'package:flutter_project_template/repositories/network/network_repositories.dart'
    as network_repositories;
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;
import '../../../global_classes/gc_my_classes.dart' as gc_my_classes;
import '../../../global_data/gd_const_config.dart' as gd_const_config;

// [네트워크 API 파일]
// 하나의 Dio 에 대응하는 API 함수 모음 파일

//------------------------------------------------------------------------------
// (서버 Dio 객체)
// 본 파일은 하나의 서버에 대응하며, 사용할 서버 객체는 serverDioObject 에 할당하세요.
final serverDioObject = network_repositories.nidNaverCom;

// -----------------------------------------------------------------------------
// !!!네트워크 요청 함수 작성!!

// (Naver OAuth2 Token 요청)
Future<
    gc_my_classes.NetworkResponseObject<GetOauth2TokenAsyncResponseHeaderVo,
        GetOauth2TokenAsyncResponseBodyVo>> getOauth2TokenAsync(
    GetOauth2TokenAsyncRequestQueryVo requestQueryVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/oauth2.0/token";
  String prodServerUrl = "/oauth2.0/token";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestQueryParams["grant_type"] = requestQueryVo.grantType;
  requestQueryParams["client_id"] = requestQueryVo.clientId;
  requestQueryParams["client_secret"] = requestQueryVo.clientSecret;
  requestQueryParams["redirect_uri"] = requestQueryVo.redirectUri;
  requestQueryParams["code"] = requestQueryVo.code;
  requestQueryParams["state"] = requestQueryVo.state;

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_my_functions.mergeNetworkQueryParam(
      requestQueryParams,
      (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.get(requestUrlAndParam,
        options: Options(
          headers: requestHeaders,
        ));

    int statusCode = response.statusCode!;
    // Map<String, dynamic> responseHeaderMap = response.headers.map;

    GetOauth2TokenAsyncResponseHeaderVo responseHeader;
    GetOauth2TokenAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = GetOauth2TokenAsyncResponseHeaderVo();
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody = GetOauth2TokenAsyncResponseBodyVo(
        responseBodyMap["access_token"],
        responseBodyMap["refresh_token"],
        responseBodyMap["token_type"],
        responseBodyMap["expires_in"],
      );
    }

    return gc_my_classes.NetworkResponseObject(
        gc_my_classes.NetworkResponseObjectOk(
            statusCode, responseHeader, responseBody),
        null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_my_classes.NetworkResponseObject(null, e);
  }
}

class GetOauth2TokenAsyncRequestQueryVo {
  String grantType;
  String clientId;
  String clientSecret;
  String redirectUri;
  String code;
  String state;

  GetOauth2TokenAsyncRequestQueryVo(
    this.grantType,
    this.clientId,
    this.clientSecret,
    this.redirectUri,
    this.code,
    this.state,
  );
}

class GetOauth2TokenAsyncResponseHeaderVo {}

class GetOauth2TokenAsyncResponseBodyVo {
  String accessToken;
  String refreshToken;
  String tokenType;
  String expiresIn;

  GetOauth2TokenAsyncResponseBodyVo(
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.expiresIn,
  );
}

////
// (Naver OAuth2 Token 삭제 요청)
Future<
    gc_my_classes.NetworkResponseObject<
        GetOauth2TokenDeleteAsyncResponseHeaderVo,
        GetOauth2TokenDeleteAsyncResponseBodyVo>> getOauth2TokenDeleteAsync(
    GetOauth2TokenDeleteAsyncRequestQueryVo requestQueryVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/oauth2.0/token";
  String prodServerUrl = "/oauth2.0/token";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestQueryParams["grant_type"] = requestQueryVo.grantType;
  requestQueryParams["client_id"] = requestQueryVo.clientId;
  requestQueryParams["client_secret"] = requestQueryVo.clientSecret;
  requestQueryParams["access_token"] = requestQueryVo.accessToken;
  requestQueryParams["service_provider"] = requestQueryVo.serviceProvider;

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_my_functions.mergeNetworkQueryParam(
      requestQueryParams,
      (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.get(requestUrlAndParam,
        options: Options(
          headers: requestHeaders,
        ));

    int statusCode = response.statusCode!;
    // Map<String, dynamic> responseHeaderMap = response.headers.map;

    GetOauth2TokenDeleteAsyncResponseHeaderVo responseHeader;
    GetOauth2TokenDeleteAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = GetOauth2TokenDeleteAsyncResponseHeaderVo();
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody = GetOauth2TokenDeleteAsyncResponseBodyVo(
        responseBodyMap["result"],
        responseBodyMap["access_token"],
      );
    }

    return gc_my_classes.NetworkResponseObject(
        gc_my_classes.NetworkResponseObjectOk(
            statusCode, responseHeader, responseBody),
        null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_my_classes.NetworkResponseObject(null, e);
  }
}

class GetOauth2TokenDeleteAsyncRequestQueryVo {
  String grantType;
  String clientId;
  String clientSecret;
  String accessToken;
  String serviceProvider;

  GetOauth2TokenDeleteAsyncRequestQueryVo(this.grantType, this.clientId,
      this.clientSecret, this.accessToken, this.serviceProvider);
}

class GetOauth2TokenDeleteAsyncResponseHeaderVo {}

class GetOauth2TokenDeleteAsyncResponseBodyVo {
  String result;
  String accessToken;

  GetOauth2TokenDeleteAsyncResponseBodyVo(
    this.result,
    this.accessToken,
  );
}
