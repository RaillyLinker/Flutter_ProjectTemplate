// (external)
import 'package:dio/dio.dart';

// (all)
import 'package:flutter_project_template/repositories/network/network_repositories.dart'
    as network_repositories;
import '../../../global_functions/gf_template_functions.dart'
as gf_template_functions;
import '../../../global_classes/gc_template_classes.dart' as gc_template_classes;
import '../../../global_data/gd_const_config.dart' as gd_const_config;

// [네트워크 API 파일]
// 하나의 Dio 에 대응하는 API 함수 모음 파일

//------------------------------------------------------------------------------
// (서버 Dio 객체)
// 본 파일은 하나의 서버에 대응하며, 사용할 서버 객체는 serverDioObject 에 할당하세요.
final serverDioObject = network_repositories.kauthKakaoCom;

// -----------------------------------------------------------------------------
// !!!네트워크 요청 함수 작성!!

// (Kakao OAuth2 Token 요청)
Future<
    gc_template_classes.NetworkResponseObject<PostOauthTokenAsyncResponseHeaderVo,
        PostOauthTokenAsyncResponseBodyVo>> postOauthTokenAsync(
    PostOauthTokenAsyncRequestBodyVo requestBodyVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/oauth/token";
  String prodServerUrl = "/oauth/token";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestBody["grant_type"] = requestBodyVo.grantType;
  requestBody["client_id"] = requestBodyVo.clientId;
  requestBody["client_secret"] = requestBodyVo.clientSecret;
  requestBody["redirect_url"] = requestBodyVo.redirectUrl;
  requestBody["code"] = requestBodyVo.code;

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      requestQueryParams,
      (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.post(requestUrlAndParam,
        options: Options(
          headers: requestHeaders,
          contentType: Headers.formUrlEncodedContentType,
        ),
        data: requestBody);

    int statusCode = response.statusCode!;
    // Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostOauthTokenAsyncResponseHeaderVo responseHeader;
    PostOauthTokenAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = PostOauthTokenAsyncResponseHeaderVo();
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      // responseBody 로 List 타입이 넘어오면 List<>.from 으로 받고,
      // Object 타입이 넘어오면 Map<String, dynamic> 으로 받고,
      // Object List 타입이 넘어오면 List<Map<String, dynamic>> 으로 받아서 처리

      responseBody = PostOauthTokenAsyncResponseBodyVo(
        responseBodyMap["access_token"],
        responseBodyMap["token_type"],
        responseBodyMap["refresh_token"],
        responseBodyMap["expires_in"],
        responseBodyMap["scope"],
        responseBodyMap["refresh_token_expires_in"],
      );
    }

    return gc_template_classes.NetworkResponseObject(
        gc_template_classes.NetworkResponseObjectOk(
            statusCode, responseHeader, responseBody),
        null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(null, e);
  }
}

class PostOauthTokenAsyncRequestBodyVo {
  String grantType;
  String clientId;
  String clientSecret;
  String redirectUrl;
  String code;

  PostOauthTokenAsyncRequestBodyVo(
    this.grantType,
    this.clientId,
    this.clientSecret,
    this.redirectUrl,
    this.code,
  );
}

class PostOauthTokenAsyncResponseHeaderVo {}

class PostOauthTokenAsyncResponseBodyVo {
  String accessToken;
  String tokenType;
  String refreshToken;
  int expiresIn;
  String scope;
  int refreshTokenExpiresIn;

  PostOauthTokenAsyncResponseBodyVo(
    this.accessToken,
    this.tokenType,
    this.refreshToken,
    this.expiresIn,
    this.scope,
    this.refreshTokenExpiresIn,
  );
}

////
