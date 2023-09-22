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
// !!!본 파일은 하나의 서버에 대응하며, 사용할 서버 객체는 serverDioObject 에 할당하세요.!!
final serverDioObject = network_repositories.mainServerDio;

// -----------------------------------------------------------------------------
// !!!네트워크 요청 함수 작성!!

// (Get 요청 샘플 (Query Parameter))
Future<
    gc_my_classes.NetworkResponseObject<GetRequestSampleAsyncResponseHeaderVo,
        GetRequestSampleAsyncResponseBodyVo>> getRequestSampleAsync(
    GetRequestSampleAsyncRequestQueryVo requestQueryVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/test/request/get-request";
  String prodServerUrl = "/tk/ra/test/request/get-request";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestQueryParams["queryParamString"] = requestQueryVo.queryParamString;
  if (requestQueryVo.queryParamStringNullable != null) {
    requestQueryParams["queryParamStringNullable"] =
        requestQueryVo.queryParamStringNullable;
  }
  requestQueryParams["queryParamStringList"] =
      requestQueryVo.queryParamStringList;
  if (requestQueryVo.queryParamStringListNullable != null) {
    requestQueryParams["queryParamStringListNullable"] =
        requestQueryVo.queryParamStringListNullable;
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
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    GetRequestSampleAsyncResponseHeaderVo responseHeader;
    GetRequestSampleAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = GetRequestSampleAsyncResponseHeaderVo(
        responseHeaderMap["content-type"]);

    // responseBody 가 반환되는 조건
    if (statusCode == 200) {
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody = GetRequestSampleAsyncResponseBodyVo(
        responseBodyMap["responseBodyString"],
        responseBodyMap["responseBodyStringNullable"],
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

class GetRequestSampleAsyncRequestQueryVo {
  String queryParamString; // String 쿼리 파라미터
  String? queryParamStringNullable; // String 쿼리 파라미터 Nullable
  List<String> queryParamStringList; // StringList 쿼리 파라미터
  List<String>? queryParamStringListNullable; // StringList 쿼리 파라미터 Nullable

  GetRequestSampleAsyncRequestQueryVo(
      this.queryParamString,
      this.queryParamStringNullable,
      this.queryParamStringList,
      this.queryParamStringListNullable);
}

class GetRequestSampleAsyncResponseHeaderVo {
  // content-type : ResponseHeader 예시용
  String contentType;

  GetRequestSampleAsyncResponseHeaderVo(this.contentType);
}

class GetRequestSampleAsyncResponseBodyVo {
  String responseBodyString; // 입력한 String 쿼리 파라미터
  String? responseBodyStringNullable; // 입력한 String 쿼리 파라미터 Nullable
  List<String> responseBodyStringList; // 입력한 StringList 쿼리 파라미터
  List<String>?
      responseBodyStringListNullable; // 입력한 StringList 쿼리 파라미터 Nullable

  GetRequestSampleAsyncResponseBodyVo(
      this.responseBodyString,
      this.responseBodyStringNullable,
      this.responseBodyStringList,
      this.responseBodyStringListNullable);
}

////
// (Post 요청 샘플 (Request Body))
Future<
    gc_my_classes.NetworkResponseObject<PostRequestSampleAsyncResponseHeaderVo,
        PostRequestSampleAsyncResponseBodyVo>> postRequestSampleAsync(
    PostRequestSampleAsyncRequestBodyVo requestBodyVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/tk/ra/test/request/post-request";
  String prodServerUrl = "/tk/ra/test/request/post-request";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!
  requestBody["requestBodyString"] = requestBodyVo.requestBodyString;
  if (requestBodyVo.requestBodyStringNullable != null) {
    requestBody["requestBodyStringNullable"] =
        requestBodyVo.requestBodyStringNullable;
  }
  requestBody["requestBodyStringList"] = requestBodyVo.requestBodyStringList;
  if (requestBodyVo.requestBodyStringListNullable != null) {
    requestBody["requestBodyStringListNullable"] =
        requestBodyVo.requestBodyStringListNullable;
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
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostRequestSampleAsyncResponseHeaderVo responseHeader;
    PostRequestSampleAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = PostRequestSampleAsyncResponseHeaderVo(
        responseHeaderMap["content-type"]);

    // responseBody 가 반환되는 조건
    if (statusCode == 200) {
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody = PostRequestSampleAsyncResponseBodyVo(
        responseBodyMap["responseBodyString"],
        responseBodyMap["responseBodyStringNullable"],
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

class PostRequestSampleAsyncRequestBodyVo {
  String requestBodyString; // String 쿼리 파라미터
  String? requestBodyStringNullable; // String 쿼리 파라미터 Nullable
  List<String> requestBodyStringList; // StringList 쿼리 파라미터
  List<String>? requestBodyStringListNullable; // StringList 쿼리 파라미터 Nullable

  PostRequestSampleAsyncRequestBodyVo(
      this.requestBodyString,
      this.requestBodyStringNullable,
      this.requestBodyStringList,
      this.requestBodyStringListNullable);
}

class PostRequestSampleAsyncResponseHeaderVo {
  // content-type : ResponseHeader 예시용
  String contentType;

  PostRequestSampleAsyncResponseHeaderVo(this.contentType);
}

class PostRequestSampleAsyncResponseBodyVo {
  String responseBodyString; // 입력한 String 쿼리 파라미터
  String? responseBodyStringNullable; // 입력한 String 쿼리 파라미터 Nullable
  List<String> responseBodyStringList; // 입력한 StringList 쿼리 파라미터
  List<String>?
      responseBodyStringListNullable; // 입력한 StringList 쿼리 파라미터 Nullable

  PostRequestSampleAsyncResponseBodyVo(
      this.responseBodyString,
      this.responseBodyStringNullable,
      this.responseBodyStringList,
      this.responseBodyStringListNullable);
}

////
// (Post 요청 샘플 (x-www-form-urlencoded))
Future<
    gc_my_classes.NetworkResponseObject<
        PostRequestSampleXwfuAsyncResponseHeaderVo,
        PostRequestSampleXwfuAsyncResponseBodyVo>> postRequestSampleXwfuAsync(
    PostRequestSampleXwfuAsyncRequestBodyVo requestBodyVo) async {
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
  if (requestBodyVo.requestFormStringNullable != null) {
    requestBody["requestFormStringNullable"] =
        requestBodyVo.requestFormStringNullable;
  }
  requestBody["requestFormStringList"] = requestBodyVo.requestFormStringList;
  if (requestBodyVo.requestFormStringListNullable != null) {
    requestBody["requestFormStringListNullable"] =
        requestBodyVo.requestFormStringListNullable;
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
          contentType: Headers.formUrlEncodedContentType,
        ),
        data: requestBody);

    int statusCode = response.statusCode!;
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostRequestSampleXwfuAsyncResponseHeaderVo responseHeader;
    PostRequestSampleXwfuAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = PostRequestSampleXwfuAsyncResponseHeaderVo(
        responseHeaderMap["content-type"]);

    // responseBody 가 반환되는 조건
    if (statusCode == 200) {
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody = PostRequestSampleXwfuAsyncResponseBodyVo(
        responseBodyMap["responseBodyString"],
        responseBodyMap["responseBodyStringNullable"],
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

class PostRequestSampleXwfuAsyncRequestBodyVo {
  String requestFormString; // String 쿼리 파라미터
  String? requestFormStringNullable; // String 쿼리 파라미터 Nullable
  List<String> requestFormStringList; // StringList 쿼리 파라미터
  List<String>? requestFormStringListNullable; // StringList 쿼리 파라미터 Nullable

  PostRequestSampleXwfuAsyncRequestBodyVo(
      this.requestFormString,
      this.requestFormStringNullable,
      this.requestFormStringList,
      this.requestFormStringListNullable);
}

class PostRequestSampleXwfuAsyncResponseHeaderVo {
  // content-type : ResponseHeader 예시용
  String contentType;

  PostRequestSampleXwfuAsyncResponseHeaderVo(this.contentType);
}

class PostRequestSampleXwfuAsyncResponseBodyVo {
  String responseBodyString; // 입력한 String 쿼리 파라미터
  String? responseBodyStringNullable; // 입력한 String 쿼리 파라미터 Nullable
  List<String> responseBodyStringList; // 입력한 StringList 쿼리 파라미터
  List<String>?
      responseBodyStringListNullable; // 입력한 StringList 쿼리 파라미터 Nullable

  PostRequestSampleXwfuAsyncResponseBodyVo(
      this.responseBodyString,
      this.responseBodyStringNullable,
      this.responseBodyStringList,
      this.responseBodyStringListNullable);
}

////
// (Post 요청 샘플 (multipart/form-data))
Future<
        gc_my_classes.NetworkResponseObject<
            PostRequestSampleMultipartFormDataAsyncResponseHeaderVo,
            PostRequestSampleMultipartFormDataAsyncResponseBodyVo>>
    postRequestSampleMultipartFormDataAsync(
        PostRequestSampleMultipartFormDataAsyncRequestBodyVo
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
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostRequestSampleMultipartFormDataAsyncResponseHeaderVo responseHeader;
    PostRequestSampleMultipartFormDataAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = PostRequestSampleMultipartFormDataAsyncResponseHeaderVo(
        responseHeaderMap["content-type"]);

    // responseBody 가 반환되는 조건
    if (statusCode == 200) {
      Map<String, dynamic> responseBodyMap = response.data;

      responseBody = PostRequestSampleMultipartFormDataAsyncResponseBodyVo(
        responseBodyMap["responseBodyString"],
        responseBodyMap["responseBodyStringNullable"],
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

class PostRequestSampleMultipartFormDataAsyncRequestBodyVo {
  String requestFormString; // String 쿼리 파라미터
  String? requestFormStringNullable; // String 쿼리 파라미터 Nullable
  List<String> requestFormStringList; // StringList 쿼리 파라미터
  List<String>? requestFormStringListNullable; // StringList 쿼리 파라미터 Nullable
  MultipartFile multipartFile; // 멀티 파트 파일
  MultipartFile? multipartFileNullable; // 멀티 파트 파일 Nullable

  PostRequestSampleMultipartFormDataAsyncRequestBodyVo(
    this.requestFormString,
    this.requestFormStringNullable,
    this.requestFormStringList,
    this.requestFormStringListNullable,
    this.multipartFile,
    this.multipartFileNullable,
  );
}

class PostRequestSampleMultipartFormDataAsyncResponseHeaderVo {
  // content-type : ResponseHeader 예시용
  String contentType;

  PostRequestSampleMultipartFormDataAsyncResponseHeaderVo(this.contentType);
}

class PostRequestSampleMultipartFormDataAsyncResponseBodyVo {
  String responseBodyString; // 입력한 String 쿼리 파라미터
  String? responseBodyStringNullable; // 입력한 String 쿼리 파라미터 Nullable
  List<String> responseBodyStringList; // 입력한 StringList 쿼리 파라미터
  List<String>?
      responseBodyStringListNullable; // 입력한 StringList 쿼리 파라미터 Nullable

  PostRequestSampleMultipartFormDataAsyncResponseBodyVo(
      this.responseBodyString,
      this.responseBodyStringNullable,
      this.responseBodyStringList,
      this.responseBodyStringListNullable);
}

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
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    GetRequestReturnTextStringAsyncResponseHeaderVo responseHeader;
    String? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = GetRequestReturnTextStringAsyncResponseHeaderVo(
        responseHeaderMap["content-type"]);

    // responseBody 가 반환되는 조건
    if (statusCode == 200) {
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
  // content-type : ResponseHeader 예시용
  String contentType;

  GetRequestReturnTextStringAsyncResponseHeaderVo(this.contentType);
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
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    GetRequestReturnTextHtmlAsyncResponseHeaderVo responseHeader;
    String? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = GetRequestReturnTextHtmlAsyncResponseHeaderVo(
        responseHeaderMap["content-type"]);

    // responseBody 가 반환되는 조건
    if (statusCode == 200) {
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
  // content-type : ResponseHeader 예시용
  String contentType;

  GetRequestReturnTextHtmlAsyncResponseHeaderVo(this.contentType);
}
