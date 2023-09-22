// (external)
import 'package:dio/dio.dart';

// (all)
import 'package:flutter_project_template/repositories/network/network_repositories.dart'
    as network_repositories;
import '../../../global_data/gd_const_config.dart' as gd_const_config;
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;
import '../../../global_classes/gc_my_classes.dart' as gc_my_classes;

// [네트워크 API 파일]
// 하나의 Dio 에 대응하는 API 함수 모음 파일

//------------------------------------------------------------------------------
// (서버 Dio 객체)
// 본 파일은 하나의 서버에 대응하며, 사용할 서버 객체는 serverDioObject 에 할당하세요.
final serverDioObject = network_repositories.mainServerDio;

// -----------------------------------------------------------------------------
// !!!네트워크 요청 함수 작성!!

// (Get 요청 테스트 (Query Parameter))
Future<
    gc_my_classes.NetworkResponseObject<GetRequestTestAsyncResponseHeaderVo,
        GetRequestTestAsyncResponseBodyVo>> getRequestTestAsync(
    GetRequestTestAsyncRequestQueryVo requestQueryVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/request-test/get-request";
  String prodServerUrl = "/tk/request-test/get-request";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!
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

    GetRequestTestAsyncResponseHeaderVo responseHeader;
    GetRequestTestAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = GetRequestTestAsyncResponseHeaderVo();
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody = GetRequestTestAsyncResponseBodyVo(
        responseBodyMap["queryParamString"],
        responseBodyMap["queryParamStringNullable"],
        responseBodyMap["queryParamInt"],
        responseBodyMap["queryParamIntNullable"],
        responseBodyMap["queryParamDouble"],
        responseBodyMap["queryParamDoubleNullable"],
        responseBodyMap["queryParamBoolean"],
        responseBodyMap["queryParamBooleanNullable"],
        List<String>.from(responseBodyMap["queryParamStringList"]),
        (responseBodyMap["queryParamStringListNullable"] == null)
            ? null
            : List<String>.from(
                responseBodyMap["queryParamStringListNullable"]),
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

class GetRequestTestAsyncRequestQueryVo {
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

  GetRequestTestAsyncRequestQueryVo(
      this.queryParamString,
      this.queryParamStringNullable,
      this.queryParamInt,
      this.queryParamIntNullable,
      this.queryParamDouble,
      this.queryParamDoubleNullable,
      this.queryParamBoolean,
      this.queryParamBooleanNullable,
      this.queryParamStringList,
      this.queryParamStringListNullable);
}

class GetRequestTestAsyncResponseHeaderVo {
  GetRequestTestAsyncResponseHeaderVo();
}

class GetRequestTestAsyncResponseBodyVo {
  String queryParamString; // 입력한 String 쿼리 파라미터
  String? queryParamStringNullable; // 입력한 String 쿼리 파라미터 Nullable
  int queryParamInt; // 입력한 int 쿼리 파라미터
  int? queryParamIntNullable; // 입력한 int 쿼리 파라미터 Nullable
  double queryParamDouble; // 입력한 double 쿼리 파라미터
  double? queryParamDoubleNullable; // 입력한 double 쿼리 파라미터 Nullable
  bool queryParamBoolean; // 입력한 bool 쿼리 파라미터
  bool? queryParamBooleanNullable; // 입력한 bool 쿼리 파라미터 Nullable
  List<String> queryParamStringList; // 입력한 StringList 쿼리 파라미터
  List<String>?
  queryParamStringListNullable; // 입력한 StringList 쿼리 파라미터 Nullable

  GetRequestTestAsyncResponseBodyVo(
      this.queryParamString,
      this.queryParamStringNullable,
      this.queryParamInt,
      this.queryParamIntNullable,
      this.queryParamDouble,
      this.queryParamDoubleNullable,
      this.queryParamBoolean,
      this.queryParamBooleanNullable,
      this.queryParamStringList,
      this.queryParamStringListNullable);

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
        "queryParamStringListNullable : $queryParamStringListNullable, ";
  }
}

////
// (Post 요청 테스트 (Request Body))
Future<
    gc_my_classes.NetworkResponseObject<PostRequestTestAsyncResponseHeaderVo,
        PostRequestTestAsyncResponseBodyVo>> postRequestTestAsync(
    PostRequestTestAsyncRequestBodyVo requestBodyVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/test/request/post-request";
  String prodServerUrl = "/tk/ra/test/request/post-request";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!
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

    PostRequestTestAsyncResponseHeaderVo responseHeader;
    PostRequestTestAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = PostRequestTestAsyncResponseHeaderVo();
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody = PostRequestTestAsyncResponseBodyVo(
        responseBodyMap["responseBodyString"],
        responseBodyMap["responseBodyStringNullable"],
        responseBodyMap["responseBodyInt"],
        responseBodyMap["responseBodyIntNullable"],
        responseBodyMap["responseBodyDouble"],
        responseBodyMap["responseBodyDoubleNullable"],
        responseBodyMap["responseBodyBoolean"],
        responseBodyMap["responseBodyBooleanNullable"],
        List<String>.from(responseBodyMap["responseBodyStringList"]),
        (responseBodyMap["responseBodyStringListNullable"] == null)
            ? null
            : List<String>.from(
                responseBodyMap["responseBodyStringListNullable"]),
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

class PostRequestTestAsyncRequestBodyVo {
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

  PostRequestTestAsyncRequestBodyVo(
      this.requestBodyString,
      this.requestBodyStringNullable,
      this.requestBodyInt,
      this.requestBodyIntNullable,
      this.requestBodyDouble,
      this.requestBodyDoubleNullable,
      this.requestBodyBoolean,
      this.requestBodyBooleanNullable,
      this.requestBodyStringList,
      this.requestBodyStringListNullable);
}

class PostRequestTestAsyncResponseHeaderVo {
  PostRequestTestAsyncResponseHeaderVo();
}

class PostRequestTestAsyncResponseBodyVo {
  String responseBodyString; // 입력한 String 쿼리 파라미터
  String? responseBodyStringNullable; // 입력한 String 쿼리 파라미터 Nullable
  int responseBodyInt; // 입력한 int 쿼리 파라미터
  int? responseBodyIntNullable; // 입력한 int 쿼리 파라미터 Nullable
  double responseBodyDouble; // 입력한 double 쿼리 파라미터
  double? responseBodyDoubleNullable; // 입력한 double 쿼리 파라미터 Nullable
  bool responseBodyBoolean; // 입력한 bool 쿼리 파라미터
  bool? responseBodyBooleanNullable; // 입력한 bool 쿼리 파라미터 Nullable
  List<String> responseBodyStringList; // 입력한 StringList 쿼리 파라미터
  List<String>?
      responseBodyStringListNullable; // 입력한 StringList 쿼리 파라미터 Nullable

  PostRequestTestAsyncResponseBodyVo(
      this.responseBodyString,
      this.responseBodyStringNullable,
      this.responseBodyInt,
      this.responseBodyIntNullable,
      this.responseBodyDouble,
      this.responseBodyDoubleNullable,
      this.responseBodyBoolean,
      this.responseBodyBooleanNullable,
      this.responseBodyStringList,
      this.responseBodyStringListNullable);

  @override
  String toString() {
    return "responseBodyString : $responseBodyString, "
        "responseBodyStringNullable : $responseBodyStringNullable, "
        "responseBodyInt : $responseBodyInt, "
        "responseBodyIntNullable : $responseBodyIntNullable, "
        "responseBodyDouble : $responseBodyDouble, "
        "responseBodyDoubleNullable : $responseBodyDoubleNullable, "
        "responseBodyBoolean : $responseBodyBoolean, "
        "responseBodyBooleanNullable : $responseBodyBooleanNullable, "
        "responseBodyStringList : $responseBodyStringList, "
        "responseBodyStringListNullable : $responseBodyStringListNullable, ";
  }
}

////
// (Post 요청 테스트 (x-www-form-urlencoded))
Future<
    gc_my_classes.NetworkResponseObject<
        PostRequestTestXwfuAsyncResponseHeaderVo,
        PostRequestTestXwfuAsyncResponseBodyVo>> postRequestTestXwfuAsync(
    PostRequestTestXwfuAsyncRequestBodyVo requestBodyVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl =
      "/tk/ra/test/request/post-request-x-www-form-urlencoded";
  String prodServerUrl =
      "/tk/ra/test/request/post-request-x-www-form-urlencoded";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!
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
  String requestUrlAndParam = gf_my_functions.mergeNetworkQueryParam(
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

    PostRequestTestXwfuAsyncResponseHeaderVo responseHeader;
    PostRequestTestXwfuAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = PostRequestTestXwfuAsyncResponseHeaderVo();
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody = PostRequestTestXwfuAsyncResponseBodyVo(
        responseBodyMap["responseBodyString"],
        responseBodyMap["responseBodyStringNullable"],
        responseBodyMap["responseBodyInt"],
        responseBodyMap["responseBodyIntNullable"],
        responseBodyMap["responseBodyDouble"],
        responseBodyMap["responseBodyDoubleNullable"],
        responseBodyMap["responseBodyBoolean"],
        responseBodyMap["responseBodyBooleanNullable"],
        List<String>.from(responseBodyMap["responseBodyStringList"]),
        (responseBodyMap["responseBodyStringListNullable"] == null)
            ? null
            : List<String>.from(
                responseBodyMap["responseBodyStringListNullable"]),
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

class PostRequestTestXwfuAsyncRequestBodyVo {
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

  PostRequestTestXwfuAsyncRequestBodyVo(
      this.requestFormString,
      this.requestFormStringNullable,
      this.requestFormInt,
      this.requestFormIntNullable,
      this.requestFormDouble,
      this.requestFormDoubleNullable,
      this.requestFormBoolean,
      this.requestFormBooleanNullable,
      this.requestFormStringList,
      this.requestFormStringListNullable);
}

class PostRequestTestXwfuAsyncResponseHeaderVo {
  PostRequestTestXwfuAsyncResponseHeaderVo();
}

class PostRequestTestXwfuAsyncResponseBodyVo {
  String responseBodyString; // 입력한 String 쿼리 파라미터
  String? responseBodyStringNullable; // 입력한 String 쿼리 파라미터 Nullable
  int responseBodyInt; // 입력한 int 쿼리 파라미터
  int? responseBodyIntNullable; // 입력한 int 쿼리 파라미터 Nullable
  double responseBodyDouble; // 입력한 double 쿼리 파라미터
  double? responseBodyDoubleNullable; // 입력한 double 쿼리 파라미터 Nullable
  bool responseBodyBoolean; // 입력한 bool 쿼리 파라미터
  bool? responseBodyBooleanNullable; // 입력한 bool 쿼리 파라미터 Nullable
  List<String> responseBodyStringList; // 입력한 StringList 쿼리 파라미터
  List<String>?
      responseBodyStringListNullable; // 입력한 StringList 쿼리 파라미터 Nullable

  PostRequestTestXwfuAsyncResponseBodyVo(
      this.responseBodyString,
      this.responseBodyStringNullable,
      this.responseBodyInt,
      this.responseBodyIntNullable,
      this.responseBodyDouble,
      this.responseBodyDoubleNullable,
      this.responseBodyBoolean,
      this.responseBodyBooleanNullable,
      this.responseBodyStringList,
      this.responseBodyStringListNullable);

  @override
  String toString() {
    return "responseBodyString : $responseBodyString, "
        "responseBodyStringNullable : $responseBodyStringNullable, "
        "responseBodyInt : $responseBodyInt, "
        "responseBodyIntNullable : $responseBodyIntNullable, "
        "responseBodyDouble : $responseBodyDouble, "
        "responseBodyDoubleNullable : $responseBodyDoubleNullable, "
        "responseBodyBoolean : $responseBodyBoolean, "
        "responseBodyBooleanNullable : $responseBodyBooleanNullable, "
        "responseBodyStringList : $responseBodyStringList, "
        "responseBodyStringListNullable : $responseBodyStringListNullable, ";
  }
}

////
// (Post 요청 테스트 (multipart/form-data))
Future<
        gc_my_classes.NetworkResponseObject<
            PostRequestTestMultipartFormDataAsyncResponseHeaderVo,
            PostRequestTestMultipartFormDataAsyncResponseBodyVo>>
    postRequestTestMultipartFormDataAsync(
        PostRequestTestMultipartFormDataAsyncRequestBodyVo
            requestBodyVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/test/request/post-request-multipart-form-data";
  String prodServerUrl = "/tk/ra/test/request/post-request-multipart-form-data";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestFormDataMap = {};

  // !!!Request Object 를 Map 으로 만들기!!
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

    PostRequestTestMultipartFormDataAsyncResponseHeaderVo responseHeader;
    PostRequestTestMultipartFormDataAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = PostRequestTestMultipartFormDataAsyncResponseHeaderVo();
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody = PostRequestTestMultipartFormDataAsyncResponseBodyVo(
        responseBodyMap["responseBodyString"],
        responseBodyMap["responseBodyStringNullable"],
        responseBodyMap["responseBodyInt"],
        responseBodyMap["responseBodyIntNullable"],
        responseBodyMap["responseBodyDouble"],
        responseBodyMap["responseBodyDoubleNullable"],
        responseBodyMap["responseBodyBoolean"],
        responseBodyMap["responseBodyBooleanNullable"],
        List<String>.from(responseBodyMap["responseBodyStringList"]),
        (responseBodyMap["responseBodyStringListNullable"] == null)
            ? null
            : List<String>.from(
                responseBodyMap["responseBodyStringListNullable"]),
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

class PostRequestTestMultipartFormDataAsyncRequestBodyVo {
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

  PostRequestTestMultipartFormDataAsyncRequestBodyVo(
    this.requestFormString,
    this.requestFormStringNullable,
    this.requestFormInt,
    this.requestFormIntNullable,
    this.requestFormDouble,
    this.requestFormDoubleNullable,
    this.requestFormBoolean,
    this.requestFormBooleanNullable,
    this.requestFormStringList,
    this.requestFormStringListNullable,
    this.multipartFile,
    this.multipartFileNullable,
  );
}

class PostRequestTestMultipartFormDataAsyncResponseHeaderVo {
  PostRequestTestMultipartFormDataAsyncResponseHeaderVo();
}

class PostRequestTestMultipartFormDataAsyncResponseBodyVo {
  String responseBodyString; // 입력한 String 쿼리 파라미터
  String? responseBodyStringNullable; // 입력한 String 쿼리 파라미터 Nullable
  int responseBodyInt; // 입력한 int 쿼리 파라미터
  int? responseBodyIntNullable; // 입력한 int 쿼리 파라미터 Nullable
  double responseBodyDouble; // 입력한 double 쿼리 파라미터
  double? responseBodyDoubleNullable; // 입력한 double 쿼리 파라미터 Nullable
  bool responseBodyBoolean; // 입력한 bool 쿼리 파라미터
  bool? responseBodyBooleanNullable; // 입력한 bool 쿼리 파라미터 Nullable
  List<String> responseBodyStringList; // 입력한 StringList 쿼리 파라미터
  List<String>?
      responseBodyStringListNullable; // 입력한 StringList 쿼리 파라미터 Nullable

  PostRequestTestMultipartFormDataAsyncResponseBodyVo(
      this.responseBodyString,
      this.responseBodyStringNullable,
      this.responseBodyInt,
      this.responseBodyIntNullable,
      this.responseBodyDouble,
      this.responseBodyDoubleNullable,
      this.responseBodyBoolean,
      this.responseBodyBooleanNullable,
      this.responseBodyStringList,
      this.responseBodyStringListNullable);

  @override
  String toString() {
    return "responseBodyString : $responseBodyString, "
        "responseBodyStringNullable : $responseBodyStringNullable, "
        "responseBodyInt : $responseBodyInt, "
        "responseBodyIntNullable : $responseBodyIntNullable, "
        "responseBodyDouble : $responseBodyDouble, "
        "responseBodyDoubleNullable : $responseBodyDoubleNullable, "
        "responseBodyBoolean : $responseBodyBoolean, "
        "responseBodyBooleanNullable : $responseBodyBooleanNullable, "
        "responseBodyStringList : $responseBodyStringList, "
        "responseBodyStringListNullable : $responseBodyStringListNullable, ";
  }
}

////
// (Post 요청 테스트 (multipart/form-data - JsonString))
Future<
        gc_my_classes.NetworkResponseObject<
            PostRequestTestMultipartFormDataJsonStringAsyncResponseHeaderVo,
            PostRequestTestMultipartFormDataJsonStringAsyncResponseBodyVo>>
    postRequestTestMultipartFormDataJsonStringAsync(
        PostRequestTestMultipartFormDataJsonStringAsyncRequestBodyVo
            requestBodyVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl =
      "/tk/ra/test/request/post-request-multipart-form-data-json";
  String prodServerUrl =
      "/tk/ra/test/request/post-request-multipart-form-data-json";
  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  FormData requestBody;

  // !!!Request Object 를 Map 으로 만들기!!
  if (requestBodyVo.multipartFileNullable == null) {
    requestBody = FormData.fromMap({
      "jsonString": requestBodyVo.jsonString,
      "multipartFile": requestBodyVo.multipartFile,
    });
  } else {
    requestBody = FormData.fromMap({
      "jsonString": requestBodyVo.jsonString,
      "multipartFile": requestBodyVo.multipartFile,
      "multipartFileNullable": requestBodyVo.multipartFileNullable,
    });
  }

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

    PostRequestTestMultipartFormDataJsonStringAsyncResponseHeaderVo
        responseHeader;
    PostRequestTestMultipartFormDataJsonStringAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader =
        PostRequestTestMultipartFormDataJsonStringAsyncResponseHeaderVo();
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody =
          PostRequestTestMultipartFormDataJsonStringAsyncResponseBodyVo(
        responseBodyMap["responseBodyString"],
        responseBodyMap["responseBodyStringNullable"],
        responseBodyMap["responseBodyInt"],
        responseBodyMap["responseBodyIntNullable"],
        responseBodyMap["responseBodyDouble"],
        responseBodyMap["responseBodyDoubleNullable"],
        responseBodyMap["responseBodyBoolean"],
        responseBodyMap["responseBodyBooleanNullable"],
        List<String>.from(responseBodyMap["responseBodyStringList"]),
        (responseBodyMap["responseBodyStringListNullable"] == null)
            ? null
            : List<String>.from(
                responseBodyMap["responseBodyStringListNullable"]),
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

class PostRequestTestMultipartFormDataJsonStringAsyncRequestBodyVo {
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
  // "requestFormStringListNullable" : List<String>?, // StringList 바디 파라미터 Nullable
  // }
  String jsonString; // json 형식 String
  MultipartFile multipartFile; // 멀티 파트 파일
  MultipartFile? multipartFileNullable; // 멀티 파트 파일 Nullable

  PostRequestTestMultipartFormDataJsonStringAsyncRequestBodyVo(
    this.jsonString,
    this.multipartFile,
    this.multipartFileNullable,
  );
}

class PostRequestTestMultipartFormDataJsonStringAsyncResponseHeaderVo {
  PostRequestTestMultipartFormDataJsonStringAsyncResponseHeaderVo();
}

class PostRequestTestMultipartFormDataJsonStringAsyncResponseBodyVo {
  String responseBodyString; // 입력한 String 쿼리 파라미터
  String? responseBodyStringNullable; // 입력한 String 쿼리 파라미터 Nullable
  int responseBodyInt; // 입력한 int 쿼리 파라미터
  int? responseBodyIntNullable; // 입력한 int 쿼리 파라미터 Nullable
  double responseBodyDouble; // 입력한 double 쿼리 파라미터
  double? responseBodyDoubleNullable; // 입력한 double 쿼리 파라미터 Nullable
  bool responseBodyBoolean; // 입력한 bool 쿼리 파라미터
  bool? responseBodyBooleanNullable; // 입력한 bool 쿼리 파라미터 Nullable
  List<String> responseBodyStringList; // 입력한 StringList 쿼리 파라미터
  List<String>?
      responseBodyStringListNullable; // 입력한 StringList 쿼리 파라미터 Nullable

  PostRequestTestMultipartFormDataJsonStringAsyncResponseBodyVo(
      this.responseBodyString,
      this.responseBodyStringNullable,
      this.responseBodyInt,
      this.responseBodyIntNullable,
      this.responseBodyDouble,
      this.responseBodyDoubleNullable,
      this.responseBodyBoolean,
      this.responseBodyBooleanNullable,
      this.responseBodyStringList,
      this.responseBodyStringListNullable);

  @override
  String toString() {
    return "responseBodyString : $responseBodyString, "
        "responseBodyStringNullable : $responseBodyStringNullable, "
        "responseBodyInt : $responseBodyInt, "
        "responseBodyIntNullable : $responseBodyIntNullable, "
        "responseBodyDouble : $responseBodyDouble, "
        "responseBodyDoubleNullable : $responseBodyDoubleNullable, "
        "responseBodyBoolean : $responseBodyBoolean, "
        "responseBodyBooleanNullable : $responseBodyBooleanNullable, "
        "responseBodyStringList : $responseBodyStringList, "
        "responseBodyStringListNullable : $responseBodyStringListNullable, ";
  }
}

////
// (인위적 에러 수신 테스트)
// 서버에서 송신하는 인위적 에러 수신 테스트
Future<
        gc_my_classes.NetworkResponseObject<
            PostReceiveErrorTestAsyncResponseHeaderVo,
            PostReceiveErrorTestAsyncResponseBodyVo>>
    postReceiveErrorTestAsync() async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/test/request/generate-error";
  String prodServerUrl = "/tk/ra/test/request/generate-error";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!

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

    PostReceiveErrorTestAsyncResponseHeaderVo responseHeader;
    PostReceiveErrorTestAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = PostReceiveErrorTestAsyncResponseHeaderVo();
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

class PostReceiveErrorTestAsyncResponseHeaderVo {
  PostReceiveErrorTestAsyncResponseHeaderVo();
}

class PostReceiveErrorTestAsyncResponseBodyVo {}

////
// (text/string 반환 샘플)
// Response Body 가 text/string 타입입니다.
Future<
    gc_my_classes.NetworkResponseObject<
        GetRequestReturnTextStringAsyncResponseHeaderVo,
        String>> getRequestReturnTextStringAsync() async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/test/request/return-text-string";
  String prodServerUrl = "/tk/ra/test/request/return-text-string";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!

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

    GetRequestReturnTextStringAsyncResponseHeaderVo responseHeader;
    String? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = GetRequestReturnTextStringAsyncResponseHeaderVo();
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건

      responseBody = response.data;
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

class GetRequestReturnTextStringAsyncResponseHeaderVo {
  GetRequestReturnTextStringAsyncResponseHeaderVo();
}

class GetRequestReturnTextStringAsyncResponseBodyVo {
  GetRequestReturnTextStringAsyncResponseBodyVo();
}

////
// (text/html 반환 샘플)
// Response Body 가 text/html 타입입니다.
Future<
    gc_my_classes.NetworkResponseObject<
        GetRequestReturnTextHtmlAsyncResponseHeaderVo,
        String>> getRequestReturnTextHtmlAsync() async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/test/request/return-text-html";
  String prodServerUrl = "/tk/ra/test/request/return-text-html";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!

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

    GetRequestReturnTextHtmlAsyncResponseHeaderVo responseHeader;
    String? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = GetRequestReturnTextHtmlAsyncResponseHeaderVo();
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건

      responseBody = response.data;
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

class GetRequestReturnTextHtmlAsyncResponseHeaderVo {
  GetRequestReturnTextHtmlAsyncResponseHeaderVo();
}

class GetRequestReturnTextHtmlAsyncResponseBodyVo {
  GetRequestReturnTextHtmlAsyncResponseBodyVo();
}

////
// (서버에 저장된 어플리케이션 버전 정보 가져오기)
Future<
        gc_my_classes.NetworkResponseObject<
            GetMobileAppVersionInfoAsyncResponseHeaderVo,
            GetMobileAppVersionInfoAsyncResponseBodyVo>>
    getClientApplicationVersionInfoAsync(
        GetMobileAppVersionInfoAsyncRequestQueryVo requestQueryVo) async {
  // !!!서버 API 가 준비되면 더미 데이터 return 제거!!
  return gc_my_classes.NetworkResponseObject(
      gc_my_classes.NetworkResponseObjectOk(
          200,
          GetMobileAppVersionInfoAsyncResponseHeaderVo(),
          GetMobileAppVersionInfoAsyncResponseBodyVo("1.0.0", "1.0.0")),
      null);

  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/server-app-version-info";
  String prodServerUrl = "/server-app-version-info";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestQueryParams["platformCode"] = requestQueryVo.platformCode;

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

    GetMobileAppVersionInfoAsyncResponseHeaderVo responseHeader;
    GetMobileAppVersionInfoAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = GetMobileAppVersionInfoAsyncResponseHeaderVo();
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody = GetMobileAppVersionInfoAsyncResponseBodyVo(
          responseBodyMap["minUpgradeVersion"],
          responseBodyMap["latestVersion"]);
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

class GetMobileAppVersionInfoAsyncRequestQueryVo {
  // 플랫폼 코드 (1 : web, 2 : android, 3 : ios, 4 : windows, 5 : macos, 6 : linux)
  int platformCode;

  GetMobileAppVersionInfoAsyncRequestQueryVo(
    this.platformCode,
  );
}

class GetMobileAppVersionInfoAsyncResponseHeaderVo {
  GetMobileAppVersionInfoAsyncResponseHeaderVo();
}

class GetMobileAppVersionInfoAsyncResponseBodyVo {
  String minUpgradeVersion; // 최소 필요 버전, ex : "1.0.0"
  String latestVersion; // 최신 버전, ex : "1.0.0"

  GetMobileAppVersionInfoAsyncResponseBodyVo(
      this.minUpgradeVersion, this.latestVersion);
}

////
// (로그인 요청 with password)
// 서버 로그인 검증 요청 후 인증 정보 수신
Future<
    gc_my_classes.NetworkResponseObject<
        PostSignInWithPasswordAsyncResponseHeaderVo,
        PostSignInWithPasswordAsyncResponseBodyVo>> postSignInWithPasswordAsync(
    PostSignInWithPasswordAsyncRequestBodyVo requestBodyVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/auth/sign-in-with-password";
  String prodServerUrl = "/tk/ra/auth/sign-in-with-password";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestBody["signInTypeCode"] = requestBodyVo.signInTypeCode;
  requestBody["id"] = requestBodyVo.id;
  requestBody["password"] = requestBodyVo.password;

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
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostSignInWithPasswordAsyncResponseHeaderVo responseHeader;
    PostSignInWithPasswordAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = PostSignInWithPasswordAsyncResponseHeaderVo(
      (responseHeaderMap.containsKey("api-error-codes"))
          ? responseHeaderMap["api-error-codes"]!
          : null,
    );
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      var oAuth2List =
          List<Map<String, dynamic>>.from(responseBodyMap["myOAuth2List"]);
      List<PostSignInWithPasswordAsyncResponseBodyVoOAuth2Info>
          oAuth2ObjectList = [];
      for (Map<String, dynamic> oAuth2 in oAuth2List) {
        oAuth2ObjectList.add(
            PostSignInWithPasswordAsyncResponseBodyVoOAuth2Info(
                oAuth2["oauth2TypeCode"], oAuth2["oauth2Id"]));
      }

      responseBody = PostSignInWithPasswordAsyncResponseBodyVo(
          responseBodyMap["memberUid"],
          responseBodyMap["nickName"],
          List<int>.from(responseBodyMap["roleCodeList"]),
          responseBodyMap["tokenType"],
          responseBodyMap["accessToken"],
          responseBodyMap["refreshToken"],
          responseBodyMap["accessTokenExpireWhen"],
          responseBodyMap["refreshTokenExpireWhen"],
          List<String>.from(responseBodyMap["myEmailList"]),
          List<String>.from(responseBodyMap["myPhoneNumberList"]),
          oAuth2ObjectList);
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

class PostSignInWithPasswordAsyncRequestBodyVo {
  int signInTypeCode; // 로그인 타입 (0 : 닉네임, 1 : 이메일, 2 : 전화번호)
  String id; // 아이디 (0 : 홍길동, 1 : test@gmail.com, 2 : 82)000-0000-0000)
  String password; // 비밀번호

  PostSignInWithPasswordAsyncRequestBodyVo(
      this.signInTypeCode, this.id, this.password);
}

class PostSignInWithPasswordAsyncResponseHeaderVo {
  // (서버에서 내려주는 에러 코드)
  // null : 에러 없음,
  // 1 : 가입 되지 않은 회원
  // 2 : 로그인 정보 검증 불일치
  // 3 : 추가 로그인 금지됨(동시 로그인 제한시 추가 로그인을 금지한 상황일 때)
  List<String>? apiErrorCodes;

  PostSignInWithPasswordAsyncResponseHeaderVo(this.apiErrorCodes);
}

class PostSignInWithPasswordAsyncResponseBodyVo {
  String memberUid; // 멤버 고유값
  String nickName; // 닉네임
  List<int>
      roleCodeList; // 권한 코드 리스트 (1 : 관리자(ROLE_ADMIN), 2 : 개발자(ROLE_DEVELOPER))
  String tokenType; // 인증 토큰 타입 (ex : Bearer)
  String accessToken; // 엑세스 토큰
  String refreshToken; // 리플레시 토큰
  String accessTokenExpireWhen; // 엑세스 토큰 만료 시간 (yyyy-MM-dd HH:mm:ss.SSS)
  String refreshTokenExpireWhen; // 리플레시 토큰 만료 시간 (yyyy-MM-dd HH:mm:ss.SSS)
  List<String> myEmailList; // 내가 등록한 이메일 리스트
  List<String> myPhoneNumberList; // 내가 등록한 전화번호 리스트
  List<PostSignInWithPasswordAsyncResponseBodyVoOAuth2Info>
      myOAuth2List; // 내가 등록한 OAuth2 정보 리스트

  PostSignInWithPasswordAsyncResponseBodyVo(
      this.memberUid,
      this.nickName,
      this.roleCodeList,
      this.tokenType,
      this.accessToken,
      this.refreshToken,
      this.accessTokenExpireWhen,
      this.refreshTokenExpireWhen,
      this.myEmailList,
      this.myPhoneNumberList,
      this.myOAuth2List);
}

class PostSignInWithPasswordAsyncResponseBodyVoOAuth2Info {
  int oauth2TypeCode; // "OAuth2 (1 : Google, 2 : Apple, 3 : Naver, 4 : Kakao)
  String oauth2Id; // oAuth2 고유값 아이디

  PostSignInWithPasswordAsyncResponseBodyVoOAuth2Info(
      this.oauth2TypeCode, this.oauth2Id);
}

////
// (로그아웃 요청 <>)
// 서버 로그인 검증 요청 후 인증 정보 수신
Future<
    gc_my_classes.NetworkResponseObject<PostSignOutAsyncResponseHeaderVo,
        PostSignOutAsyncResponseBodyVo>> postSignOutAsync(
    PostSignOutAsyncRequestHeaderVo requestHeaderVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/auth/sign-out";
  String prodServerUrl = "/tk/ra/auth/sign-out";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestHeaders["Authorization"] = requestHeaderVo.authorization;

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

    PostSignOutAsyncResponseHeaderVo responseHeader;
    PostSignOutAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = PostSignOutAsyncResponseHeaderVo();
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

class PostSignOutAsyncRequestHeaderVo {
  // 인증 토큰 (ex : "Bearer abcd1234!@#$")
  String authorization;

  PostSignOutAsyncRequestHeaderVo(this.authorization);
}

class PostSignOutAsyncResponseHeaderVo {
  PostSignOutAsyncResponseHeaderVo();
}

class PostSignOutAsyncResponseBodyVo {}

////
// (토큰 재발급 요청 <>)
// 엑세스 토큰 및 리플레시 토큰 재발행
Future<
    gc_my_classes.NetworkResponseObject<PostReissueAsyncResponseHeaderVo,
        PostReissueAsyncResponseBodyVo>> postReissueAsync(
    PostReissueAsyncRequestHeaderVo requestHeaderVo,
    PostReissueAsyncRequestBodyVo requestBodyVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/auth/reissue";
  String prodServerUrl = "/tk/ra/auth/reissue";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestHeaders["Authorization"] = requestHeaderVo.authorization;
  requestBody["refreshToken"] = requestBodyVo.refreshToken;

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
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostReissueAsyncResponseHeaderVo responseHeader;
    PostReissueAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = PostReissueAsyncResponseHeaderVo(
      (responseHeaderMap.containsKey("api-error-codes"))
          ? responseHeaderMap["api-error-codes"]!
          : null,
    );
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      var oAuth2List =
          List<Map<String, dynamic>>.from(responseBodyMap["myOAuth2List"]);
      List<PostReissueAsyncResponseBodyVoOAuth2Info> oAuth2ObjectList = [];
      for (Map<String, dynamic> oAuth2 in oAuth2List) {
        oAuth2ObjectList.add(PostReissueAsyncResponseBodyVoOAuth2Info(
            oAuth2["oauth2TypeCode"], oAuth2["oauth2Id"]));
      }

      responseBody = PostReissueAsyncResponseBodyVo(
          responseBodyMap["memberUid"],
          responseBodyMap["nickName"],
          List<int>.from(responseBodyMap["roleCodeList"]),
          responseBodyMap["tokenType"],
          responseBodyMap["accessToken"],
          responseBodyMap["refreshToken"],
          responseBodyMap["accessTokenExpireWhen"],
          responseBodyMap["refreshTokenExpireWhen"],
          List<String>.from(responseBodyMap["myEmailList"]),
          List<String>.from(responseBodyMap["myPhoneNumberList"]),
          oAuth2ObjectList);
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

class PostReissueAsyncRequestHeaderVo {
  // 인증 토큰 (ex : "Bearer abcd1234!@#$")
  String authorization;

  PostReissueAsyncRequestHeaderVo(this.authorization);
}

class PostReissueAsyncRequestBodyVo {
  String refreshToken; // 리플래시 토큰 (토큰 타입을 앞에 붙이기)

  PostReissueAsyncRequestBodyVo(this.refreshToken);
}

class PostReissueAsyncResponseHeaderVo {
  // (서버에서 내려주는 에러 코드)
  // null : 에러 없음,
  // 1 : 유효하지 않은 리플래시 토큰
  // 2 : 리플래시 토큰 만료
  // 3 : 리플래시 토큰이 액세스 토큰과 매칭되지 않음
  // 4 : 추가 로그인 금지됨(동시 로그인 제한시 추가 로그인을 금지한 상황일 때)
  // 5 : 가입되지 않은 회원
  List<String>? apiErrorCodes;

  PostReissueAsyncResponseHeaderVo(
    this.apiErrorCodes,
  );
}

class PostReissueAsyncResponseBodyVo {
  String memberUid; // 멤버 고유값
  String nickName; // 닉네임
  List<int>
      roleCodeList; // 권한 코드 리스트 (1 : 관리자(ROLE_ADMIN), 2 : 유저(ROLE_USER), 3 : 개발자(ROLE_DEVELOPER))
  String tokenType; // 인증 토큰 타입 (ex : Bearer)
  String accessToken; // 엑세스 토큰
  String refreshToken; // 리플레시 토큰
  String accessTokenExpireWhen; // 엑세스 토큰 만료 시간 (yyyy-MM-dd HH:mm:ss.SSS)
  String refreshTokenExpireWhen; // 리플레시 토큰 만료 시간 (yyyy-MM-dd HH:mm:ss.SSS)
  List<String> myEmailList; // 내가 등록한 이메일 리스트
  List<String> myPhoneNumberList; // 내가 등록한 전화번호 리스트
  List<PostReissueAsyncResponseBodyVoOAuth2Info>
      myOAuth2List; // 내가 등록한 OAuth2 정보 리스트

  PostReissueAsyncResponseBodyVo(
      this.memberUid,
      this.nickName,
      this.roleCodeList,
      this.tokenType,
      this.accessToken,
      this.refreshToken,
      this.accessTokenExpireWhen,
      this.refreshTokenExpireWhen,
      this.myEmailList,
      this.myPhoneNumberList,
      this.myOAuth2List);
}

class PostReissueAsyncResponseBodyVoOAuth2Info {
  int oauth2TypeCode; // "OAuth2 (1 : Google, 2 : Apple, 3 : Naver, 4 : Kakao)
  String oauth2Id; // oAuth2 고유값 아이디

  PostReissueAsyncResponseBodyVoOAuth2Info(this.oauth2TypeCode, this.oauth2Id);
}

////
// (서버 접속 테스트)
Future<
    gc_my_classes.NetworkResponseObject<GetTestConnectAsyncResponseHeaderVo,
        GetTestConnectAsyncResponseBodyVo>> getTestConnectAsync() async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/test/connect";
  String prodServerUrl = "/tk/ra/test/connect";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!

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

    GetTestConnectAsyncResponseHeaderVo responseHeader;
    GetTestConnectAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = GetTestConnectAsyncResponseHeaderVo();
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody =
          GetTestConnectAsyncResponseBodyVo(responseBodyMap["result"]);
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

class GetTestConnectAsyncResponseHeaderVo {
  GetTestConnectAsyncResponseHeaderVo();
}

class GetTestConnectAsyncResponseBodyVo {
  String result;

  GetTestConnectAsyncResponseBodyVo(this.result);

  @override
  String toString() {
    return "result : $result, ";
  }
}

////
// (무권한 로그인 진입 테스트 <>)
// Authorization null 이라면 401 에러 반환
Future<
        gc_my_classes.NetworkResponseObject<
            GetTestConnectForSignedInAsyncResponseHeaderVo,
            GetTestConnectForSignedInAsyncResponseBodyVo>>
    getTestConnectForSignedInAsync(
        GetTestConnectForSignedInAsyncRequestHeaderVo requestHeaderVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/test/connect/for-signed-in";
  String prodServerUrl = "/tk/ra/test/connect/for-signed-in";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!
  if (requestHeaderVo.authorization != null) {
    requestHeaders["Authorization"] = requestHeaderVo.authorization;
  }

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

    GetTestConnectForSignedInAsyncResponseHeaderVo responseHeader;
    GetTestConnectForSignedInAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = GetTestConnectForSignedInAsyncResponseHeaderVo();
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody = GetTestConnectForSignedInAsyncResponseBodyVo(
          responseBodyMap["result"]);
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

class GetTestConnectForSignedInAsyncRequestHeaderVo {
  // 인증 토큰 (ex : "Bearer abcd1234!@#$")
  String? authorization;

  GetTestConnectForSignedInAsyncRequestHeaderVo(this.authorization);
}

class GetTestConnectForSignedInAsyncResponseHeaderVo {
  GetTestConnectForSignedInAsyncResponseHeaderVo();
}

class GetTestConnectForSignedInAsyncResponseBodyVo {
  String result;

  GetTestConnectForSignedInAsyncResponseBodyVo(this.result);
}

////
// (DEVELOPER 권한 진입 테스트 <'ADMIN' or 'DEVELOPER'>)
// Authorization null 이라면 401 에러 반환
Future<
        gc_my_classes.NetworkResponseObject<
            GetTestConnectForDeveloperAsyncResponseHeaderVo,
            GetTestConnectForDeveloperAsyncResponseBodyVo>>
    getTestConnectForDeveloperAsync(
        GetTestConnectForDeveloperAsyncRequestHeaderVo requestHeaderVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/test/connect/for-developer";
  String prodServerUrl = "/tk/ra/test/connect/for-developer";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!
  if (requestHeaderVo.authorization != null) {
    requestHeaders["Authorization"] = requestHeaderVo.authorization;
  }

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

    GetTestConnectForDeveloperAsyncResponseHeaderVo responseHeader;
    GetTestConnectForDeveloperAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = GetTestConnectForDeveloperAsyncResponseHeaderVo();
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody = GetTestConnectForDeveloperAsyncResponseBodyVo(
          responseBodyMap["result"]);
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

class GetTestConnectForDeveloperAsyncRequestHeaderVo {
  // 인증 토큰 (ex : "Bearer abcd1234!@#$")
  String? authorization;

  GetTestConnectForDeveloperAsyncRequestHeaderVo(this.authorization);
}

class GetTestConnectForDeveloperAsyncResponseHeaderVo {
  GetTestConnectForDeveloperAsyncResponseHeaderVo();
}

class GetTestConnectForDeveloperAsyncResponseBodyVo {
  String result;

  GetTestConnectForDeveloperAsyncResponseBodyVo(this.result);
}

////
// (ADMIN 권한 진입 테스트 <'ADMIN'>)
// Authorization null 이라면 401 에러 반환
Future<
    gc_my_classes.NetworkResponseObject<
        GetTestConnectForAdminAsyncResponseHeaderVo,
        GetTestConnectForAdminAsyncResponseBodyVo>> getTestConnectForAdminAsync(
    GetTestConnectForAdminAsyncRequestHeaderVo requestHeaderVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/test/connect/for-admin";
  String prodServerUrl = "/tk/ra/test/connect/for-admin";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!
  if (requestHeaderVo.authorization != null) {
    requestHeaders["Authorization"] = requestHeaderVo.authorization;
  }

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

    GetTestConnectForAdminAsyncResponseHeaderVo responseHeader;
    GetTestConnectForAdminAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = GetTestConnectForAdminAsyncResponseHeaderVo();
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody =
          GetTestConnectForAdminAsyncResponseBodyVo(responseBodyMap["result"]);
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

class GetTestConnectForAdminAsyncRequestHeaderVo {
  // 인증 토큰 (ex : "Bearer abcd1234!@#$")
  String? authorization;

  GetTestConnectForAdminAsyncRequestHeaderVo(this.authorization);
}

class GetTestConnectForAdminAsyncResponseHeaderVo {
  GetTestConnectForAdminAsyncResponseHeaderVo();
}

class GetTestConnectForAdminAsyncResponseBodyVo {
  String result;

  GetTestConnectForAdminAsyncResponseBodyVo(this.result);
}

////
// (닉네임 중복 검사)
Future<
        gc_my_classes.NetworkResponseObject<
            GetNicknameDuplicateCheckAsyncResponseHeaderVo,
            GetNicknameDuplicateCheckAsyncResponseBodyVo>>
    getNicknameDuplicateCheckAsync(
        GetNicknameDuplicateCheckAsyncRequestQueryVo requestQueryVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/auth/nickname-duplicate-check";
  String prodServerUrl = "/tk/ra/auth/nickname-duplicate-check";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestQueryParams["nickName"] = requestQueryVo.nickName;

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

    GetNicknameDuplicateCheckAsyncResponseHeaderVo responseHeader;
    GetNicknameDuplicateCheckAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = GetNicknameDuplicateCheckAsyncResponseHeaderVo();
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody = GetNicknameDuplicateCheckAsyncResponseBodyVo(
        responseBodyMap["duplicated"],
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

class GetNicknameDuplicateCheckAsyncRequestQueryVo {
  String nickName;

  GetNicknameDuplicateCheckAsyncRequestQueryVo(
    this.nickName,
  );
}

class GetNicknameDuplicateCheckAsyncResponseHeaderVo {
  GetNicknameDuplicateCheckAsyncResponseHeaderVo();
}

class GetNicknameDuplicateCheckAsyncResponseBodyVo {
  bool duplicated;

  GetNicknameDuplicateCheckAsyncResponseBodyVo(
    this.duplicated,
  );
}

////
// (이메일 회원가입 본인 검증 이메일 보내기)
Future<
        gc_my_classes.NetworkResponseObject<
            PostRegisterWithEmailVerificationAsyncResponseHeaderVo,
            PostRegisterWithEmailVerificationAsyncResponseBodyVo>>
    postRegisterWithEmailVerificationAsync(
        PostRegisterWithEmailVerificationAsyncRequestBodyVo
            requestBodyVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/auth/register-with-email-verification";
  String prodServerUrl = "/tk/ra/auth/register-with-email-verification";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestBody["email"] = requestBodyVo.email;

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
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
        data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostRegisterWithEmailVerificationAsyncResponseHeaderVo responseHeader;
    PostRegisterWithEmailVerificationAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = PostRegisterWithEmailVerificationAsyncResponseHeaderVo(
        (responseHeaderMap.containsKey("api-error-codes"))
            ? responseHeaderMap["api-error-codes"]!
            : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody = PostRegisterWithEmailVerificationAsyncResponseBodyVo(
        responseBodyMap["expireWhen"],
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

class PostRegisterWithEmailVerificationAsyncRequestBodyVo {
  String email; // 수신 이메일

  PostRegisterWithEmailVerificationAsyncRequestBodyVo(this.email);
}

class PostRegisterWithEmailVerificationAsyncResponseHeaderVo {
  // (서버에서 내려주는 에러 코드)
  // null : 에러 없음,
  // 1 : 기존 회원 존재
  List<String>? apiErrorCodes;

  PostRegisterWithEmailVerificationAsyncResponseHeaderVo(this.apiErrorCodes);
}

class PostRegisterWithEmailVerificationAsyncResponseBodyVo {
  String expireWhen; // 검증 만료 시간 (yyyy-MM-dd HH:mm:ss.SSS)

  PostRegisterWithEmailVerificationAsyncResponseBodyVo(
    this.expireWhen,
  );
}

////
// (이메일 회원가입 본인 확인 이메일에서 받은 코드 검증하기)
Future<
        gc_my_classes.NetworkResponseObject<
            GetRegisterWithEmailVerificationCheckAsyncResponseHeaderVo,
            GetRegisterWithEmailVerificationCheckAsyncResponseBodyVo>>
    getRegisterWithEmailVerificationCheckAsync(
        GetRegisterWithEmailVerificationCheckAsyncRequestQueryVo
            requestQueryVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/auth/register-with-email-verification-check";
  String prodServerUrl = "/tk/ra/auth/register-with-email-verification-check";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestQueryParams["email"] = requestQueryVo.email;
  requestQueryParams["verificationCode"] = requestQueryVo.verificationCode;

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
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    GetRegisterWithEmailVerificationCheckAsyncResponseHeaderVo responseHeader;
    GetRegisterWithEmailVerificationCheckAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = GetRegisterWithEmailVerificationCheckAsyncResponseHeaderVo(
        (responseHeaderMap.containsKey("api-error-codes"))
            ? responseHeaderMap["api-error-codes"]!
            : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody = GetRegisterWithEmailVerificationCheckAsyncResponseBodyVo(
        responseBodyMap["isVerified"],
        (responseBodyMap.containsKey("expireWhen"))
            ? responseBodyMap["expireWhen"]
            : null,
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

class GetRegisterWithEmailVerificationCheckAsyncRequestQueryVo {
  String email; // 확인 이메일
  String verificationCode; // 확인 이메일에 전송된 코드

  GetRegisterWithEmailVerificationCheckAsyncRequestQueryVo(
    this.email,
    this.verificationCode,
  );
}

class GetRegisterWithEmailVerificationCheckAsyncResponseHeaderVo {
  // (서버에서 내려주는 에러 코드)
  // null : 에러 없음,
  // 1 : 이메일 검증 요청을 보낸 적 없음 혹은 만료된 요청
  List<String>? apiErrorCodes;

  GetRegisterWithEmailVerificationCheckAsyncResponseHeaderVo(
      this.apiErrorCodes);
}

class GetRegisterWithEmailVerificationCheckAsyncResponseBodyVo {
  bool isVerified; // 본인 인증 코드 일치 여부
  String? expireWhen; // isVerified true 일때 새로 늘어난 검증 만료 시간

  GetRegisterWithEmailVerificationCheckAsyncResponseBodyVo(
    this.isVerified,
    this.expireWhen,
  );
}

////
// (Email 회원가입)
Future<
    gc_my_classes.NetworkResponseObject<
        PostRegisterWithEmailAsyncResponseHeaderVo,
        PostRegisterWithEmailAsyncResponseBodyVo>> postRegisterWithEmailAsync(
    PostRegisterWithEmailAsyncRequestBodyVo requestBodyVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/auth/register-with-email";
  String prodServerUrl = "/tk/ra/auth/register-with-email";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestBody["email"] = requestBodyVo.email;
  requestBody["password"] = requestBodyVo.password;
  requestBody["nickName"] = requestBodyVo.nickName;
  requestBody["verificationCode"] = requestBodyVo.verificationCode;

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
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostRegisterWithEmailAsyncResponseHeaderVo responseHeader;
    PostRegisterWithEmailAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = PostRegisterWithEmailAsyncResponseHeaderVo(
        (responseHeaderMap.containsKey("api-error-codes"))
            ? responseHeaderMap["api-error-codes"]!
            : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      responseBody = PostRegisterWithEmailAsyncResponseBodyVo();
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

class PostRegisterWithEmailAsyncRequestBodyVo {
  String email; // 아이디 - 이메일
  String password; // 사용할 비밀번호
  String nickName; // 닉네임
  String verificationCode; // oauth2Id 검증에 사용한 코드

  PostRegisterWithEmailAsyncRequestBodyVo(
    this.email,
    this.password,
    this.nickName,
    this.verificationCode,
  );
}

class PostRegisterWithEmailAsyncResponseHeaderVo {
  // (서버에서 내려주는 에러 코드)
  // null : 에러 없음,
  // 1 : 기존 회원 존재
  // 2 : 이메일 검증 요청을 보낸 적 없음 혹은 만료된 요청
  // 3 : 닉네임 중복
  // 4 : 입력한 verificationCode 와 검증된 code 가 일치하지 않거나 만료된 요청
  List<String>? apiErrorCodes;

  PostRegisterWithEmailAsyncResponseHeaderVo(this.apiErrorCodes);
}

class PostRegisterWithEmailAsyncResponseBodyVo {}

////
// (전화번호 회원가입 본인 검증 문자 보내기)
Future<
        gc_my_classes.NetworkResponseObject<
            PostRegisterWithPhoneNumberVerificationAsyncResponseHeaderVo,
            PostRegisterWithPhoneNumberVerificationAsyncResponseBodyVo>>
    postRegisterWithPhoneNumberVerificationAsync(
        PostRegisterWithPhoneNumberVerificationAsyncRequestBodyVo
            requestBodyVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/auth/register-with-phone-number-verification";
  String prodServerUrl = "/tk/ra/auth/register-with-phone-number-verification";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestBody["phoneNumber"] = requestBodyVo.phoneNumber;

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
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
        data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostRegisterWithPhoneNumberVerificationAsyncResponseHeaderVo responseHeader;
    PostRegisterWithPhoneNumberVerificationAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader =
        PostRegisterWithPhoneNumberVerificationAsyncResponseHeaderVo(
            (responseHeaderMap.containsKey("api-error-codes"))
                ? responseHeaderMap["api-error-codes"]!
                : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody = PostRegisterWithPhoneNumberVerificationAsyncResponseBodyVo(
        responseBodyMap["expireWhen"],
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

class PostRegisterWithPhoneNumberVerificationAsyncRequestBodyVo {
  String phoneNumber; // 수신 전화번호

  PostRegisterWithPhoneNumberVerificationAsyncRequestBodyVo(this.phoneNumber);
}

class PostRegisterWithPhoneNumberVerificationAsyncResponseHeaderVo {
  // (서버에서 내려주는 에러 코드)
  // null : 에러 없음,
  // 1 : 기존 회원 존재
  List<String>? apiErrorCodes;

  PostRegisterWithPhoneNumberVerificationAsyncResponseHeaderVo(
      this.apiErrorCodes);
}

class PostRegisterWithPhoneNumberVerificationAsyncResponseBodyVo {
  String expireWhen; // 검증 만료 시간 (yyyy-MM-dd HH:mm:ss.SSS)

  PostRegisterWithPhoneNumberVerificationAsyncResponseBodyVo(
    this.expireWhen,
  );
}

////
// (전화번호 회원가입 본인 확인 문자에서 받은 코드 검증하기)
Future<
        gc_my_classes.NetworkResponseObject<
            GetRegisterWithPhoneNumberVerificationCheckAsyncResponseHeaderVo,
            GetRegisterWithPhoneNumberVerificationCheckAsyncResponseBodyVo>>
    getRegisterWithPhoneNumberVerificationCheckAsync(
        GetRegisterWithPhoneNumberVerificationCheckAsyncRequestQueryVo
            requestQueryVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl =
      "/tk/ra/auth/register-with-phone-number-verification-check";
  String prodServerUrl =
      "/tk/ra/auth/register-with-phone-number-verification-check";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestQueryParams["phoneNumber"] = requestQueryVo.phoneNumber;
  requestQueryParams["verificationCode"] = requestQueryVo.verificationCode;

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
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    GetRegisterWithPhoneNumberVerificationCheckAsyncResponseHeaderVo
        responseHeader;
    GetRegisterWithPhoneNumberVerificationCheckAsyncResponseBodyVo?
        responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader =
        GetRegisterWithPhoneNumberVerificationCheckAsyncResponseHeaderVo(
            (responseHeaderMap.containsKey("api-error-codes"))
                ? responseHeaderMap["api-error-codes"]!
                : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody =
          GetRegisterWithPhoneNumberVerificationCheckAsyncResponseBodyVo(
        responseBodyMap["isVerified"],
        (responseBodyMap.containsKey("expireWhen"))
            ? responseBodyMap["expireWhen"]
            : null,
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

class GetRegisterWithPhoneNumberVerificationCheckAsyncRequestQueryVo {
  String phoneNumber; // 확인 전화번호
  String verificationCode; // 확인 문자에 전송된 코드

  GetRegisterWithPhoneNumberVerificationCheckAsyncRequestQueryVo(
    this.phoneNumber,
    this.verificationCode,
  );
}

class GetRegisterWithPhoneNumberVerificationCheckAsyncResponseHeaderVo {
  // (서버에서 내려주는 에러 코드)
  // null : 에러 없음,
  // 1 : 이메일 검증 요청을 보낸 적 없음 혹은 만료된 요청
  List<String>? apiErrorCodes;

  GetRegisterWithPhoneNumberVerificationCheckAsyncResponseHeaderVo(
      this.apiErrorCodes);
}

class GetRegisterWithPhoneNumberVerificationCheckAsyncResponseBodyVo {
  bool isVerified; // 본인 인증 코드 일치 여부
  String? expireWhen; // isVerified true 일때 새로 늘어난 검증 만료 시간

  GetRegisterWithPhoneNumberVerificationCheckAsyncResponseBodyVo(
    this.isVerified,
    this.expireWhen,
  );
}

////
// (전화번호 회원가입)
Future<
        gc_my_classes.NetworkResponseObject<
            PostRegisterWithPhoneNumberAsyncResponseHeaderVo,
            PostRegisterWithPhoneNumberAsyncResponseBodyVo>>
    postRegisterWithPhoneNumberAsync(
        PostRegisterWithPhoneNumberAsyncRequestBodyVo requestBodyVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/auth/register-with-phone-number";
  String prodServerUrl = "/tk/ra/auth/register-with-phone-number";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestBody["phoneNumber"] = requestBodyVo.phoneNumber;
  requestBody["password"] = requestBodyVo.password;
  requestBody["nickName"] = requestBodyVo.nickName;
  requestBody["verificationCode"] = requestBodyVo.verificationCode;

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
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostRegisterWithPhoneNumberAsyncResponseHeaderVo responseHeader;
    PostRegisterWithPhoneNumberAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = PostRegisterWithPhoneNumberAsyncResponseHeaderVo(
        (responseHeaderMap.containsKey("api-error-codes"))
            ? responseHeaderMap["api-error-codes"]!
            : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      responseBody = PostRegisterWithPhoneNumberAsyncResponseBodyVo();
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

class PostRegisterWithPhoneNumberAsyncRequestBodyVo {
  String phoneNumber; // 아이디 - 전화번호
  String password; // 사용할 비밀번호
  String nickName; // 닉네임
  String verificationCode; // 검증에 사용한 코드

  PostRegisterWithPhoneNumberAsyncRequestBodyVo(
    this.phoneNumber,
    this.password,
    this.nickName,
    this.verificationCode,
  );
}

class PostRegisterWithPhoneNumberAsyncResponseHeaderVo {
  // (서버에서 내려주는 에러 코드)
  // null : 에러 없음,
  // 1 : 기존 회원 존재
  // 2 : 전화번호 검증 요청을 보낸 적 없음 혹은 만료된 요청
  // 3 : 닉네임 중복
  // 4 : 입력한 verificationCode 와 검증된 code 가 일치하지 않거나 만료된 요청
  List<String>? apiErrorCodes;

  PostRegisterWithPhoneNumberAsyncResponseHeaderVo(this.apiErrorCodes);
}

class PostRegisterWithPhoneNumberAsyncResponseBodyVo {}

////
// (이메일 비밀번호 찾기 본인 검증 이메일 보내기)
Future<
        gc_my_classes.NetworkResponseObject<
            PostFindPasswordWithEmailVerificationAsyncResponseHeaderVo,
            PostFindPasswordWithEmailVerificationAsyncResponseBodyVo>>
    postFindPasswordWithEmailVerificationAsync(
        PostFindPasswordWithEmailVerificationAsyncRequestBodyVo
            requestBodyVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/auth/find-password-with-email-verification";
  String prodServerUrl = "/tk/ra/auth/find-password-with-email-verification";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestBody["email"] = requestBodyVo.email;

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
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
        data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostFindPasswordWithEmailVerificationAsyncResponseHeaderVo responseHeader;
    PostFindPasswordWithEmailVerificationAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = PostFindPasswordWithEmailVerificationAsyncResponseHeaderVo(
        (responseHeaderMap.containsKey("api-error-codes"))
            ? responseHeaderMap["api-error-codes"]!
            : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody = PostFindPasswordWithEmailVerificationAsyncResponseBodyVo(
        responseBodyMap["expireWhen"],
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

class PostFindPasswordWithEmailVerificationAsyncRequestBodyVo {
  String email; // 수신 이메일

  PostFindPasswordWithEmailVerificationAsyncRequestBodyVo(this.email);
}

class PostFindPasswordWithEmailVerificationAsyncResponseHeaderVo {
  // (서버에서 내려주는 에러 코드)
  // null : 에러 없음,
  // 1 : 기존 회원 존재
  List<String>? apiErrorCodes;

  PostFindPasswordWithEmailVerificationAsyncResponseHeaderVo(
      this.apiErrorCodes);
}

class PostFindPasswordWithEmailVerificationAsyncResponseBodyVo {
  String expireWhen; // 검증 만료 시간 (yyyy-MM-dd HH:mm:ss.SSS)

  PostFindPasswordWithEmailVerificationAsyncResponseBodyVo(
    this.expireWhen,
  );
}

////
// (전화번호 비밀번호 찾기 본인 검증 문자 보내기)
Future<
        gc_my_classes.NetworkResponseObject<
            PostFindPasswordWithPhoneNumberVerificationAsyncResponseHeaderVo,
            PostFindPasswordWithPhoneNumberVerificationAsyncResponseBodyVo>>
    postFindPasswordWithPhoneNumberVerificationAsync(
        PostFindPasswordWithPhoneNumberVerificationAsyncRequestBodyVo
            requestBodyVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl =
      "/tk/ra/auth/find-password-with-phone-number-verification";
  String prodServerUrl =
      "/tk/ra/auth/find-password-with-phone-number-verification";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestBody["phoneNumber"] = requestBodyVo.phoneNumber;

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
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
        data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostFindPasswordWithPhoneNumberVerificationAsyncResponseHeaderVo
        responseHeader;
    PostFindPasswordWithPhoneNumberVerificationAsyncResponseBodyVo?
        responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader =
        PostFindPasswordWithPhoneNumberVerificationAsyncResponseHeaderVo(
            (responseHeaderMap.containsKey("api-error-codes"))
                ? responseHeaderMap["api-error-codes"]!
                : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody =
          PostFindPasswordWithPhoneNumberVerificationAsyncResponseBodyVo(
        responseBodyMap["expireWhen"],
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

class PostFindPasswordWithPhoneNumberVerificationAsyncRequestBodyVo {
  String phoneNumber; // 수신 전화번호

  PostFindPasswordWithPhoneNumberVerificationAsyncRequestBodyVo(
      this.phoneNumber);
}

class PostFindPasswordWithPhoneNumberVerificationAsyncResponseHeaderVo {
  // (서버에서 내려주는 에러 코드)
  // null : 에러 없음,
  // 1 : 기존 회원 존재
  List<String>? apiErrorCodes;

  PostFindPasswordWithPhoneNumberVerificationAsyncResponseHeaderVo(
      this.apiErrorCodes);
}

class PostFindPasswordWithPhoneNumberVerificationAsyncResponseBodyVo {
  String expireWhen; // 검증 만료 시간 (yyyy-MM-dd HH:mm:ss.SSS)

  PostFindPasswordWithPhoneNumberVerificationAsyncResponseBodyVo(
    this.expireWhen,
  );
}

////
// (이메일 비밀번호 찾기 완료)
Future<
        gc_my_classes.NetworkResponseObject<
            PostFindPasswordWithEmailAsyncResponseHeaderVo,
            PostFindPasswordWithEmailAsyncResponseBodyVo>>
    postFindPasswordWithEmailAsync(
        PostFindPasswordWithEmailAsyncRequestBodyVo requestBodyVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/auth/find-password-with-email";
  String prodServerUrl = "/tk/ra/auth/find-password-with-email";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestBody["email"] = requestBodyVo.email;
  requestBody["verificationCode"] = requestBodyVo.verificationCode;

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
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
        data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostFindPasswordWithEmailAsyncResponseHeaderVo responseHeader;
    PostFindPasswordWithEmailAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = PostFindPasswordWithEmailAsyncResponseHeaderVo(
        (responseHeaderMap.containsKey("api-error-codes"))
            ? responseHeaderMap["api-error-codes"]!
            : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      // Map<String, dynamic> responseBodyMap = response.data;

      responseBody = PostFindPasswordWithEmailAsyncResponseBodyVo();
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

class PostFindPasswordWithEmailAsyncRequestBodyVo {
  String email; // 수신 이메일
  String verificationCode; // 검증 코드

  PostFindPasswordWithEmailAsyncRequestBodyVo(
      this.email, this.verificationCode);
}

class PostFindPasswordWithEmailAsyncResponseHeaderVo {
  // (서버에서 내려주는 에러 코드)
  // null : 에러 없음,
  // 1 : 탈퇴된 회원
  // 2 : 이메일 검증 요청을 보낸 적 없음 혹은 만료된 요청
  // 3 : 검증 코드가 일치하지 않음
  List<String>? apiErrorCodes;

  PostFindPasswordWithEmailAsyncResponseHeaderVo(this.apiErrorCodes);
}

class PostFindPasswordWithEmailAsyncResponseBodyVo {
  PostFindPasswordWithEmailAsyncResponseBodyVo();
}

////
// (전화번호 비밀번호 찾기 완료)
Future<
        gc_my_classes.NetworkResponseObject<
            PostFindPasswordWithPhoneNumberAsyncResponseHeaderVo,
            PostFindPasswordWithPhoneNumberAsyncResponseBodyVo>>
    postFindPasswordWithPhoneNumberAsync(
        PostFindPasswordWithPhoneNumberAsyncRequestBodyVo requestBodyVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/auth/find-password-with-phone-number";
  String prodServerUrl = "/tk/ra/auth/find-password-with-phone-number";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestBody["phoneNumber"] = requestBodyVo.phoneNumber;
  requestBody["verificationCode"] = requestBodyVo.verificationCode;

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
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
        data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostFindPasswordWithPhoneNumberAsyncResponseHeaderVo responseHeader;
    PostFindPasswordWithPhoneNumberAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = PostFindPasswordWithPhoneNumberAsyncResponseHeaderVo(
        (responseHeaderMap.containsKey("api-error-codes"))
            ? responseHeaderMap["api-error-codes"]!
            : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      // Map<String, dynamic> responseBodyMap = response.data;

      responseBody = PostFindPasswordWithPhoneNumberAsyncResponseBodyVo();
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

class PostFindPasswordWithPhoneNumberAsyncRequestBodyVo {
  String phoneNumber; // 수신 전화번호
  String verificationCode; // 검증 코드

  PostFindPasswordWithPhoneNumberAsyncRequestBodyVo(
      this.phoneNumber, this.verificationCode);
}

class PostFindPasswordWithPhoneNumberAsyncResponseHeaderVo {
  // (서버에서 내려주는 에러 코드)
  // null : 에러 없음,
  // 1 : 탈퇴된 회원
  // 2 : 검증 요청을 보낸 적 없음 혹은 만료된 요청
  // 3 : 검증 코드가 일치하지 않음
  List<String>? apiErrorCodes;

  PostFindPasswordWithPhoneNumberAsyncResponseHeaderVo(this.apiErrorCodes);
}

class PostFindPasswordWithPhoneNumberAsyncResponseBodyVo {
  PostFindPasswordWithPhoneNumberAsyncResponseBodyVo();
}

////
// (회원탈퇴 요청 <>)
Future<
    gc_my_classes.NetworkResponseObject<PostWithdrawalAsyncResponseHeaderVo,
        PostWithdrawalAsyncResponseBodyVo>> postWithdrawalAsync(
  PostWithdrawalAsyncRequestHeaderVo requestHeaderVo,
) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/auth/withdrawal";
  String prodServerUrl = "/tk/ra/auth/withdrawal";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestHeaders["Authorization"] = requestHeaderVo.authorization;

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
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
        data: requestBody);

    int statusCode = response.statusCode!;
    // Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostWithdrawalAsyncResponseHeaderVo responseHeader;
    PostWithdrawalAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = PostWithdrawalAsyncResponseHeaderVo();
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      // Map<String, dynamic> responseBodyMap = response.data;

      responseBody = PostWithdrawalAsyncResponseBodyVo();
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

class PostWithdrawalAsyncRequestHeaderVo {
  // 인증 토큰 (ex : "Bearer abcd1234!@#$")
  String authorization;

  PostWithdrawalAsyncRequestHeaderVo(this.authorization);
}

class PostWithdrawalAsyncResponseHeaderVo {
  PostWithdrawalAsyncResponseHeaderVo();
}

class PostWithdrawalAsyncResponseBodyVo {
  PostWithdrawalAsyncResponseBodyVo();
}

////
// (비밀번호 변경 요청 <>)
Future<
        gc_my_classes.NetworkResponseObject<
            PutChangeAccountPasswordAsyncResponseHeaderVo,
            PutChangeAccountPasswordAsyncResponseBodyVo>>
    putChangeAccountPasswordAsync(
        PutChangeAccountPasswordAsyncRequestHeaderVo requestHeaderVo,
        PutChangeAccountPasswordAsyncRequestBodyVo requestBodyVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/auth/change-account-password";
  String prodServerUrl = "/tk/ra/auth/change-account-password";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestHeaders["Authorization"] = requestHeaderVo.authorization;
  requestBody["oldPassword"] = requestBodyVo.oldPassword;
  requestBody["newPassword"] = requestBodyVo.newPassword;

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_my_functions.mergeNetworkQueryParam(
      requestQueryParams,
      (gd_const_config.isDebugMode) ? devServerUrl : prodServerUrl);

  try {
    // !!!네트워크 요청 설정!!
    // requestPathAndParam, headers 설정 외 세부 설정
    var response = await serverDioObject.put(requestUrlAndParam,
        options: Options(
          headers: requestHeaders,
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
        data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PutChangeAccountPasswordAsyncResponseHeaderVo responseHeader;
    PutChangeAccountPasswordAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = PutChangeAccountPasswordAsyncResponseHeaderVo(
        (responseHeaderMap.containsKey("api-error-codes"))
            ? responseHeaderMap["api-error-codes"]!
            : null);
    if (statusCode == 200) {
      // responseBody 가 반환되는 조건
      // Map<String, dynamic> responseBodyMap = response.data;

      responseBody = PutChangeAccountPasswordAsyncResponseBodyVo();
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

class PutChangeAccountPasswordAsyncRequestHeaderVo {
  // 인증 토큰 (ex : "Bearer abcd1234!@#$")
  String authorization;

  PutChangeAccountPasswordAsyncRequestHeaderVo(this.authorization);
}

class PutChangeAccountPasswordAsyncRequestBodyVo {
  // 인증 토큰 (ex : "Bearer abcd1234!@#$")
  String? oldPassword; // 기존 이메일 로그인용 비밀번호(기존 비밀번호가 없다면 null)
  String? newPassword; // 새 이메일 로그인용 비밀번호(비밀번호를 없애려면 null)

  PutChangeAccountPasswordAsyncRequestBodyVo(
      this.oldPassword, this.newPassword);
}

class PutChangeAccountPasswordAsyncResponseHeaderVo {
  // (서버에서 내려주는 에러 코드)
  // null : 에러 없음,
  // 1 : 탈퇴된 회원
  // 2 : 기존 비밀번호가 일치하지 않음
  // 3 : 비번을 null 로 만들려고 할 때 account 외의 OAuth2 인증이 없기에 비번 제거 불가
  List<String>? apiErrorCodes;

  PutChangeAccountPasswordAsyncResponseHeaderVo(this.apiErrorCodes);
}

class PutChangeAccountPasswordAsyncResponseBodyVo {
  PutChangeAccountPasswordAsyncResponseBodyVo();
}
