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
final serverDioObject = network_repositories.accountsGoogleCom;

// -----------------------------------------------------------------------------
// !!!네트워크 요청 함수 작성!!

// (Google OAuth2 Token 요청)
Future<
    gc_my_classes.NetworkResponseObject<PostOOauth2TokenAsyncResponseHeaderVo,
        PostOOauth2TokenAsyncResponseBodyVo>> postOOauth2TokenAsync(
    PostOOauth2TokenAsyncRequestBodyVo requestBodyVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/o/oauth2/token";
  String prodServerUrl = "/o/oauth2/token";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestBody["code"] = requestBodyVo.code;
  requestBody["client_id"] = requestBodyVo.clientId;
  requestBody["client_secret"] = requestBodyVo.clientSecret;
  requestBody["grant_type"] = requestBodyVo.grantType;
  requestBody["redirect_uri"] = requestBodyVo.redirectUri;

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_my_functions.mergeNetworkQueryParam(
      requestQueryParams,
      (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.post(requestUrlAndParam,
        options: Options(
          headers: requestHeaders,
        ),
        data: requestBody);

    int statusCode = response.statusCode!;
    // Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostOOauth2TokenAsyncResponseHeaderVo responseHeader;
    PostOOauth2TokenAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = PostOOauth2TokenAsyncResponseHeaderVo();
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody = PostOOauth2TokenAsyncResponseBodyVo(
        responseBodyMap["access_token"],
        responseBodyMap["expires_in"],
        responseBodyMap["scope"],
        responseBodyMap["token_type"],
        responseBodyMap["id_token"],
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

class PostOOauth2TokenAsyncRequestBodyVo {
  String code;
  String clientId;
  String clientSecret;
  String grantType;
  String redirectUri;

  PostOOauth2TokenAsyncRequestBodyVo(
    this.code,
    this.clientId,
    this.clientSecret,
    this.grantType,
    this.redirectUri,
  );
}

class PostOOauth2TokenAsyncResponseHeaderVo {}

class PostOOauth2TokenAsyncResponseBodyVo {
  String accessToken;
  int expiresIn;
  String scope;
  String tokenType;
  String idToken;

  PostOOauth2TokenAsyncResponseBodyVo(
    this.accessToken,
    this.expiresIn,
    this.scope,
    this.tokenType,
    this.idToken,
  );
}

////
