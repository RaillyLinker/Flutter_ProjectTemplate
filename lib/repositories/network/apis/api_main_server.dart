// (external)
import 'package:dio/dio.dart';

// (all)
import 'package:flutter_project_template/repositories/network/network_repositories.dart'
    as network_repositories;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../global_data/gd_const_config.dart' as gd_const_config;
import '../../../global_functions/gf_template_functions.dart'
    as gf_template_functions;

// [네트워크 API 파일]
// 하나의 Dio 에 대응하는 API 함수 모음 파일

//------------------------------------------------------------------------------
// (서버 Dio 객체)
// 본 파일은 하나의 서버에 대응하며, 사용할 서버 객체는 serverDioObject 에 할당하세요.
final serverDioObject = network_repositories.mainServerDio;

// -----------------------------------------------------------------------------
// !!!네트워크 요청 함수 작성!!!

// (Get 요청 테스트 (Query Parameter))
Future<
        gc_template_classes.NetworkResponseObject<
            GetService1TkV1RequestTestGetRequestAsyncResponseHeaderVo,
            GetService1TkV1RequestTestGetRequestAsyncResponseBodyVo>>
    getService1TkV1RequestTestGetRequestAsync(
        {required GetService1TkV1RequestTestGetRequestAsyncRequestQueryVo
            requestQueryVo}) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl = "/service1/tk/v1/request-test/get-request";
  String prodServerUrl = "/service1/tk/v1/request-test/get-request";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!!
  requestQueryParams["queryParamString"] = requestQueryVo.queryParamString;
  requestQueryParams["queryParamStringNullable"] =
      requestQueryVo.queryParamStringNullable;
  requestQueryParams["queryParamInt"] = requestQueryVo.queryParamInt;
  requestQueryParams["queryParamIntNullable"] =
      requestQueryVo.queryParamIntNullable;
  requestQueryParams["queryParamDouble"] = requestQueryVo.queryParamDouble;
  requestQueryParams["queryParamDoubleNullable"] =
      requestQueryVo.queryParamDoubleNullable;
  requestQueryParams["queryParamBoolean"] = requestQueryVo.queryParamBoolean;
  requestQueryParams["queryParamBooleanNullable"] =
      requestQueryVo.queryParamBooleanNullable;
  requestQueryParams["queryParamStringList"] =
      requestQueryVo.queryParamStringList;
  requestQueryParams["queryParamStringListNullable"] =
      requestQueryVo.queryParamStringListNullable;

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.get(requestUrlAndParam,
        options: Options(headers: requestHeaders));

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    GetService1TkV1RequestTestGetRequestAsyncResponseHeaderVo responseHeader;
    GetService1TkV1RequestTestGetRequestAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader = GetService1TkV1RequestTestGetRequestAsyncResponseHeaderVo(
        apiResultCode: responseHeaderMap.containsKey("api-result-code")
            ? responseHeaderMap["api-result-code"][0]
            : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      // responseBody 로 List 타입이 넘어오면 List<>.from 으로 받고,
      // Object 타입이 넘어오면 Map<String, dynamic> 으로 받고,
      // Object List 타입이 넘어오면 List<Map<String, dynamic>> 으로 받아서 처리

      responseBody = GetService1TkV1RequestTestGetRequestAsyncResponseBodyVo(
          queryParamString: responseBodyMap["queryParamString"],
          queryParamStringNullable: responseBodyMap["queryParamStringNullable"],
          queryParamInt: responseBodyMap["queryParamInt"],
          queryParamIntNullable: responseBodyMap["queryParamIntNullable"],
          queryParamDouble: responseBodyMap["queryParamDouble"],
          queryParamDoubleNullable: responseBodyMap["queryParamDoubleNullable"],
          queryParamBoolean: responseBodyMap["queryParamBoolean"],
          queryParamBooleanNullable:
              responseBodyMap["queryParamBooleanNullable"],
          queryParamStringList:
              List<String>.from(responseBodyMap["queryParamStringList"]),
          queryParamStringListNullable:
              (responseBodyMap["queryParamStringListNullable"] == null)
                  ? null
                  : List<String>.from(
                      responseBodyMap["queryParamStringListNullable"]));
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class GetService1TkV1RequestTestGetRequestAsyncRequestQueryVo {
  GetService1TkV1RequestTestGetRequestAsyncRequestQueryVo(
      {required this.queryParamString,
      required this.queryParamStringNullable,
      required this.queryParamInt,
      required this.queryParamIntNullable,
      required this.queryParamDouble,
      required this.queryParamDoubleNullable,
      required this.queryParamBoolean,
      required this.queryParamBooleanNullable,
      required this.queryParamStringList,
      required this.queryParamStringListNullable});

  String queryParamString; // String 쿼리 파라미터
  String? queryParamStringNullable; // String 쿼리 파라미터 Nullable
  int queryParamInt; // int 쿼리 파라미터
  int? queryParamIntNullable; // int 쿼리 파라미터 Nullable
  double queryParamDouble; // double 쿼리 파라미터
  double? queryParamDoubleNullable; // double 쿼리 파라미터 Nullable
  bool queryParamBoolean; // bool 쿼리 파라미터
  bool? queryParamBooleanNullable; // bool 쿼리 파라미터 Nullable
  List<String> queryParamStringList; // StringList 쿼리 파라미터
  List<String>? queryParamStringListNullable; // StringList 쿼리 파라미터 Nullable
}

class GetService1TkV1RequestTestGetRequestAsyncResponseHeaderVo {
  GetService1TkV1RequestTestGetRequestAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  String? apiResultCode;
}

class GetService1TkV1RequestTestGetRequestAsyncResponseBodyVo {
  GetService1TkV1RequestTestGetRequestAsyncResponseBodyVo(
      {required this.queryParamString,
      required this.queryParamStringNullable,
      required this.queryParamInt,
      required this.queryParamIntNullable,
      required this.queryParamDouble,
      required this.queryParamDoubleNullable,
      required this.queryParamBoolean,
      required this.queryParamBooleanNullable,
      required this.queryParamStringList,
      required this.queryParamStringListNullable});

  String queryParamString; // 입력한 String 쿼리 파라미터
  String? queryParamStringNullable; // 입력한 String 쿼리 파라미터 Nullable
  int queryParamInt; // 입력한 int 쿼리 파라미터
  int? queryParamIntNullable; // 입력한 int 쿼리 파라미터 Nullable
  double queryParamDouble; // 입력한 double 쿼리 파라미터
  double? queryParamDoubleNullable; // 입력한 double 쿼리 파라미터 Nullable
  bool queryParamBoolean; // 입력한 bool 쿼리 파라미터
  bool? queryParamBooleanNullable; // 입력한 bool 쿼리 파라미터 Nullable
  List<String> queryParamStringList; // 입력한 StringList 쿼리 파라미터
  List<String>? queryParamStringListNullable; // 입력한 StringList 쿼리 파라미터 Nullable

  @override
  String toString() {
    return "queryParamString : $queryParamString, "
        "queryParamStringNullable : $queryParamStringNullable, "
        "queryParamInt : $queryParamInt, "
        "queryParamIntNullable : $queryParamIntNullable, "
        "queryParamDouble : $queryParamDouble, "
        "queryParamDoubleNullable : $queryParamDoubleNullable, "
        "queryParamBoolean : $queryParamBoolean, "
        "queryParamBooleanNullable : $queryParamBooleanNullable, "
        "queryParamStringList : $queryParamStringList, "
        "queryParamStringListNullable : $queryParamStringListNullable";
  }
}

////
// (Post 요청 테스트 (Request Body))
Future<
        gc_template_classes.NetworkResponseObject<
            PostService1TkV1RequestTestPostRequestApplicationJsonAsyncResponseHeaderVo,
            PostService1TkV1RequestTestPostRequestApplicationJsonAsyncResponseBodyVo>>
    postService1TkV1RequestTestPostRequestApplicationJsonAsync(
        {required PostService1TkV1RequestTestPostRequestApplicationJsonAsyncRequestBodyVo
            requestBodyVo}) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl =
      "/service1/tk/v1/request-test/post-request-application-json";
  String prodServerUrl =
      "/service1/tk/v1/request-test/post-request-application-json";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!!
  requestBody["requestBodyString"] = requestBodyVo.requestBodyString;
  requestBody["requestBodyStringNullable"] =
      requestBodyVo.requestBodyStringNullable;
  requestBody["requestBodyInt"] = requestBodyVo.requestBodyInt;
  requestBody["requestBodyIntNullable"] = requestBodyVo.requestBodyIntNullable;
  requestBody["requestBodyDouble"] = requestBodyVo.requestBodyDouble;
  requestBody["requestBodyDoubleNullable"] =
      requestBodyVo.requestBodyDoubleNullable;
  requestBody["requestBodyBoolean"] = requestBodyVo.requestBodyBoolean;
  requestBody["requestBodyBooleanNullable"] =
      requestBodyVo.requestBodyBooleanNullable;
  requestBody["requestBodyStringList"] = requestBodyVo.requestBodyStringList;
  requestBody["requestBodyStringListNullable"] =
      requestBodyVo.requestBodyStringListNullable;

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.post(requestUrlAndParam,
        options: Options(
          headers: requestHeaders,
        ),
        data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostService1TkV1RequestTestPostRequestApplicationJsonAsyncResponseHeaderVo
        responseHeader;
    PostService1TkV1RequestTestPostRequestApplicationJsonAsyncResponseBodyVo?
        responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader =
        PostService1TkV1RequestTestPostRequestApplicationJsonAsyncResponseHeaderVo(
            apiResultCode: responseHeaderMap.containsKey("api-result-code")
                ? responseHeaderMap["api-result-code"][0]
                : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      // responseBody 로 List 타입이 넘어오면 List<>.from 으로 받고,
      // Object 타입이 넘어오면 Map<String, dynamic> 으로 받고,
      // Object List 타입이 넘어오면 List<Map<String, dynamic>> 으로 받아서 처리

      responseBody =
          PostService1TkV1RequestTestPostRequestApplicationJsonAsyncResponseBodyVo(
              requestBodyString: responseBodyMap["requestBodyString"],
              requestBodyStringNullable:
                  responseBodyMap["requestBodyStringNullable"],
              requestBodyInt: responseBodyMap["requestBodyInt"],
              requestBodyIntNullable: responseBodyMap["requestBodyIntNullable"],
              requestBodyDouble: responseBodyMap["requestBodyDouble"],
              requestBodyDoubleNullable:
                  responseBodyMap["requestBodyDoubleNullable"],
              requestBodyBoolean: responseBodyMap["requestBodyBoolean"],
              requestBodyBooleanNullable:
                  responseBodyMap["requestBodyBooleanNullable"],
              requestBodyStringList:
                  List<String>.from(responseBodyMap["requestBodyStringList"]),
              requestBodyStringListNullable:
                  (responseBodyMap["requestBodyStringListNullable"] == null)
                      ? null
                      : List<String>.from(
                          responseBodyMap["requestBodyStringListNullable"]));
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class PostService1TkV1RequestTestPostRequestApplicationJsonAsyncRequestBodyVo {
  PostService1TkV1RequestTestPostRequestApplicationJsonAsyncRequestBodyVo(
      {required this.requestBodyString,
      required this.requestBodyStringNullable,
      required this.requestBodyInt,
      required this.requestBodyIntNullable,
      required this.requestBodyDouble,
      required this.requestBodyDoubleNullable,
      required this.requestBodyBoolean,
      required this.requestBodyBooleanNullable,
      required this.requestBodyStringList,
      required this.requestBodyStringListNullable});

  String requestBodyString; // String 쿼리 파라미터
  String? requestBodyStringNullable; // String 쿼리 파라미터 Nullable
  int requestBodyInt; // int 쿼리 파라미터
  int? requestBodyIntNullable; // int 쿼리 파라미터 Nullable
  double requestBodyDouble; // double 쿼리 파라미터
  double? requestBodyDoubleNullable; // double 쿼리 파라미터 Nullable
  bool requestBodyBoolean; // bool 쿼리 파라미터
  bool? requestBodyBooleanNullable; // bool 쿼리 파라미터 Nullable
  List<String> requestBodyStringList; // StringList 쿼리 파라미터
  List<String>? requestBodyStringListNullable; // StringList 쿼리 파라미터 Nullable
}

class PostService1TkV1RequestTestPostRequestApplicationJsonAsyncResponseHeaderVo {
  PostService1TkV1RequestTestPostRequestApplicationJsonAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  String apiResultCode;
}

class PostService1TkV1RequestTestPostRequestApplicationJsonAsyncResponseBodyVo {
  PostService1TkV1RequestTestPostRequestApplicationJsonAsyncResponseBodyVo(
      {required this.requestBodyString,
      required this.requestBodyStringNullable,
      required this.requestBodyInt,
      required this.requestBodyIntNullable,
      required this.requestBodyDouble,
      required this.requestBodyDoubleNullable,
      required this.requestBodyBoolean,
      required this.requestBodyBooleanNullable,
      required this.requestBodyStringList,
      required this.requestBodyStringListNullable});

  String requestBodyString; // 입력한 String 쿼리 파라미터
  String? requestBodyStringNullable; // 입력한 String 쿼리 파라미터 Nullable
  int requestBodyInt; // 입력한 int 쿼리 파라미터
  int? requestBodyIntNullable; // 입력한 int 쿼리 파라미터 Nullable
  double requestBodyDouble; // 입력한 double 쿼리 파라미터
  double? requestBodyDoubleNullable; // 입력한 double 쿼리 파라미터 Nullable
  bool requestBodyBoolean; // 입력한 bool 쿼리 파라미터
  bool? requestBodyBooleanNullable; // 입력한 bool 쿼리 파라미터 Nullable
  List<String> requestBodyStringList; // 입력한 StringList 쿼리 파라미터
  List<String>?
      requestBodyStringListNullable; // 입력한 StringList 쿼리 파라미터 Nullable

  @override
  String toString() {
    return "requestBodyString : $requestBodyString, "
        "requestBodyStringNullable : $requestBodyStringNullable, "
        "requestBodyInt : $requestBodyInt, "
        "requestBodyIntNullable : $requestBodyIntNullable, "
        "requestBodyDouble : $requestBodyDouble, "
        "requestBodyDoubleNullable : $requestBodyDoubleNullable, "
        "requestBodyBoolean : $requestBodyBoolean, "
        "requestBodyBooleanNullable : $requestBodyBooleanNullable, "
        "requestBodyStringList : $requestBodyStringList, "
        "requestBodyStringListNullable : $requestBodyStringListNullable";
  }
}

////
// (Post 요청 테스트 (x-www-form-urlencoded))
Future<
        gc_template_classes.NetworkResponseObject<
            PostService1TkV1RequestTestPostRequestXWwwFromUrlencodedAsyncResponseHeaderVo,
            PostService1TkV1RequestTestPostRequestXWwwFromUrlencodedAsyncResponseBodyVo>>
    postService1TkV1RequestTestPostRequestXWwwFromUrlencodedAsync(
        {required PostService1TkV1RequestTestPostRequestXWwwFromUrlencodedAsyncRequestBodyVo
            requestBodyVo}) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl =
      "/service1/tk/v1/request-test/post-request-x-www-form-urlencoded";
  String prodServerUrl =
      "/service1/tk/v1/request-test/post-request-x-www-form-urlencoded";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!!
  requestBody["requestFormString"] = requestBodyVo.requestFormString;
  requestBody["requestFormStringNullable"] =
      requestBodyVo.requestFormStringNullable;
  requestBody["requestFormInt"] = requestBodyVo.requestFormInt;
  requestBody["requestFormIntNullable"] = requestBodyVo.requestFormIntNullable;
  requestBody["requestFormDouble"] = requestBodyVo.requestFormDouble;
  requestBody["requestFormDoubleNullable"] =
      requestBodyVo.requestFormDoubleNullable;
  requestBody["requestFormBoolean"] = requestBodyVo.requestFormBoolean;
  requestBody["requestFormBooleanNullable"] =
      requestBodyVo.requestFormBooleanNullable;
  requestBody["requestFormStringList"] = requestBodyVo.requestFormStringList;
  requestBody["requestFormStringListNullable"] =
      requestBodyVo.requestFormStringListNullable;

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.post(requestUrlAndParam,
        options: Options(
            headers: requestHeaders,
            contentType: Headers.formUrlEncodedContentType),
        data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostService1TkV1RequestTestPostRequestXWwwFromUrlencodedAsyncResponseHeaderVo
        responseHeader;
    PostService1TkV1RequestTestPostRequestXWwwFromUrlencodedAsyncResponseBodyVo?
        responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader =
        PostService1TkV1RequestTestPostRequestXWwwFromUrlencodedAsyncResponseHeaderVo(
            apiResultCode: responseHeaderMap.containsKey("api-result-code")
                ? responseHeaderMap["api-result-code"][0]
                : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      // responseBody 로 List 타입이 넘어오면 List<>.from 으로 받고,
      // Object 타입이 넘어오면 Map<String, dynamic> 으로 받고,
      // Object List 타입이 넘어오면 List<Map<String, dynamic>> 으로 받아서 처리

      responseBody =
          PostService1TkV1RequestTestPostRequestXWwwFromUrlencodedAsyncResponseBodyVo(
              requestFormString: responseBodyMap["requestFormString"],
              requestFormStringNullable:
                  responseBodyMap["requestFormStringNullable"],
              requestFormInt: responseBodyMap["requestFormInt"],
              requestFormIntNullable: responseBodyMap["requestFormIntNullable"],
              requestFormDouble: responseBodyMap["requestFormDouble"],
              requestFormDoubleNullable:
                  responseBodyMap["requestFormDoubleNullable"],
              requestFormBoolean: responseBodyMap["requestFormBoolean"],
              requestFormBooleanNullable:
                  responseBodyMap["requestFormBooleanNullable"],
              requestFormStringList:
                  List<String>.from(responseBodyMap["requestFormStringList"]),
              requestFormStringListNullable:
                  (responseBodyMap["requestFormStringListNullable"] == null)
                      ? null
                      : List<String>.from(
                          responseBodyMap["requestFormStringListNullable"]));
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class PostService1TkV1RequestTestPostRequestXWwwFromUrlencodedAsyncRequestBodyVo {
  PostService1TkV1RequestTestPostRequestXWwwFromUrlencodedAsyncRequestBodyVo(
      {required this.requestFormString,
      required this.requestFormStringNullable,
      required this.requestFormInt,
      required this.requestFormIntNullable,
      required this.requestFormDouble,
      required this.requestFormDoubleNullable,
      required this.requestFormBoolean,
      required this.requestFormBooleanNullable,
      required this.requestFormStringList,
      required this.requestFormStringListNullable});

  String requestFormString; // String 쿼리 파라미터
  String? requestFormStringNullable; // String 쿼리 파라미터 Nullable
  int requestFormInt; // int 쿼리 파라미터
  int? requestFormIntNullable; // int 쿼리 파라미터 Nullable
  double requestFormDouble; // double 쿼리 파라미터
  double? requestFormDoubleNullable; // double 쿼리 파라미터 Nullable
  bool requestFormBoolean; // bool 쿼리 파라미터
  bool? requestFormBooleanNullable; // bool 쿼리 파라미터 Nullable
  List<String> requestFormStringList; // StringList 쿼리 파라미터
  List<String>? requestFormStringListNullable; // StringList 쿼리 파라미터 Nullable
}

class PostService1TkV1RequestTestPostRequestXWwwFromUrlencodedAsyncResponseHeaderVo {
  PostService1TkV1RequestTestPostRequestXWwwFromUrlencodedAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  String? apiResultCode;
}

class PostService1TkV1RequestTestPostRequestXWwwFromUrlencodedAsyncResponseBodyVo {
  PostService1TkV1RequestTestPostRequestXWwwFromUrlencodedAsyncResponseBodyVo(
      {required this.requestFormString,
      required this.requestFormStringNullable,
      required this.requestFormInt,
      required this.requestFormIntNullable,
      required this.requestFormDouble,
      required this.requestFormDoubleNullable,
      required this.requestFormBoolean,
      required this.requestFormBooleanNullable,
      required this.requestFormStringList,
      required this.requestFormStringListNullable});

  String requestFormString; // 입력한 String 쿼리 파라미터
  String? requestFormStringNullable; // 입력한 String 쿼리 파라미터 Nullable
  int requestFormInt; // 입력한 int 쿼리 파라미터
  int? requestFormIntNullable; // 입력한 int 쿼리 파라미터 Nullable
  double requestFormDouble; // 입력한 double 쿼리 파라미터
  double? requestFormDoubleNullable; // 입력한 double 쿼리 파라미터 Nullable
  bool requestFormBoolean; // 입력한 bool 쿼리 파라미터
  bool? requestFormBooleanNullable; // 입력한 bool 쿼리 파라미터 Nullable
  List<String> requestFormStringList; // 입력한 StringList 쿼리 파라미터
  List<String>?
      requestFormStringListNullable; // 입력한 StringList 쿼리 파라미터 Nullable

  @override
  String toString() {
    return "requestFormString : $requestFormString, "
        "requestFormStringNullable : $requestFormStringNullable, "
        "requestFormInt : $requestFormInt, "
        "requestFormIntNullable : $requestFormIntNullable, "
        "requestFormDouble : $requestFormDouble, "
        "requestFormDoubleNullable : $requestFormDoubleNullable, "
        "requestFormBoolean : $requestFormBoolean, "
        "requestFormBooleanNullable : $requestFormBooleanNullable, "
        "requestFormStringList : $requestFormStringList, "
        "requestFormStringListNullable : $requestFormStringListNullable";
  }
}

////
// (Post 요청 테스트 (multipart/form-data))
Future<
        gc_template_classes.NetworkResponseObject<
            PostService1TkV1RequestTestPostRequestMultipartFormDataAsyncResponseHeaderVo,
            PostService1TkV1RequestTestPostRequestMultipartFormDataAsyncResponseBodyVo>>
    postService1TkV1RequestTestPostRequestMultipartFormDataAsync(
        {required PostService1TkV1RequestTestPostRequestMultipartFormDataAsyncRequestBodyVo
            requestBodyVo}) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl =
      "/service1/tk/v1/request-test/post-request-multipart-form-data";
  String prodServerUrl =
      "/service1/tk/v1/request-test/post-request-multipart-form-data";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestFormDataMap = {};

  // !!!Request Object 를 Map 으로 만들기!!!
  requestFormDataMap["requestFormString"] = requestBodyVo.requestFormString;
  if (requestBodyVo.requestFormStringNullable != null) {
    requestFormDataMap["requestFormStringNullable"] =
        requestBodyVo.requestFormStringNullable;
  }
  requestFormDataMap["requestFormInt"] = requestBodyVo.requestFormInt;
  if (requestBodyVo.requestFormIntNullable != null) {
    requestFormDataMap["requestFormIntNullable"] =
        requestBodyVo.requestFormIntNullable;
  }
  requestFormDataMap["requestFormDouble"] = requestBodyVo.requestFormDouble;
  if (requestBodyVo.requestFormDoubleNullable != null) {
    requestFormDataMap["requestFormDoubleNullable"] =
        requestBodyVo.requestFormDoubleNullable;
  }
  requestFormDataMap["requestFormBoolean"] = requestBodyVo.requestFormBoolean;
  if (requestBodyVo.requestFormBooleanNullable != null) {
    requestFormDataMap["requestFormBooleanNullable"] =
        requestBodyVo.requestFormBooleanNullable;
  }
  requestFormDataMap["requestFormStringList"] =
      requestBodyVo.requestFormStringList;
  if (requestBodyVo.requestFormStringListNullable != null) {
    requestFormDataMap["requestFormStringListNullable"] =
        requestBodyVo.requestFormStringListNullable;
  }
  requestFormDataMap["multipartFile"] = requestBodyVo.multipartFile;
  if (requestBodyVo.multipartFileNullable != null) {
    requestFormDataMap["multipartFileNullable"] =
        requestBodyVo.multipartFileNullable;
  }

  FormData requestBody = FormData.fromMap(requestFormDataMap);

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.post(requestUrlAndParam,
        options: Options(headers: requestHeaders), data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostService1TkV1RequestTestPostRequestMultipartFormDataAsyncResponseHeaderVo
        responseHeader;
    PostService1TkV1RequestTestPostRequestMultipartFormDataAsyncResponseBodyVo?
        responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader =
        PostService1TkV1RequestTestPostRequestMultipartFormDataAsyncResponseHeaderVo(
            apiResultCode: responseHeaderMap.containsKey("api-result-code")
                ? responseHeaderMap["api-result-code"][0]
                : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      // responseBody 로 List 타입이 넘어오면 List<>.from 으로 받고,
      // Object 타입이 넘어오면 Map<String, dynamic> 으로 받고,
      // Object List 타입이 넘어오면 List<Map<String, dynamic>> 으로 받아서 처리

      responseBody =
          PostService1TkV1RequestTestPostRequestMultipartFormDataAsyncResponseBodyVo(
              requestFormString: responseBodyMap["requestFormString"],
              requestFormStringNullable:
                  responseBodyMap["requestFormStringNullable"],
              requestFormInt: responseBodyMap["requestFormInt"],
              requestFormIntNullable: responseBodyMap["requestFormIntNullable"],
              requestFormDouble: responseBodyMap["requestFormDouble"],
              requestFormDoubleNullable:
                  responseBodyMap["requestFormDoubleNullable"],
              requestFormBoolean: responseBodyMap["requestFormBoolean"],
              requestFormBooleanNullable:
                  responseBodyMap["requestFormBooleanNullable"],
              requestFormStringList:
                  List<String>.from(responseBodyMap["requestFormStringList"]),
              requestFormStringListNullable:
                  (responseBodyMap["requestFormStringListNullable"] == null)
                      ? null
                      : List<String>.from(
                          responseBodyMap["requestFormStringListNullable"]));
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class PostService1TkV1RequestTestPostRequestMultipartFormDataAsyncRequestBodyVo {
  PostService1TkV1RequestTestPostRequestMultipartFormDataAsyncRequestBodyVo(
      {required this.requestFormString,
      required this.requestFormStringNullable,
      required this.requestFormInt,
      required this.requestFormIntNullable,
      required this.requestFormDouble,
      required this.requestFormDoubleNullable,
      required this.requestFormBoolean,
      required this.requestFormBooleanNullable,
      required this.requestFormStringList,
      required this.requestFormStringListNullable,
      required this.multipartFile,
      required this.multipartFileNullable});

  String requestFormString; // String 쿼리 파라미터
  String? requestFormStringNullable; // String 쿼리 파라미터 Nullable
  int requestFormInt; // int 쿼리 파라미터
  int? requestFormIntNullable; // int 쿼리 파라미터 Nullable
  double requestFormDouble; // double 쿼리 파라미터
  double? requestFormDoubleNullable; // double 쿼리 파라미터 Nullable
  bool requestFormBoolean; // bool 쿼리 파라미터
  bool? requestFormBooleanNullable; // bool 쿼리 파라미터 Nullable
  List<String> requestFormStringList; // StringList 쿼리 파라미터
  List<String>? requestFormStringListNullable; // StringList 쿼리 파라미터 Nullable
  MultipartFile multipartFile; // 멀티 파트 파일
  MultipartFile? multipartFileNullable; // 멀티 파트 파일 Nullable
}

class PostService1TkV1RequestTestPostRequestMultipartFormDataAsyncResponseHeaderVo {
  PostService1TkV1RequestTestPostRequestMultipartFormDataAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  String? apiResultCode;
}

class PostService1TkV1RequestTestPostRequestMultipartFormDataAsyncResponseBodyVo {
  PostService1TkV1RequestTestPostRequestMultipartFormDataAsyncResponseBodyVo(
      {required this.requestFormString,
      required this.requestFormStringNullable,
      required this.requestFormInt,
      required this.requestFormIntNullable,
      required this.requestFormDouble,
      required this.requestFormDoubleNullable,
      required this.requestFormBoolean,
      required this.requestFormBooleanNullable,
      required this.requestFormStringList,
      required this.requestFormStringListNullable});

  String requestFormString; // 입력한 String 쿼리 파라미터
  String? requestFormStringNullable; // 입력한 String 쿼리 파라미터 Nullable
  int requestFormInt; // 입력한 int 쿼리 파라미터
  int? requestFormIntNullable; // 입력한 int 쿼리 파라미터 Nullable
  double requestFormDouble; // 입력한 double 쿼리 파라미터
  double? requestFormDoubleNullable; // 입력한 double 쿼리 파라미터 Nullable
  bool requestFormBoolean; // 입력한 bool 쿼리 파라미터
  bool? requestFormBooleanNullable; // 입력한 bool 쿼리 파라미터 Nullable
  List<String> requestFormStringList; // 입력한 StringList 쿼리 파라미터
  List<String>?
      requestFormStringListNullable; // 입력한 StringList 쿼리 파라미터 Nullable

  @override
  String toString() {
    return "requestFormString : $requestFormString, "
        "requestFormStringNullable : $requestFormStringNullable, "
        "requestFormInt : $requestFormInt, "
        "requestFormIntNullable : $requestFormIntNullable, "
        "requestFormDouble : $requestFormDouble, "
        "requestFormDoubleNullable : $requestFormDoubleNullable, "
        "requestFormBoolean : $requestFormBoolean, "
        "requestFormBooleanNullable : $requestFormBooleanNullable, "
        "requestFormStringList : $requestFormStringList, "
        "requestFormStringListNullable : $requestFormStringListNullable";
  }
}

////
// (Post 요청 테스트 (multipart/form-data - JsonString))
Future<
        gc_template_classes.NetworkResponseObject<
            PostService1TkV1RequestTestPostRequestMultipartFormDataJsonAsyncResponseHeaderVo,
            PostService1TkV1RequestTestPostRequestMultipartFormDataJsonAsyncResponseBodyVo>>
    postService1TkV1RequestTestPostRequestMultipartFormDataJsonAsync(
        {required PostService1TkV1RequestTestPostRequestMultipartFormDataJsonAsyncRequestBodyVo
            requestBodyVo}) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl =
      "/service1/tk/v1/request-test/post-request-multipart-form-data-json";
  String prodServerUrl =
      "/service1/tk/v1/request-test/post-request-multipart-form-data-json";
  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  FormData requestBody;

  // !!!Request Object 를 Map 으로 만들기!!!
  if (requestBodyVo.multipartFileNullable == null) {
    requestBody = FormData.fromMap({
      "jsonString": requestBodyVo.jsonString,
      "multipartFile": requestBodyVo.multipartFile
    });
  } else {
    requestBody = FormData.fromMap({
      "jsonString": requestBodyVo.jsonString,
      "multipartFile": requestBodyVo.multipartFile,
      "multipartFileNullable": requestBodyVo.multipartFileNullable
    });
  }

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.post(requestUrlAndParam,
        options: Options(headers: requestHeaders), data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostService1TkV1RequestTestPostRequestMultipartFormDataJsonAsyncResponseHeaderVo
        responseHeader;
    PostService1TkV1RequestTestPostRequestMultipartFormDataJsonAsyncResponseBodyVo?
        responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader =
        PostService1TkV1RequestTestPostRequestMultipartFormDataJsonAsyncResponseHeaderVo(
            apiResultCode: responseHeaderMap.containsKey("api-result-code")
                ? responseHeaderMap["api-result-code"][0]
                : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      // responseBody 로 List 타입이 넘어오면 List<>.from 으로 받고,
      // Object 타입이 넘어오면 Map<String, dynamic> 으로 받고,
      // Object List 타입이 넘어오면 List<Map<String, dynamic>> 으로 받아서 처리

      responseBody =
          PostService1TkV1RequestTestPostRequestMultipartFormDataJsonAsyncResponseBodyVo(
              requestFormString: responseBodyMap["requestFormString"],
              requestFormStringNullable:
                  responseBodyMap["requestFormStringNullable"],
              requestFormInt: responseBodyMap["requestFormInt"],
              requestFormIntNullable: responseBodyMap["requestFormIntNullable"],
              requestFormDouble: responseBodyMap["requestFormDouble"],
              requestFormDoubleNullable:
                  responseBodyMap["requestFormDoubleNullable"],
              requestFormBoolean: responseBodyMap["requestFormBoolean"],
              requestFormBooleanNullable:
                  responseBodyMap["requestFormBooleanNullable"],
              requestFormStringList:
                  List<String>.from(responseBodyMap["requestFormStringList"]),
              requestFormStringListNullable:
                  (responseBodyMap["requestFormStringListNullable"] == null)
                      ? null
                      : List<String>.from(
                          responseBodyMap["requestFormStringListNullable"]));
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class PostService1TkV1RequestTestPostRequestMultipartFormDataJsonAsyncRequestBodyVo {
  PostService1TkV1RequestTestPostRequestMultipartFormDataJsonAsyncRequestBodyVo(
      {required this.jsonString,
      required this.multipartFile,
      required this.multipartFileNullable});

  // "jsonString" 형식 :
  // {
  // "requestFormString" :	String, // String 바디 파라미터
  // "requestFormStringNullable" :	String?, // String 바디 파라미터 Nullable
  // "requestFormInt" : Int, // Int 바디 파라미터
  // "requestFormIntNullable" : Int?, // Int 바디 파라미터 Nullable
  // "requestFormDouble" : Double, // Double 바디 파라미터
  // "requestFormDoubleNullable" : Double?, // Double 바디 파라미터 Nullable
  // "requestFormBoolean" : boolean, // Boolean 바디 파라미터
  // "requestFormBooleanNullable" : boolean?, // Boolean 바디 파라미터 Nullable
  // "requestFormStringList" : List<String>, // StringList 바디 파라미터
  // "requestFormStringListNullable" : List<String>? // StringList 바디 파라미터 Nullable
  // }
  String jsonString; // json 형식 String
  MultipartFile multipartFile; // 멀티 파트 파일
  MultipartFile? multipartFileNullable; // 멀티 파트 파일 Nullable
}

class PostService1TkV1RequestTestPostRequestMultipartFormDataJsonAsyncResponseHeaderVo {
  PostService1TkV1RequestTestPostRequestMultipartFormDataJsonAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  String? apiResultCode;
}

class PostService1TkV1RequestTestPostRequestMultipartFormDataJsonAsyncResponseBodyVo {
  PostService1TkV1RequestTestPostRequestMultipartFormDataJsonAsyncResponseBodyVo(
      {required this.requestFormString,
      required this.requestFormStringNullable,
      required this.requestFormInt,
      required this.requestFormIntNullable,
      required this.requestFormDouble,
      required this.requestFormDoubleNullable,
      required this.requestFormBoolean,
      required this.requestFormBooleanNullable,
      required this.requestFormStringList,
      required this.requestFormStringListNullable});

  String requestFormString; // 입력한 String 쿼리 파라미터
  String? requestFormStringNullable; // 입력한 String 쿼리 파라미터 Nullable
  int requestFormInt; // 입력한 int 쿼리 파라미터
  int? requestFormIntNullable; // 입력한 int 쿼리 파라미터 Nullable
  double requestFormDouble; // 입력한 double 쿼리 파라미터
  double? requestFormDoubleNullable; // 입력한 double 쿼리 파라미터 Nullable
  bool requestFormBoolean; // 입력한 bool 쿼리 파라미터
  bool? requestFormBooleanNullable; // 입력한 bool 쿼리 파라미터 Nullable
  List<String> requestFormStringList; // 입력한 StringList 쿼리 파라미터
  List<String>?
      requestFormStringListNullable; // 입력한 StringList 쿼리 파라미터 Nullable

  @override
  String toString() {
    return "requestFormString : $requestFormString, "
        "requestFormStringNullable : $requestFormStringNullable, "
        "requestFormInt : $requestFormInt, "
        "requestFormIntNullable : $requestFormIntNullable, "
        "requestFormDouble : $requestFormDouble, "
        "requestFormDoubleNullable : $requestFormDoubleNullable, "
        "requestFormBoolean : $requestFormBoolean, "
        "requestFormBooleanNullable : $requestFormBooleanNullable, "
        "requestFormStringList : $requestFormStringList, "
        "requestFormStringListNullable : $requestFormStringListNullable";
  }
}

////
// (인위적 에러 수신 테스트)
// 서버에서 송신하는 인위적 에러 수신 테스트
Future<
        gc_template_classes.NetworkResponseObject<
            PostService1TkV1RequestTestGenerateErrorAsyncResponseHeaderVo,
            PostService1TkV1RequestTestGenerateErrorAsyncResponseBodyVo>>
    postService1TkV1RequestTestGenerateErrorAsync() async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl = "/service1/tk/v1/request-test/generate-error";
  String prodServerUrl = "/service1/tk/v1/request-test/generate-error";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!!

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.post(requestUrlAndParam,
        options: Options(headers: requestHeaders), data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostService1TkV1RequestTestGenerateErrorAsyncResponseHeaderVo
        responseHeader;
    PostService1TkV1RequestTestGenerateErrorAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader =
        PostService1TkV1RequestTestGenerateErrorAsyncResponseHeaderVo(
            apiResultCode: responseHeaderMap.containsKey("api-result-code")
                ? responseHeaderMap["api-result-code"][0]
                : null);
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class PostService1TkV1RequestTestGenerateErrorAsyncResponseHeaderVo {
  PostService1TkV1RequestTestGenerateErrorAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  String? apiResultCode;
}

class PostService1TkV1RequestTestGenerateErrorAsyncResponseBodyVo {}

////
// (text/string 반환 샘플)
// Response Body 가 text/string 타입입니다.
Future<
    gc_template_classes.NetworkResponseObject<
        GetService1TkV1RequestTestReturnTextStringAsyncResponseHeaderVo,
        String>> getService1TkV1RequestTestReturnTextStringAsync() async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl = "/service1/tk/v1/request-test/return-text-string";
  String prodServerUrl = "/service1/tk/v1/request-test/return-text-string";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!!

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.get(requestUrlAndParam,
        options: Options(headers: requestHeaders));

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    GetService1TkV1RequestTestReturnTextStringAsyncResponseHeaderVo
        responseHeader;
    String? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader =
        GetService1TkV1RequestTestReturnTextStringAsyncResponseHeaderVo(
            apiResultCode: responseHeaderMap.containsKey("api-result-code")
                ? responseHeaderMap["api-result-code"][0]
                : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건

      responseBody = response.data;
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class GetService1TkV1RequestTestReturnTextStringAsyncResponseHeaderVo {
  GetService1TkV1RequestTestReturnTextStringAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  String? apiResultCode;
}

class GetRequestReturnTextStringAsyncResponseBodyVo {
  GetRequestReturnTextStringAsyncResponseBodyVo();
}

////
// (text/html 반환 샘플)
// Response Body 가 text/html 타입입니다.
Future<
    gc_template_classes.NetworkResponseObject<
        GetService1TkV1RequestTestReturnTextHtmlAsyncResponseHeaderVo,
        String>> getService1TkV1RequestTestReturnTextHtmlAsync() async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl = "/service1/tk/v1/request-test/return-text-html";
  String prodServerUrl = "/service1/tk/v1/request-test/return-text-html";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!!

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.get(requestUrlAndParam,
        options: Options(headers: requestHeaders));

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    GetService1TkV1RequestTestReturnTextHtmlAsyncResponseHeaderVo
        responseHeader;
    String? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader =
        GetService1TkV1RequestTestReturnTextHtmlAsyncResponseHeaderVo(
            apiResultCode: responseHeaderMap.containsKey("api-result-code")
                ? responseHeaderMap["api-result-code"][0]
                : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      responseBody = response.data;
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class GetService1TkV1RequestTestReturnTextHtmlAsyncResponseHeaderVo {
  GetService1TkV1RequestTestReturnTextHtmlAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  String? apiResultCode;
}

class GetRequestReturnTextHtmlAsyncResponseBodyVo {
  GetRequestReturnTextHtmlAsyncResponseBodyVo();
}

////
// (서버에 저장된 어플리케이션 버전 정보 가져오기)
Future<
        gc_template_classes.NetworkResponseObject<
            GetMobileAppVersionInfoAsyncResponseHeaderVo,
            GetMobileAppVersionInfoAsyncResponseBodyVo>>
    getClientApplicationVersionInfoAsync(
        {required GetMobileAppVersionInfoAsyncRequestQueryVo
            requestQueryVo}) async {
  // !!!서버 API 가 준비되면 더미 데이터 return 제거!!!
  return gc_template_classes.NetworkResponseObject(
      networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
          responseStatusCode: 200,
          responseHeaders:
              GetMobileAppVersionInfoAsyncResponseHeaderVo(apiResultCode: "0"),
          responseBody: GetMobileAppVersionInfoAsyncResponseBodyVo(
              minUpgradeVersion: "1.0.0", latestVersion: "1.0.0")),
      dioException: null);

  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl = "/server-app-version-info";
  String prodServerUrl = "/server-app-version-info";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!!
  requestQueryParams["platformCode"] = requestQueryVo.platformCode;

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.get(requestUrlAndParam,
        options: Options(headers: requestHeaders));

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    GetMobileAppVersionInfoAsyncResponseHeaderVo responseHeader;
    GetMobileAppVersionInfoAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader = GetMobileAppVersionInfoAsyncResponseHeaderVo(
        apiResultCode: responseHeaderMap.containsKey("api-result-code")
            ? responseHeaderMap["api-result-code"][0]
            : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      // responseBody 로 List 타입이 넘어오면 List<>.from 으로 받고,
      // Object 타입이 넘어오면 Map<String, dynamic> 으로 받고,
      // Object List 타입이 넘어오면 List<Map<String, dynamic>> 으로 받아서 처리

      responseBody = GetMobileAppVersionInfoAsyncResponseBodyVo(
          minUpgradeVersion: responseBodyMap["minUpgradeVersion"],
          latestVersion: responseBodyMap["latestVersion"]);
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class GetMobileAppVersionInfoAsyncRequestQueryVo {
  GetMobileAppVersionInfoAsyncRequestQueryVo({required this.platformCode});

  // 플랫폼 코드 (1 : web, 2 : android, 3 : ios, 4 : windows, 5 : macos, 6 : linux)
  int platformCode;
}

class GetMobileAppVersionInfoAsyncResponseHeaderVo {
  GetMobileAppVersionInfoAsyncResponseHeaderVo({required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  String? apiResultCode;
}

class GetMobileAppVersionInfoAsyncResponseBodyVo {
  GetMobileAppVersionInfoAsyncResponseBodyVo(
      {required this.minUpgradeVersion, required this.latestVersion});

  String minUpgradeVersion; // 최소 필요 버전, ex : "1.0.0"
  String latestVersion; // 최신 버전, ex : "1.0.0"
}

////
// (로그인 요청 with password)
// 서버 로그인 검증 요청 후 인증 정보 수신
Future<
        gc_template_classes.NetworkResponseObject<
            PostService1TkV1AuthLoginWithPasswordAsyncResponseHeaderVo,
            PostService1TkV1AuthLoginWithPasswordAsyncResponseBodyVo>>
    postService1TkV1AuthLoginWithPasswordAsync(
        {required PostService1TkV1AuthLoginWithPasswordAsyncRequestBodyVo
            requestBodyVo}) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl = "/service1/tk/v1/auth/login-with-password";
  String prodServerUrl = "/service1/tk/v1/auth/login-with-password";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!!
  requestBody["loginTypeCode"] = requestBodyVo.loginTypeCode;
  requestBody["id"] = requestBodyVo.id;
  requestBody["password"] = requestBodyVo.password;

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.post(requestUrlAndParam,
        options: Options(headers: requestHeaders), data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostService1TkV1AuthLoginWithPasswordAsyncResponseHeaderVo responseHeader;
    PostService1TkV1AuthLoginWithPasswordAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader = PostService1TkV1AuthLoginWithPasswordAsyncResponseHeaderVo(
        apiResultCode: responseHeaderMap.containsKey("api-result-code")
            ? responseHeaderMap["api-result-code"][0]
            : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      // responseBody 로 List 타입이 넘어오면 List<>.from 으로 받고,
      // Object 타입이 넘어오면 Map<String, dynamic> 으로 받고,
      // Object List 타입이 넘어오면 List<Map<String, dynamic>> 으로 받아서 처리

      var oAuth2List =
          List<Map<String, dynamic>>.from(responseBodyMap["myOAuth2List"]);
      List<PostSignInWithPasswordAsyncResponseBodyVoOAuth2Info>
          oAuth2ObjectList = [];
      for (Map<String, dynamic> oAuth2 in oAuth2List) {
        oAuth2ObjectList.add(
            PostSignInWithPasswordAsyncResponseBodyVoOAuth2Info(
                uid: oAuth2["uid"],
                oauth2TypeCode: oAuth2["oauth2TypeCode"],
                oauth2Id: oAuth2["oauth2Id"]));
      }

      var myProfileList =
          List<Map<String, dynamic>>.from(responseBodyMap["myProfileList"]);
      List<PostSignInWithPasswordAsyncResponseBodyVoProfile>
          myProfileObjectList = [];
      for (Map<String, dynamic> profile in myProfileList) {
        myProfileObjectList.add(
            PostSignInWithPasswordAsyncResponseBodyVoProfile(
                uid: profile["uid"],
                imageFullUrl: profile["imageFullUrl"],
                isFront: profile["isFront"]));
      }

      var myEmailList =
          List<Map<String, dynamic>>.from(responseBodyMap["myEmailList"]);
      List<PostSignInWithPasswordAsyncResponseBodyVoEmail> myEmailObjectList =
          [];
      for (Map<String, dynamic> profile in myEmailList) {
        myEmailObjectList.add(PostSignInWithPasswordAsyncResponseBodyVoEmail(
            uid: profile["uid"],
            emailAddress: profile["emailAddress"],
            isFront: profile["isFront"]));
      }

      var myPhoneNumberList =
          List<Map<String, dynamic>>.from(responseBodyMap["myPhoneNumberList"]);
      List<PostSignInWithPasswordAsyncResponseBodyVoPhone>
          myPhoneNumberObjectList = [];
      for (Map<String, dynamic> profile in myPhoneNumberList) {
        myPhoneNumberObjectList.add(
            PostSignInWithPasswordAsyncResponseBodyVoPhone(
                uid: profile["uid"],
                phoneNumber: profile["phoneNumber"],
                isFront: profile["isFront"]));
      }

      responseBody = PostService1TkV1AuthLoginWithPasswordAsyncResponseBodyVo(
          memberUid: responseBodyMap["memberUid"],
          nickName: responseBodyMap["nickName"],
          roleList: List<String>.from(responseBodyMap["roleList"]),
          tokenType: responseBodyMap["tokenType"],
          accessToken: responseBodyMap["accessToken"],
          refreshToken: responseBodyMap["refreshToken"],
          accessTokenExpireWhen: responseBodyMap["accessTokenExpireWhen"],
          refreshTokenExpireWhen: responseBodyMap["refreshTokenExpireWhen"],
          myOAuth2List: oAuth2ObjectList,
          myProfileList: myProfileObjectList,
          myEmailList: myEmailObjectList,
          myPhoneNumberList: myPhoneNumberObjectList,
          authPasswordIsNull: responseBodyMap["authPasswordIsNull"]);
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class PostService1TkV1AuthLoginWithPasswordAsyncRequestBodyVo {
  PostService1TkV1AuthLoginWithPasswordAsyncRequestBodyVo(
      {required this.loginTypeCode, required this.id, required this.password});

  int loginTypeCode; // 로그인 타입 (0 : 닉네임, 1 : 이메일, 2 : 전화번호)
  String id; // 아이디 (0 : 홍길동, 1 : test@gmail.com, 2 : 82)000-0000-0000)
  String password; // 비밀번호
}

class PostService1TkV1AuthLoginWithPasswordAsyncResponseHeaderVo {
  PostService1TkV1AuthLoginWithPasswordAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  // 1 : 가입 되지 않은 회원
  // 2 : 패스워드 불일치
  String? apiResultCode;
}

class PostService1TkV1AuthLoginWithPasswordAsyncResponseBodyVo {
  PostService1TkV1AuthLoginWithPasswordAsyncResponseBodyVo(
      {required this.memberUid,
      required this.nickName,
      required this.roleList,
      required this.tokenType,
      required this.accessToken,
      required this.refreshToken,
      required this.accessTokenExpireWhen,
      required this.refreshTokenExpireWhen,
      required this.myOAuth2List,
      required this.myProfileList,
      required this.myEmailList,
      required this.myPhoneNumberList,
      required this.authPasswordIsNull});

  int memberUid; // 멤버 고유값
  String nickName; // 닉네임
  List<String> roleList; // 권한 리스트 (관리자 : ROLE_ADMIN, 개발자 : ROLE_DEVELOPER)
  String tokenType; // 인증 토큰 타입 (ex : Bearer)
  String accessToken; // 엑세스 토큰
  String refreshToken; // 리플레시 토큰
  String accessTokenExpireWhen; // 엑세스 토큰 만료 시간 (yyyy-MM-dd HH:mm:ss.SSS)
  String refreshTokenExpireWhen; // 리플레시 토큰 만료 시간 (yyyy-MM-dd HH:mm:ss.SSS)
  List<PostSignInWithPasswordAsyncResponseBodyVoOAuth2Info>
      myOAuth2List; // 내가 등록한 OAuth2 정보 리스트
  List<PostSignInWithPasswordAsyncResponseBodyVoProfile>
      myProfileList; // 내가 등록한 Profile 정보 리스트
  List<PostSignInWithPasswordAsyncResponseBodyVoEmail>
      myEmailList; // 내가 등록한 이메일 정보 리스트
  List<PostSignInWithPasswordAsyncResponseBodyVoPhone>
      myPhoneNumberList; // 내가 등록한 전화번호 정보 리스트
  bool
      authPasswordIsNull; // 계정 로그인 비밀번호 설정 Null 여부 (OAuth2 만으로 회원가입한 경우는 비밀번호가 없으므로 true)
}

class PostSignInWithPasswordAsyncResponseBodyVoOAuth2Info {
  PostSignInWithPasswordAsyncResponseBodyVoOAuth2Info(
      {required this.uid,
      required this.oauth2TypeCode,
      required this.oauth2Id});

  int uid; // 행 고유값
  int oauth2TypeCode; // OAuth2 (1 : Google, 2 : Naver, 3 : Kakao, 4 : Apple)
  String oauth2Id; // oAuth2 고유값 아이디
}

class PostSignInWithPasswordAsyncResponseBodyVoProfile {
  PostSignInWithPasswordAsyncResponseBodyVoProfile(
      {required this.uid, required this.imageFullUrl, required this.isFront});

  int uid; // 행 고유값
  String imageFullUrl; // 프로필 이미지 Full URL
  bool isFront; // 표 프로필 여부
}

class PostSignInWithPasswordAsyncResponseBodyVoEmail {
  PostSignInWithPasswordAsyncResponseBodyVoEmail(
      {required this.uid, required this.emailAddress, required this.isFront});

  int uid; // 행 고유값
  String emailAddress; // 이메일 주소
  bool isFront; // 대표 이메일 여부
}

class PostSignInWithPasswordAsyncResponseBodyVoPhone {
  PostSignInWithPasswordAsyncResponseBodyVoPhone(
      {required this.uid, required this.phoneNumber, required this.isFront});

  int uid; // 행 고유값
  String phoneNumber; // 전화번호
  bool isFront; // 대표 전화번호 여부
}

////
// (로그아웃 요청 <>)
// 서버 로그인 검증 요청 후 인증 정보 수신
Future<
        gc_template_classes.NetworkResponseObject<
            PostService1TkV1AuthLogoutAsyncResponseHeaderVo,
            PostService1TkV1AuthLogoutAsyncResponseBodyVo>>
    postService1TkV1AuthLogoutAsync(
        {required PostService1TkV1AuthLogoutAsyncRequestHeaderVo
            requestHeaderVo}) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl = "/service1/tk/v1/auth/logout";
  String prodServerUrl = "/service1/tk/v1/auth/logout";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!!
  requestHeaders["Authorization"] = requestHeaderVo.authorization;

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.post(requestUrlAndParam,
        options: Options(headers: requestHeaders), data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostService1TkV1AuthLogoutAsyncResponseHeaderVo responseHeader;
    PostService1TkV1AuthLogoutAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader = PostService1TkV1AuthLogoutAsyncResponseHeaderVo(
        apiResultCode: responseHeaderMap.containsKey("api-result-code")
            ? responseHeaderMap["api-result-code"][0]
            : null);
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class PostService1TkV1AuthLogoutAsyncRequestHeaderVo {
  PostService1TkV1AuthLogoutAsyncRequestHeaderVo({required this.authorization});

  // 인증 토큰 (ex : "Bearer abcd1234!@#$")
  String authorization;
}

class PostService1TkV1AuthLogoutAsyncResponseHeaderVo {
  PostService1TkV1AuthLogoutAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  String? apiResultCode;
}

class PostService1TkV1AuthLogoutAsyncResponseBodyVo {}

////
// (멤버의 현재 발행된 모든 리프레시 토큰 비활성화 (= 모든 기기에서 로그아웃) 요청 <>)
// 멤버의 현재 발행된 모든 리프레시 토큰을 비활성화 (= 모든 기기에서 로그아웃) 하는 API
// 한번 발행된 액세스 토큰을 강제로 못쓰게 만들 수는 없지만, 현재 발행된 모든 리플래시 토큰을 사용할 수 없도록 만듭니다.
Future<
        gc_template_classes.NetworkResponseObject<
            DeleteService1TkV1AuthAllAuthorizationTokenAsyncResponseHeaderVo,
            DeleteService1TkV1AuthAllAuthorizationTokenAsyncResponseBodyVo>>
    deleteService1TkV1AuthAllAuthorizationTokenAsync(
        {required DeleteService1TkV1AuthAllAuthorizationTokenAsyncRequestHeaderVo
            requestHeaderVo}) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl = "/service1/tk/v1/auth/all-authorization-token";
  String prodServerUrl = "/service1/tk/v1/auth/all-authorization-token";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!!
  requestHeaders["Authorization"] = requestHeaderVo.authorization;

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.delete(requestUrlAndParam,
        options: Options(headers: requestHeaders), data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    DeleteService1TkV1AuthAllAuthorizationTokenAsyncResponseHeaderVo
        responseHeader;
    DeleteService1TkV1AuthAllAuthorizationTokenAsyncResponseBodyVo?
        responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader =
        DeleteService1TkV1AuthAllAuthorizationTokenAsyncResponseHeaderVo(
            apiResultCode: responseHeaderMap.containsKey("api-result-code")
                ? responseHeaderMap["api-result-code"][0]
                : null);
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class DeleteService1TkV1AuthAllAuthorizationTokenAsyncRequestHeaderVo {
  DeleteService1TkV1AuthAllAuthorizationTokenAsyncRequestHeaderVo(
      {required this.authorization});

  // 인증 토큰 (ex : "Bearer abcd1234!@#$")
  String authorization;
}

class DeleteService1TkV1AuthAllAuthorizationTokenAsyncResponseHeaderVo {
  DeleteService1TkV1AuthAllAuthorizationTokenAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  String? apiResultCode;
}

class DeleteService1TkV1AuthAllAuthorizationTokenAsyncResponseBodyVo {}

////
// (토큰 재발급 요청 <>)
// 엑세스 토큰 및 리플레시 토큰 재발행
Future<
        gc_template_classes.NetworkResponseObject<
            PostService1TkV1AuthReissueAsyncResponseHeaderVo,
            PostService1TkV1AuthReissueAsyncResponseBodyVo>>
    postService1TkV1AuthReissueAsync(
        {required PostService1TkV1AuthReissueAsyncRequestHeaderVo
            requestHeaderVo,
        required PostService1TkV1AuthReissueAsyncRequestBodyVo
            requestBodyVo}) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl = "/service1/tk/v1/auth/reissue";
  String prodServerUrl = "/service1/tk/v1/auth/reissue";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!!
  requestHeaders["Authorization"] = requestHeaderVo.authorization;
  requestBody["refreshToken"] = requestBodyVo.refreshToken;

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.post(requestUrlAndParam,
        options: Options(
          headers: requestHeaders,
        ),
        data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostService1TkV1AuthReissueAsyncResponseHeaderVo responseHeader;
    PostService1TkV1AuthReissueAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader = PostService1TkV1AuthReissueAsyncResponseHeaderVo(
        apiResultCode: (responseHeaderMap.containsKey("api-result-code"))
            ? responseHeaderMap["api-result-code"][0]
            : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      // responseBody 로 List 타입이 넘어오면 List<>.from 으로 받고,
      // Object 타입이 넘어오면 Map<String, dynamic> 으로 받고,
      // Object List 타입이 넘어오면 List<Map<String, dynamic>> 으로 받아서 처리

      var oAuth2List =
          List<Map<String, dynamic>>.from(responseBodyMap["myOAuth2List"]);
      List<PostReissueAsyncResponseBodyVoOAuth2Info> oAuth2ObjectList = [];
      for (Map<String, dynamic> oAuth2 in oAuth2List) {
        oAuth2ObjectList.add(PostReissueAsyncResponseBodyVoOAuth2Info(
            uid: oAuth2["uid"],
            oauth2TypeCode: oAuth2["oauth2TypeCode"],
            oauth2Id: oAuth2["oauth2Id"]));
      }

      var myProfileList =
          List<Map<String, dynamic>>.from(responseBodyMap["myProfileList"]);
      List<PostReissueAsyncResponseBodyVoProfile> myProfileObjectList = [];
      for (Map<String, dynamic> profile in myProfileList) {
        myProfileObjectList.add(PostReissueAsyncResponseBodyVoProfile(
            uid: profile["uid"],
            imageFullUrl: profile["imageFullUrl"],
            isFront: profile["isFront"]));
      }

      var myEmailList =
          List<Map<String, dynamic>>.from(responseBodyMap["myEmailList"]);
      List<PostReissueAsyncResponseBodyVoEmail> myEmailObjectList = [];
      for (Map<String, dynamic> profile in myEmailList) {
        myEmailObjectList.add(PostReissueAsyncResponseBodyVoEmail(
            uid: profile["uid"],
            emailAddress: profile["emailAddress"],
            isFront: profile["isFront"]));
      }

      var myPhoneNumberList =
          List<Map<String, dynamic>>.from(responseBodyMap["myPhoneNumberList"]);
      List<PostReissueAsyncResponseBodyVoPhone> myPhoneNumberObjectList = [];
      for (Map<String, dynamic> profile in myPhoneNumberList) {
        myPhoneNumberObjectList.add(PostReissueAsyncResponseBodyVoPhone(
            uid: profile["uid"],
            phoneNumber: profile["phoneNumber"],
            isFront: profile["isFront"]));
      }

      responseBody = PostService1TkV1AuthReissueAsyncResponseBodyVo(
          memberUid: responseBodyMap["memberUid"],
          nickName: responseBodyMap["nickName"],
          roleList: List<String>.from(responseBodyMap["roleList"]),
          tokenType: responseBodyMap["tokenType"],
          accessToken: responseBodyMap["accessToken"],
          refreshToken: responseBodyMap["refreshToken"],
          accessTokenExpireWhen: responseBodyMap["accessTokenExpireWhen"],
          refreshTokenExpireWhen: responseBodyMap["refreshTokenExpireWhen"],
          myOAuth2List: oAuth2ObjectList,
          myProfileList: myProfileObjectList,
          myEmailList: myEmailObjectList,
          myPhoneNumberList: myPhoneNumberObjectList,
          authPasswordIsNull: responseBodyMap["authPasswordIsNull"]);
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class PostService1TkV1AuthReissueAsyncRequestHeaderVo {
  PostService1TkV1AuthReissueAsyncRequestHeaderVo(
      {required this.authorization});

  // 인증 토큰 (ex : "Bearer abcd1234!@#$")
  String authorization;
}

class PostService1TkV1AuthReissueAsyncRequestBodyVo {
  PostService1TkV1AuthReissueAsyncRequestBodyVo({required this.refreshToken});

  String refreshToken; // 리플래시 토큰 (토큰 타입을 앞에 붙이기)
}

class PostService1TkV1AuthReissueAsyncResponseHeaderVo {
  PostService1TkV1AuthReissueAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  // 1 : 탈퇴된 회원
  // 2 : 유효하지 않은 리프레시 토큰
  // 3 : 리프레시 토큰 만료
  // 4 : 리프레시 토큰이 액세스 토큰과 매칭되지 않음
  String? apiResultCode;
}

class PostService1TkV1AuthReissueAsyncResponseBodyVo {
  PostService1TkV1AuthReissueAsyncResponseBodyVo(
      {required this.memberUid,
      required this.nickName,
      required this.roleList,
      required this.tokenType,
      required this.accessToken,
      required this.refreshToken,
      required this.accessTokenExpireWhen,
      required this.refreshTokenExpireWhen,
      required this.myOAuth2List,
      required this.myProfileList,
      required this.myEmailList,
      required this.myPhoneNumberList,
      required this.authPasswordIsNull});

  int memberUid; // 멤버 고유값
  String nickName; // 닉네임
  List<String> roleList; // 권한 리스트 (관리자 : ROLE_ADMIN, 개발자 : ROLE_DEVELOPER)
  String tokenType; // 인증 토큰 타입 (ex : Bearer)
  String accessToken; // 엑세스 토큰
  String refreshToken; // 리플레시 토큰
  String accessTokenExpireWhen; // 엑세스 토큰 만료 시간 (yyyy-MM-dd HH:mm:ss.SSS)
  String refreshTokenExpireWhen; // 리플레시 토큰 만료 시간 (yyyy-MM-dd HH:mm:ss.SSS)
  List<PostReissueAsyncResponseBodyVoOAuth2Info>
      myOAuth2List; // 내가 등록한 OAuth2 정보 리스트
  List<PostReissueAsyncResponseBodyVoProfile>
      myProfileList; // 내가 등록한 Profile 정보 리스트
  List<PostReissueAsyncResponseBodyVoEmail> myEmailList; // 내가 등록한 이메일 정보 리스트
  List<PostReissueAsyncResponseBodyVoPhone>
      myPhoneNumberList; // 내가 등록한 전화번호 정보 리스트
  bool
      authPasswordIsNull; // 계정 로그인 비밀번호 설정 Null 여부 (OAuth2 만으로 회원가입한 경우는 비밀번호가 없으므로 true)
}

class PostReissueAsyncResponseBodyVoOAuth2Info {
  PostReissueAsyncResponseBodyVoOAuth2Info(
      {required this.uid,
      required this.oauth2TypeCode,
      required this.oauth2Id});

  int uid; // 행 고유값
  int oauth2TypeCode; // OAuth2 (1 : Google, 2 : Naver, 3 : Kakao, 4 : Apple)
  String oauth2Id; // oAuth2 고유값 아이디
}

class PostReissueAsyncResponseBodyVoProfile {
  PostReissueAsyncResponseBodyVoProfile(
      {required this.uid, required this.imageFullUrl, required this.isFront});

  int uid; // 행 고유값
  String imageFullUrl; // 프로필 이미지 Full URL
  bool isFront; // 표 프로필 여부
}

class PostReissueAsyncResponseBodyVoEmail {
  PostReissueAsyncResponseBodyVoEmail(
      {required this.uid, required this.emailAddress, required this.isFront});

  int uid; // 행 고유값
  String emailAddress; // 이메일 주소
  bool isFront; // 대표 이메일 여부
}

class PostReissueAsyncResponseBodyVoPhone {
  PostReissueAsyncResponseBodyVoPhone(
      {required this.uid, required this.phoneNumber, required this.isFront});

  int uid; // 행 고유값
  String phoneNumber; // 전화번호
  bool isFront; // 대표 전화번호 여부
}

////
// (서버 접속 테스트)
Future<
        gc_template_classes.NetworkResponseObject<
            GetService1TkV1AuthForNoLoggedInAsyncResponseHeaderVo,
            GetService1TkV1AuthForNoLoggedInAsyncResponseBodyVo>>
    getService1TkV1AuthForNoLoggedInAsync() async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl = "/service1/tk/v1/auth/for-no-logged-in";
  String prodServerUrl = "/service1/tk/v1/auth/for-no-logged-in";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!!

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.get(requestUrlAndParam,
        options: Options(headers: requestHeaders));

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    GetService1TkV1AuthForNoLoggedInAsyncResponseHeaderVo responseHeader;
    GetService1TkV1AuthForNoLoggedInAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader = GetService1TkV1AuthForNoLoggedInAsyncResponseHeaderVo(
        apiResultCode: (responseHeaderMap.containsKey("api-result-code"))
            ? responseHeaderMap["api-result-code"][0]
            : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      // responseBody 로 List 타입이 넘어오면 List<>.from 으로 받고,
      // Object 타입이 넘어오면 Map<String, dynamic> 으로 받고,
      // Object List 타입이 넘어오면 List<Map<String, dynamic>> 으로 받아서 처리

      responseBody = GetService1TkV1AuthForNoLoggedInAsyncResponseBodyVo(
          result: responseBodyMap["result"]);
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class GetService1TkV1AuthForNoLoggedInAsyncResponseHeaderVo {
  GetService1TkV1AuthForNoLoggedInAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  String? apiResultCode;
}

class GetService1TkV1AuthForNoLoggedInAsyncResponseBodyVo {
  GetService1TkV1AuthForNoLoggedInAsyncResponseBodyVo({required this.result});

  String result;

  @override
  String toString() {
    return "result : $result";
  }
}

////
// (무권한 로그인 진입 테스트 <>)
// Authorization null 이라면 401 에러 반환
Future<
        gc_template_classes.NetworkResponseObject<
            GetService1TkV1AuthForLoggedInAsyncResponseHeaderVo,
            GetService1TkV1AuthForLoggedInAsyncResponseBodyVo>>
    getService1TkV1AuthForLoggedInAsync(
        {required GetService1TkV1AuthForLoggedInAsyncRequestHeaderVo
            requestHeaderVo}) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl = "/service1/tk/v1/auth/for-logged-in";
  String prodServerUrl = "/service1/tk/v1/auth/for-logged-in";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!!
  if (requestHeaderVo.authorization != null) {
    requestHeaders["Authorization"] = requestHeaderVo.authorization;
  }

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.get(requestUrlAndParam,
        options: Options(headers: requestHeaders));

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    GetService1TkV1AuthForLoggedInAsyncResponseHeaderVo responseHeader;
    GetService1TkV1AuthForLoggedInAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader = GetService1TkV1AuthForLoggedInAsyncResponseHeaderVo(
        apiResultCode: (responseHeaderMap.containsKey("api-result-code"))
            ? responseHeaderMap["api-result-code"][0]
            : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      // responseBody 로 List 타입이 넘어오면 List<>.from 으로 받고,
      // Object 타입이 넘어오면 Map<String, dynamic> 으로 받고,
      // Object List 타입이 넘어오면 List<Map<String, dynamic>> 으로 받아서 처리

      responseBody = GetService1TkV1AuthForLoggedInAsyncResponseBodyVo(
          result: responseBodyMap["result"]);
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class GetService1TkV1AuthForLoggedInAsyncRequestHeaderVo {
  GetService1TkV1AuthForLoggedInAsyncRequestHeaderVo(
      {required this.authorization});

  // 인증 토큰 (ex : "Bearer abcd1234!@#$")
  String? authorization;
}

class GetService1TkV1AuthForLoggedInAsyncResponseHeaderVo {
  GetService1TkV1AuthForLoggedInAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  String? apiResultCode;
}

class GetService1TkV1AuthForLoggedInAsyncResponseBodyVo {
  GetService1TkV1AuthForLoggedInAsyncResponseBodyVo({required this.result});

  String result;

  @override
  String toString() {
    return "result : $result";
  }
}

////
// (DEVELOPER 권한 진입 테스트 <'ADMIN' or 'DEVELOPER'>)
// Authorization null 이라면 401 에러 반환
Future<
        gc_template_classes.NetworkResponseObject<
            GetService1TkV1AuthForDeveloperAsyncResponseHeaderVo,
            GetService1TkV1AuthForDeveloperAsyncResponseBodyVo>>
    getService1TkV1AuthForDeveloperAsync(
        {required GetService1TkV1AuthForDeveloperAsyncRequestHeaderVo
            requestHeaderVo}) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl = "/service1/tk/v1/auth/for-developer";
  String prodServerUrl = "/service1/tk/v1/auth/for-developer";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!!
  if (requestHeaderVo.authorization != null) {
    requestHeaders["Authorization"] = requestHeaderVo.authorization;
  }

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.get(requestUrlAndParam,
        options: Options(headers: requestHeaders));

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    GetService1TkV1AuthForDeveloperAsyncResponseHeaderVo responseHeader;
    GetService1TkV1AuthForDeveloperAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader = GetService1TkV1AuthForDeveloperAsyncResponseHeaderVo(
        apiResultCode: (responseHeaderMap.containsKey("api-result-code"))
            ? responseHeaderMap["api-result-code"][0]
            : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      // responseBody 로 List 타입이 넘어오면 List<>.from 으로 받고,
      // Object 타입이 넘어오면 Map<String, dynamic> 으로 받고,
      // Object List 타입이 넘어오면 List<Map<String, dynamic>> 으로 받아서 처리

      responseBody = GetService1TkV1AuthForDeveloperAsyncResponseBodyVo(
          result: responseBodyMap["result"]);
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class GetService1TkV1AuthForDeveloperAsyncRequestHeaderVo {
  GetService1TkV1AuthForDeveloperAsyncRequestHeaderVo(
      {required this.authorization});

  // 인증 토큰 (ex : "Bearer abcd1234!@#$")
  String? authorization;
}

class GetService1TkV1AuthForDeveloperAsyncResponseHeaderVo {
  GetService1TkV1AuthForDeveloperAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  String? apiResultCode;
}

class GetService1TkV1AuthForDeveloperAsyncResponseBodyVo {
  GetService1TkV1AuthForDeveloperAsyncResponseBodyVo({required this.result});

  String result;

  @override
  String toString() {
    return "result : $result";
  }
}

////
// (ADMIN 권한 진입 테스트 <'ADMIN'>)
// Authorization null 이라면 401 에러 반환
Future<
        gc_template_classes.NetworkResponseObject<
            GetService1TkV1AuthForAdminAsyncResponseHeaderVo,
            GetService1TkV1AuthForAdminAsyncResponseBodyVo>>
    getService1TkV1AuthForAdminAsync(
        {required GetService1TkV1AuthForAdminAsyncRequestHeaderVo
            requestHeaderVo}) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl = "/service1/tk/v1/auth/for-admin";
  String prodServerUrl = "/service1/tk/v1/auth/for-admin";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!!
  if (requestHeaderVo.authorization != null) {
    requestHeaders["Authorization"] = requestHeaderVo.authorization;
  }

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.get(requestUrlAndParam,
        options: Options(headers: requestHeaders));

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    GetService1TkV1AuthForAdminAsyncResponseHeaderVo responseHeader;
    GetService1TkV1AuthForAdminAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader = GetService1TkV1AuthForAdminAsyncResponseHeaderVo(
        apiResultCode: (responseHeaderMap.containsKey("api-result-code"))
            ? responseHeaderMap["api-result-code"][0]
            : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      // responseBody 로 List 타입이 넘어오면 List<>.from 으로 받고,
      // Object 타입이 넘어오면 Map<String, dynamic> 으로 받고,
      // Object List 타입이 넘어오면 List<Map<String, dynamic>> 으로 받아서 처리

      responseBody = GetService1TkV1AuthForAdminAsyncResponseBodyVo(
          result: responseBodyMap["result"]);
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class GetService1TkV1AuthForAdminAsyncRequestHeaderVo {
  GetService1TkV1AuthForAdminAsyncRequestHeaderVo(
      {required this.authorization});

  // 인증 토큰 (ex : "Bearer abcd1234!@#$")
  String? authorization;
}

class GetService1TkV1AuthForAdminAsyncResponseHeaderVo {
  GetService1TkV1AuthForAdminAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  String? apiResultCode;
}

class GetService1TkV1AuthForAdminAsyncResponseBodyVo {
  GetService1TkV1AuthForAdminAsyncResponseBodyVo({required this.result});

  String result;

  @override
  String toString() {
    return "result : $result";
  }
}

////
// (닉네임 중복 검사)
Future<
        gc_template_classes.NetworkResponseObject<
            GetService1TkV1AuthNicknameDuplicateCheckAsyncResponseHeaderVo,
            GetService1TkV1AuthNicknameDuplicateCheckAsyncResponseBodyVo>>
    getService1TkV1AuthNicknameDuplicateCheckAsync(
        {required GetService1TkV1AuthNicknameDuplicateCheckAsyncRequestQueryVo
            requestQueryVo}) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl = "/service1/tk/v1/auth/nickname-duplicate-check";
  String prodServerUrl = "/service1/tk/v1/auth/nickname-duplicate-check";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!!
  requestQueryParams["nickName"] = requestQueryVo.nickName;

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.get(requestUrlAndParam,
        options: Options(headers: requestHeaders));

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    GetService1TkV1AuthNicknameDuplicateCheckAsyncResponseHeaderVo
        responseHeader;
    GetService1TkV1AuthNicknameDuplicateCheckAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader =
        GetService1TkV1AuthNicknameDuplicateCheckAsyncResponseHeaderVo(
            apiResultCode: (responseHeaderMap.containsKey("api-result-code"))
                ? responseHeaderMap["api-result-code"][0]
                : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      // responseBody 로 List 타입이 넘어오면 List<>.from 으로 받고,
      // Object 타입이 넘어오면 Map<String, dynamic> 으로 받고,
      // Object List 타입이 넘어오면 List<Map<String, dynamic>> 으로 받아서 처리

      responseBody =
          GetService1TkV1AuthNicknameDuplicateCheckAsyncResponseBodyVo(
              duplicated: responseBodyMap["duplicated"]);
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class GetService1TkV1AuthNicknameDuplicateCheckAsyncRequestQueryVo {
  GetService1TkV1AuthNicknameDuplicateCheckAsyncRequestQueryVo(
      {required this.nickName});

  String nickName;
}

class GetService1TkV1AuthNicknameDuplicateCheckAsyncResponseHeaderVo {
  GetService1TkV1AuthNicknameDuplicateCheckAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  String? apiResultCode;
}

class GetService1TkV1AuthNicknameDuplicateCheckAsyncResponseBodyVo {
  GetService1TkV1AuthNicknameDuplicateCheckAsyncResponseBodyVo(
      {required this.duplicated});

  bool duplicated;
}

////
// (이메일 회원가입 본인 검증 이메일 보내기)
Future<
        gc_template_classes.NetworkResponseObject<
            PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseHeaderVo,
            PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseBodyVo>>
    postService1TkV1AuthJoinTheMembershipEmailVerificationAsync(
        {required PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncRequestBodyVo
            requestBodyVo}) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl =
      "/service1/tk/v1/auth/join-the-membership-email-verification";
  String prodServerUrl =
      "/service1/tk/v1/auth/join-the-membership-email-verification";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!!
  requestBody["email"] = requestBodyVo.email;

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.post(requestUrlAndParam,
        options: Options(
            headers: requestHeaders,
            sendTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10)),
        data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseHeaderVo
        responseHeader;
    PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseBodyVo?
        responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader =
        PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseHeaderVo(
            apiResultCode: (responseHeaderMap.containsKey("api-result-code"))
                ? responseHeaderMap["api-result-code"][0]!
                : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      // responseBody 로 List 타입이 넘어오면 List<>.from 으로 받고,
      // Object 타입이 넘어오면 Map<String, dynamic> 으로 받고,
      // Object List 타입이 넘어오면 List<Map<String, dynamic>> 으로 받아서 처리

      responseBody =
          PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseBodyVo(
              verificationUid: responseBodyMap["verificationUid"],
              verificationExpireWhen:
                  responseBodyMap["verificationExpireWhen"]);
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncRequestBodyVo {
  PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncRequestBodyVo(
      {required this.email});

  String email; // 수신 이메일
}

class PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseHeaderVo {
  PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  // 1 : 기존 회원 존재
  String? apiResultCode;
}

class PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseBodyVo {
  PostService1TkV1AuthJoinTheMembershipEmailVerificationAsyncResponseBodyVo(
      {required this.verificationUid, required this.verificationExpireWhen});

  int verificationUid; // 검증 고유값
  String verificationExpireWhen; // 검증 만료 시간 (yyyy-MM-dd HH:mm:ss.SSS)
}

////
// (이메일 회원가입 본인 확인 이메일에서 받은 코드 검증하기)
Future<
        gc_template_classes.NetworkResponseObject<
            GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncResponseHeaderVo,
            GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncResponseBodyVo>>
    getService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsync(
        {required GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncRequestQueryVo
            requestQueryVo}) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl =
      "/service1/tk/v1/auth/join-the-membership-email-verification-check";
  String prodServerUrl =
      "/service1/tk/v1/auth/join-the-membership-email-verification-check";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!!
  requestQueryParams["verificationUid"] = requestQueryVo.verificationUid;
  requestQueryParams["email"] = requestQueryVo.email;
  requestQueryParams["verificationCode"] = requestQueryVo.verificationCode;

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.get(requestUrlAndParam,
        options: Options(headers: requestHeaders));

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncResponseHeaderVo
        responseHeader;
    GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncResponseBodyVo?
        responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader =
        GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncResponseHeaderVo(
            apiResultCode: (responseHeaderMap.containsKey("api-result-code"))
                ? responseHeaderMap["api-result-code"][0]!
                : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      // responseBody 로 List 타입이 넘어오면 List<>.from 으로 받고,
      // Object 타입이 넘어오면 Map<String, dynamic> 으로 받고,
      // Object List 타입이 넘어오면 List<Map<String, dynamic>> 으로 받아서 처리

      responseBody =
          GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncResponseBodyVo(
              expireWhen: responseBodyMap["expireWhen"]);
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncRequestQueryVo {
  GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncRequestQueryVo(
      {required this.verificationUid,
      required this.email,
      required this.verificationCode});

  int verificationUid; // 검증 고유값
  String email; // 확인 이메일
  String verificationCode; // 확인 이메일에 전송된 코드
}

class GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncResponseHeaderVo {
  GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  // 1 : 이메일 검증 요청을 보낸 적 없음
  // 2 : 이메일 검증 요청이 만료됨
  // 3 : verificationCode 가 일치하지 않음
  String? apiResultCode;
}

class GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncResponseBodyVo {
  GetService1TkV1AuthJoinTheMembershipEmailVerificationCheckAsyncResponseBodyVo(
      {required this.expireWhen});

  String expireWhen; // 인증 완료시 새로 늘어난 검증 만료 시간 (yyyy-MM-dd HH:mm:ss.SSS)
}

////
// (Email 회원가입)
Future<
        gc_template_classes.NetworkResponseObject<
            PostService1TkV1AuthJoinTheMembershipWithEmailAsyncResponseHeaderVo,
            PostService1TkV1AuthJoinTheMembershipWithEmailAsyncResponseBodyVo>>
    postService1TkV1AuthJoinTheMembershipWithEmailAsync(
        {required PostService1TkV1AuthJoinTheMembershipWithEmailAsyncRequestBodyVo
            requestBodyVo}) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl = "/service1/tk/v1/auth/join-the-membership-with-email";
  String prodServerUrl = "/service1/tk/v1/auth/join-the-membership-with-email";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestFormDataMap = {};

  // !!!Request Object 를 Map 으로 만들기!!!
  requestFormDataMap["verificationUid"] = requestBodyVo.verificationUid;
  requestFormDataMap["email"] = requestBodyVo.email;
  requestFormDataMap["password"] = requestBodyVo.password;
  requestFormDataMap["nickName"] = requestBodyVo.nickName;
  requestFormDataMap["verificationCode"] = requestBodyVo.verificationCode;
  if (requestBodyVo.profileImageFile != null) {
    requestFormDataMap["profileImageFile"] = requestBodyVo.profileImageFile;
  }

  FormData requestBody = FormData.fromMap(requestFormDataMap);

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.post(requestUrlAndParam,
        options: Options(
          headers: requestHeaders,
        ),
        data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostService1TkV1AuthJoinTheMembershipWithEmailAsyncResponseHeaderVo
        responseHeader;
    PostService1TkV1AuthJoinTheMembershipWithEmailAsyncResponseBodyVo?
        responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader =
        PostService1TkV1AuthJoinTheMembershipWithEmailAsyncResponseHeaderVo(
            apiResultCode: (responseHeaderMap.containsKey("api-result-code"))
                ? responseHeaderMap["api-result-code"][0]!
                : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      responseBody =
          PostService1TkV1AuthJoinTheMembershipWithEmailAsyncResponseBodyVo();
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class PostService1TkV1AuthJoinTheMembershipWithEmailAsyncRequestBodyVo {
  PostService1TkV1AuthJoinTheMembershipWithEmailAsyncRequestBodyVo(
      {required this.verificationUid,
      required this.email,
      required this.password,
      required this.nickName,
      required this.verificationCode,
      required this.profileImageFile});

  int verificationUid; // 검증 고유값
  String email; // 아이디 - 이메일
  String password; // 사용할 비밀번호
  String nickName; // 닉네임
  String verificationCode; // oauth2Id 검증에 사용한 코드
  MultipartFile? profileImageFile; // 프로필 사진 파일
}

class PostService1TkV1AuthJoinTheMembershipWithEmailAsyncResponseHeaderVo {
  PostService1TkV1AuthJoinTheMembershipWithEmailAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  // 1 : 이메일 검증 요청을 보낸 적 없음
  // 2 : 이메일 검증 요청이 만료됨
  // 3 : verificationCode 가 일치하지 않음
  // 4 : 이미 가입된 회원이 있습니다.
  // 5 : 이미 사용중인 닉네임
  String? apiResultCode;
}

class PostService1TkV1AuthJoinTheMembershipWithEmailAsyncResponseBodyVo {}

////
// (이메일 비밀번호 찾기 본인 검증 이메일 보내기)
Future<
        gc_template_classes.NetworkResponseObject<
            PostService1TkV1AuthFindPasswordEmailVerificationAsyncResponseHeaderVo,
            PostService1TkV1AuthFindPasswordEmailVerificationAsyncResponseBodyVo>>
    postService1TkV1AuthFindPasswordEmailVerificationAsync(
        {required PostService1TkV1AuthFindPasswordEmailVerificationAsyncRequestBodyVo
            requestBodyVo}) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl = "/service1/tk/v1/auth/find-password-email-verification";
  String prodServerUrl =
      "/service1/tk/v1/auth/find-password-email-verification";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!!
  requestBody["email"] = requestBodyVo.email;

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.post(requestUrlAndParam,
        options: Options(
            headers: requestHeaders,
            sendTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10)),
        data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostService1TkV1AuthFindPasswordEmailVerificationAsyncResponseHeaderVo
        responseHeader;
    PostService1TkV1AuthFindPasswordEmailVerificationAsyncResponseBodyVo?
        responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader =
        PostService1TkV1AuthFindPasswordEmailVerificationAsyncResponseHeaderVo(
            apiResultCode: (responseHeaderMap.containsKey("api-result-code"))
                ? responseHeaderMap["api-result-code"][0]!
                : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody =
          PostService1TkV1AuthFindPasswordEmailVerificationAsyncResponseBodyVo(
              verificationUid: responseBodyMap["verificationUid"],
              verificationExpireWhen:
                  responseBodyMap["verificationExpireWhen"]);
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class PostService1TkV1AuthFindPasswordEmailVerificationAsyncRequestBodyVo {
  PostService1TkV1AuthFindPasswordEmailVerificationAsyncRequestBodyVo(
      {required this.email});

  String email; // 수신 이메일
}

class PostService1TkV1AuthFindPasswordEmailVerificationAsyncResponseHeaderVo {
  PostService1TkV1AuthFindPasswordEmailVerificationAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  // 1 : 가입되지 않은 회원
  String? apiResultCode;
}

class PostService1TkV1AuthFindPasswordEmailVerificationAsyncResponseBodyVo {
  PostService1TkV1AuthFindPasswordEmailVerificationAsyncResponseBodyVo(
      {required this.verificationUid, required this.verificationExpireWhen});

  int verificationUid; // 검증 고유값
  String verificationExpireWhen; // 검증 만료 시간 (yyyy-MM-dd HH:mm:ss.SSS)
}

////
// (이메일 비밀번호 찾기 완료)
Future<
        gc_template_classes.NetworkResponseObject<
            PostService1TkV1AuthFindPasswordWithEmailAsyncResponseHeaderVo,
            PostService1TkV1AuthFindPasswordWithEmailAsyncResponseBodyVo>>
    postService1TkV1AuthFindPasswordWithEmailAsync(
        {required PostService1TkV1AuthFindPasswordWithEmailAsyncRequestBodyVo
            requestBodyVo}) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl = "/service1/tk/v1/auth/find-password-with-email";
  String prodServerUrl = "/service1/tk/v1/auth/find-password-with-email";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!!
  requestBody["email"] = requestBodyVo.email;
  requestBody["verificationUid"] = requestBodyVo.verificationUid;
  requestBody["verificationCode"] = requestBodyVo.verificationCode;

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.post(requestUrlAndParam,
        options: Options(
            headers: requestHeaders,
            sendTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10)),
        data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostService1TkV1AuthFindPasswordWithEmailAsyncResponseHeaderVo
        responseHeader;
    PostService1TkV1AuthFindPasswordWithEmailAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader =
        PostService1TkV1AuthFindPasswordWithEmailAsyncResponseHeaderVo(
            apiResultCode: (responseHeaderMap.containsKey("api-result-code"))
                ? responseHeaderMap["api-result-code"][0]!
                : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      // Map<String, dynamic> responseBodyMap = response.data;

      responseBody =
          PostService1TkV1AuthFindPasswordWithEmailAsyncResponseBodyVo();
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class PostService1TkV1AuthFindPasswordWithEmailAsyncRequestBodyVo {
  PostService1TkV1AuthFindPasswordWithEmailAsyncRequestBodyVo(
      {required this.email,
      required this.verificationUid,
      required this.verificationCode});

  String email; // 비밀번호를 찾을 계정 이메일
  int verificationUid; // 검증 고유값
  String verificationCode; // 이메일 검증에 사용한 코드
}

class PostService1TkV1AuthFindPasswordWithEmailAsyncResponseHeaderVo {
  PostService1TkV1AuthFindPasswordWithEmailAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  // 1 : 이메일 검증 요청을 보낸 적 없음
  // 2 : 이메일 검증 요청이 만료됨
  // 3 : verificationCode 가 일치하지 않음
  // 4 : 탈퇴한 회원입니다.
  String? apiResultCode;
}

class PostService1TkV1AuthFindPasswordWithEmailAsyncResponseBodyVo {
  PostService1TkV1AuthFindPasswordWithEmailAsyncResponseBodyVo();
}

////
// (회원탈퇴 요청 <>)
Future<
        gc_template_classes.NetworkResponseObject<
            DeleteService1TkV1AuthWithdrawalAsyncResponseHeaderVo,
            DeleteService1TkV1AuthWithdrawalAsyncResponseBodyVo>>
    deleteService1TkV1AuthWithdrawalAsync(
        {required DeleteService1TkV1AuthWithdrawalAsyncRequestHeaderVo
            requestHeaderVo}) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl = "/service1/tk/v1/auth/withdrawal";
  String prodServerUrl = "/service1/tk/v1/auth/withdrawal";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!!
  requestHeaders["Authorization"] = requestHeaderVo.authorization;

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.delete(requestUrlAndParam,
        options: Options(
            headers: requestHeaders,
            sendTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10)),
        data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    DeleteService1TkV1AuthWithdrawalAsyncResponseHeaderVo responseHeader;
    DeleteService1TkV1AuthWithdrawalAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader = DeleteService1TkV1AuthWithdrawalAsyncResponseHeaderVo(
        apiResultCode: (responseHeaderMap.containsKey("api-result-code"))
            ? responseHeaderMap["api-result-code"][0]!
            : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      // Map<String, dynamic> responseBodyMap = response.data;

      responseBody = DeleteService1TkV1AuthWithdrawalAsyncResponseBodyVo();
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class DeleteService1TkV1AuthWithdrawalAsyncRequestHeaderVo {
  DeleteService1TkV1AuthWithdrawalAsyncRequestHeaderVo(
      {required this.authorization});

  // 인증 토큰 (ex : "Bearer abcd1234!@#$")
  String authorization;
}

class DeleteService1TkV1AuthWithdrawalAsyncResponseHeaderVo {
  DeleteService1TkV1AuthWithdrawalAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  String? apiResultCode;
}

class DeleteService1TkV1AuthWithdrawalAsyncResponseBodyVo {
  DeleteService1TkV1AuthWithdrawalAsyncResponseBodyVo();
}

////
// (비밀번호 변경 요청 <>)
Future<
        gc_template_classes.NetworkResponseObject<
            PutService1TkV1AuthChangeAccountPasswordAsyncResponseHeaderVo,
            PutService1TkV1AuthChangeAccountPasswordAsyncResponseBodyVo>>
    putService1TkV1AuthChangeAccountPasswordAsync(
        {required PutService1TkV1AuthChangeAccountPasswordAsyncRequestHeaderVo
            requestHeaderVo,
        required PutService1TkV1AuthChangeAccountPasswordAsyncRequestBodyVo
            requestBodyVo}) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!!
  String devServerUrl = "/service1/tk/v1/auth/change-account-password";
  String prodServerUrl = "/service1/tk/v1/auth/change-account-password";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!!
  requestHeaders["Authorization"] = requestHeaderVo.authorization;
  requestBody["oldPassword"] = requestBodyVo.oldPassword;
  requestBody["newPassword"] = requestBodyVo.newPassword;

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
      queryParams: requestQueryParams,
      requestUrl: (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.put(requestUrlAndParam,
        options: Options(
            headers: requestHeaders,
            sendTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10)),
        data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PutService1TkV1AuthChangeAccountPasswordAsyncResponseHeaderVo
        responseHeader;
    PutService1TkV1AuthChangeAccountPasswordAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!!
    responseHeader =
        PutService1TkV1AuthChangeAccountPasswordAsyncResponseHeaderVo(
            apiResultCode: (responseHeaderMap.containsKey("api-result-code"))
                ? responseHeaderMap["api-result-code"][0]
                : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      // Map<String, dynamic> responseBodyMap = response.data;

      responseBody =
          PutService1TkV1AuthChangeAccountPasswordAsyncResponseBodyVo();
    }

    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: gc_template_classes.NetworkResponseObjectOk(
            responseStatusCode: statusCode,
            responseHeaders: responseHeader,
            responseBody: responseBody),
        dioException: null);
  } on DioException catch (e) {
    // 서버에 리퀘스트가 도달하지 못한 에러 + Dio 가 에러로 규정한 Status Code
    //  = 클라이언트 입장에선 그냥 네트워크 에러로 처리
    return gc_template_classes.NetworkResponseObject(
        networkResponseObjectOk: null, dioException: e);
  }
}

class PutService1TkV1AuthChangeAccountPasswordAsyncRequestHeaderVo {
  PutService1TkV1AuthChangeAccountPasswordAsyncRequestHeaderVo(
      {required this.authorization});

  // 인증 토큰 (ex : "Bearer abcd1234!@#$")
  String authorization;
}

class PutService1TkV1AuthChangeAccountPasswordAsyncRequestBodyVo {
  PutService1TkV1AuthChangeAccountPasswordAsyncRequestBodyVo(
      {required this.oldPassword, required this.newPassword});

  // 인증 토큰 (ex : "Bearer abcd1234!@#$")
  String? oldPassword; // 기존 이메일 로그인용 비밀번호(기존 비밀번호가 없다면 null)
  String? newPassword; // 새 이메일 로그인용 비밀번호(비밀번호를 없애려면 null)
}

class PutService1TkV1AuthChangeAccountPasswordAsyncResponseHeaderVo {
  PutService1TkV1AuthChangeAccountPasswordAsyncResponseHeaderVo(
      {required this.apiResultCode});

  // (api-result-code)
  // 0 : 정상 동작
  // 1 : 탈퇴된 회원
  // 2 : 기존 비밀번호가 일치하지 않음
  // 3 : 비번을 null 로 만들려고 할 때 account 외의 OAuth2 인증이 없기에 비번 제거 불가
  String? apiResultCode;
}

class PutService1TkV1AuthChangeAccountPasswordAsyncResponseBodyVo {
  PutService1TkV1AuthChangeAccountPasswordAsyncResponseBodyVo();
}
