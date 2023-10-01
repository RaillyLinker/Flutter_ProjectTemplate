// (external)
import 'package:dio/dio.dart';

// (all)
import 'package:flutter_project_template/repositories/network/network_repositories.dart'
    as network_repositories;
import '../../../global_functions/gf_template_functions.dart'
    as gf_template_functions;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
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
    gc_template_classes.NetworkResponseObject<
        GetGetRequestSampleAsyncResponseHeaderVo,
        GetGetRequestSampleAsyncResponseBodyVo>> getGetRequestSampleAsync(
    GetGetRequestSampleAsyncRequestQueryVo requestQueryVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/get-request-sample";
  String prodServerUrl = "/get-request-sample";

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
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
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

    GetGetRequestSampleAsyncResponseHeaderVo responseHeader;
    GetGetRequestSampleAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = GetGetRequestSampleAsyncResponseHeaderVo(
        responseHeaderMap["content-type"]);

    // !!!responseBody 가 반환되는 조건!!
    if (statusCode == 200) {
      Map<String, dynamic> responseBodyMap = response.data;

      // responseBody 로 List 타입이 넘어오면 List<>.from 으로 받고,
      // Object 타입이 넘어오면 Map<String, dynamic> 으로 받고,
      // Object List 타입이 넘어오면 List<Map<String, dynamic>> 으로 받아서 처리

      responseBody = GetGetRequestSampleAsyncResponseBodyVo(
        responseBodyMap["responseBodyString"],
        responseBodyMap["responseBodyStringNullable"],
        List<String>.from(responseBodyMap["responseBodyStringList"]),
        (responseBodyMap["responseBodyStringListNullable"] == null)
            ? null
            : List<String>.from(
                responseBodyMap["responseBodyStringListNullable"]),
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

class GetGetRequestSampleAsyncRequestQueryVo {
  String queryParamString; // String 쿼리 파라미터
  String? queryParamStringNullable; // String 쿼리 파라미터 Nullable
  List<String> queryParamStringList; // StringList 쿼리 파라미터
  List<String>? queryParamStringListNullable; // StringList 쿼리 파라미터 Nullable

  GetGetRequestSampleAsyncRequestQueryVo(
      this.queryParamString,
      this.queryParamStringNullable,
      this.queryParamStringList,
      this.queryParamStringListNullable);
}

class GetGetRequestSampleAsyncResponseHeaderVo {
  // content-type : ResponseHeader 예시용
  String contentType;

  GetGetRequestSampleAsyncResponseHeaderVo(this.contentType);
}

class GetGetRequestSampleAsyncResponseBodyVo {
  String responseBodyString; // 입력한 String 쿼리 파라미터
  String? responseBodyStringNullable; // 입력한 String 쿼리 파라미터 Nullable
  List<String> responseBodyStringList; // 입력한 StringList 쿼리 파라미터
  List<String>?
      responseBodyStringListNullable; // 입력한 StringList 쿼리 파라미터 Nullable

  GetGetRequestSampleAsyncResponseBodyVo(
      this.responseBodyString,
      this.responseBodyStringNullable,
      this.responseBodyStringList,
      this.responseBodyStringListNullable);
}

////
// (Post 요청 샘플 (Request Body))
Future<
    gc_template_classes.NetworkResponseObject<
        PostPostRequestSampleAsyncResponseHeaderVo,
        PostPostRequestSampleAsyncResponseBodyVo>> postPostRequestSampleAsync(
    PostPostRequestSampleAsyncRequestBodyVo requestBodyVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/post-request-sample";
  String prodServerUrl = "/post-request-sample";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};
  Map<String, dynamic> requestBody = {};

  // !!!Request Object 를 Map 으로 만들기!!
  // requestBody 에 Object 타입을 넣으려면, Map<String, dynamic> 로 넣기
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
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
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

    PostPostRequestSampleAsyncResponseHeaderVo responseHeader;
    PostPostRequestSampleAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = PostPostRequestSampleAsyncResponseHeaderVo(
        responseHeaderMap["content-type"]);

    // !!!responseBody 가 반환되는 조건!!
    if (statusCode == 200) {
      Map<String, dynamic> responseBodyMap = response.data;

      // responseBody 로 List 타입이 넘어오면 List<>.from 으로 받고,
      // Object 타입이 넘어오면 Map<String, dynamic> 으로 받고,
      // Object List 타입이 넘어오면 List<Map<String, dynamic>> 으로 받아서 처리

      responseBody = PostPostRequestSampleAsyncResponseBodyVo(
        responseBodyMap["responseBodyString"],
        responseBodyMap["responseBodyStringNullable"],
        List<String>.from(responseBodyMap["responseBodyStringList"]),
        (responseBodyMap["responseBodyStringListNullable"] == null)
            ? null
            : List<String>.from(
                responseBodyMap["responseBodyStringListNullable"]),
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

class PostPostRequestSampleAsyncRequestBodyVo {
  String requestBodyString; // String 쿼리 파라미터
  String? requestBodyStringNullable; // String 쿼리 파라미터 Nullable
  List<String> requestBodyStringList; // StringList 쿼리 파라미터
  List<String>? requestBodyStringListNullable; // StringList 쿼리 파라미터 Nullable

  PostPostRequestSampleAsyncRequestBodyVo(
      this.requestBodyString,
      this.requestBodyStringNullable,
      this.requestBodyStringList,
      this.requestBodyStringListNullable);
}

class PostPostRequestSampleAsyncResponseHeaderVo {
  // content-type : ResponseHeader 예시용
  String contentType;

  PostPostRequestSampleAsyncResponseHeaderVo(this.contentType);
}

class PostPostRequestSampleAsyncResponseBodyVo {
  String responseBodyString; // 입력한 String 쿼리 파라미터
  String? responseBodyStringNullable; // 입력한 String 쿼리 파라미터 Nullable
  List<String> responseBodyStringList; // 입력한 StringList 쿼리 파라미터
  List<String>?
      responseBodyStringListNullable; // 입력한 StringList 쿼리 파라미터 Nullable

  PostPostRequestSampleAsyncResponseBodyVo(
      this.responseBodyString,
      this.responseBodyStringNullable,
      this.responseBodyStringList,
      this.responseBodyStringListNullable);
}

////
// (Post 요청 샘플 (x-www-form-urlencoded))
Future<
        gc_template_classes.NetworkResponseObject<
            PostPostRequestSampleXWwwFormUrlencodedAsyncResponseHeaderVo,
            PostPostRequestSampleXWwwFormUrlencodedAsyncResponseBodyVo>>
    postPostRequestSampleXWwwFormUrlencodedAsync(
        PostPostRequestSampleXWwwFormUrlencodedAsyncRequestBodyVo
            requestBodyVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/post-request-sample-x-www-form-urlencoded";
  String prodServerUrl = "/post-request-sample-x-www-form-urlencoded";

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
    Map<String, dynamic> responseHeaderMap = response.headers.map;

    PostPostRequestSampleXWwwFormUrlencodedAsyncResponseHeaderVo responseHeader;
    PostPostRequestSampleXWwwFormUrlencodedAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader =
        PostPostRequestSampleXWwwFormUrlencodedAsyncResponseHeaderVo(
            responseHeaderMap["content-type"]);

    // !!!responseBody 가 반환되는 조건!!
    if (statusCode == 200) {
      Map<String, dynamic> responseBodyMap = response.data;

      // responseBody 로 List 타입이 넘어오면 List<>.from 으로 받고,
      // Object 타입이 넘어오면 Map<String, dynamic> 으로 받고,
      // Object List 타입이 넘어오면 List<Map<String, dynamic>> 으로 받아서 처리

      responseBody = PostPostRequestSampleXWwwFormUrlencodedAsyncResponseBodyVo(
        responseBodyMap["responseBodyString"],
        responseBodyMap["responseBodyStringNullable"],
        List<String>.from(responseBodyMap["responseBodyStringList"]),
        (responseBodyMap["responseBodyStringListNullable"] == null)
            ? null
            : List<String>.from(
                responseBodyMap["responseBodyStringListNullable"]),
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

class PostPostRequestSampleXWwwFormUrlencodedAsyncRequestBodyVo {
  String requestFormString; // String 쿼리 파라미터
  String? requestFormStringNullable; // String 쿼리 파라미터 Nullable
  List<String> requestFormStringList; // StringList 쿼리 파라미터
  List<String>? requestFormStringListNullable; // StringList 쿼리 파라미터 Nullable

  PostPostRequestSampleXWwwFormUrlencodedAsyncRequestBodyVo(
      this.requestFormString,
      this.requestFormStringNullable,
      this.requestFormStringList,
      this.requestFormStringListNullable);
}

class PostPostRequestSampleXWwwFormUrlencodedAsyncResponseHeaderVo {
  // content-type : ResponseHeader 예시용
  String contentType;

  PostPostRequestSampleXWwwFormUrlencodedAsyncResponseHeaderVo(
      this.contentType);
}

class PostPostRequestSampleXWwwFormUrlencodedAsyncResponseBodyVo {
  String responseBodyString; // 입력한 String 쿼리 파라미터
  String? responseBodyStringNullable; // 입력한 String 쿼리 파라미터 Nullable
  List<String> responseBodyStringList; // 입력한 StringList 쿼리 파라미터
  List<String>?
      responseBodyStringListNullable; // 입력한 StringList 쿼리 파라미터 Nullable

  PostPostRequestSampleXWwwFormUrlencodedAsyncResponseBodyVo(
      this.responseBodyString,
      this.responseBodyStringNullable,
      this.responseBodyStringList,
      this.responseBodyStringListNullable);
}

////
// (Post 요청 샘플 (multipart/form-data))
Future<
        gc_template_classes.NetworkResponseObject<
            PostPostRequestSampleMultipartFormDataAsyncResponseHeaderVo,
            PostPostRequestSampleMultipartFormDataAsyncResponseBodyVo>>
    postPostRequestSampleMultipartFormDataAsync(
        PostPostRequestSampleMultipartFormDataAsyncRequestBodyVo
            requestBodyVo) async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/post-request-sample-multipart-form-data";
  String prodServerUrl = "/post-request-sample-multipart-form-data";

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
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
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

    PostPostRequestSampleMultipartFormDataAsyncResponseHeaderVo responseHeader;
    PostPostRequestSampleMultipartFormDataAsyncResponseBodyVo? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader =
        PostPostRequestSampleMultipartFormDataAsyncResponseHeaderVo(
            responseHeaderMap["content-type"]);

    // !!!responseBody 가 반환되는 조건!!
    if (statusCode == 200) {
      Map<String, dynamic> responseBodyMap = response.data;

      // responseBody 로 List 타입이 넘어오면 List<>.from 으로 받고,
      // Object 타입이 넘어오면 Map<String, dynamic> 으로 받고,
      // Object List 타입이 넘어오면 List<Map<String, dynamic>> 으로 받아서 처리

      responseBody = PostPostRequestSampleMultipartFormDataAsyncResponseBodyVo(
        responseBodyMap["responseBodyString"],
        responseBodyMap["responseBodyStringNullable"],
        List<String>.from(responseBodyMap["responseBodyStringList"]),
        (responseBodyMap["responseBodyStringListNullable"] == null)
            ? null
            : List<String>.from(
                responseBodyMap["responseBodyStringListNullable"]),
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

class PostPostRequestSampleMultipartFormDataAsyncRequestBodyVo {
  String requestFormString; // String 쿼리 파라미터
  String? requestFormStringNullable; // String 쿼리 파라미터 Nullable
  List<String> requestFormStringList; // StringList 쿼리 파라미터
  List<String>? requestFormStringListNullable; // StringList 쿼리 파라미터 Nullable
  MultipartFile multipartFile; // 멀티 파트 파일
  MultipartFile? multipartFileNullable; // 멀티 파트 파일 Nullable

  PostPostRequestSampleMultipartFormDataAsyncRequestBodyVo(
    this.requestFormString,
    this.requestFormStringNullable,
    this.requestFormStringList,
    this.requestFormStringListNullable,
    this.multipartFile,
    this.multipartFileNullable,
  );
}

class PostPostRequestSampleMultipartFormDataAsyncResponseHeaderVo {
  // content-type : ResponseHeader 예시용
  String contentType;

  PostPostRequestSampleMultipartFormDataAsyncResponseHeaderVo(this.contentType);
}

class PostPostRequestSampleMultipartFormDataAsyncResponseBodyVo {
  String responseBodyString; // 입력한 String 쿼리 파라미터
  String? responseBodyStringNullable; // 입력한 String 쿼리 파라미터 Nullable
  List<String> responseBodyStringList; // 입력한 StringList 쿼리 파라미터
  List<String>?
      responseBodyStringListNullable; // 입력한 StringList 쿼리 파라미터 Nullable

  PostPostRequestSampleMultipartFormDataAsyncResponseBodyVo(
      this.responseBodyString,
      this.responseBodyStringNullable,
      this.responseBodyStringList,
      this.responseBodyStringListNullable);
}

////
// (text/string 반환 샘플)
// Response Body 가 text/string 타입입니다.
Future<
    gc_template_classes.NetworkResponseObject<
        GetReturnTextStringSampleAsyncResponseHeaderVo,
        String>> getReturnTextStringSampleAsync() async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/return-text-string-sample";
  String prodServerUrl = "/return-text-string-sample";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
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

    GetReturnTextStringSampleAsyncResponseHeaderVo responseHeader;
    String? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = GetReturnTextStringSampleAsyncResponseHeaderVo(
        responseHeaderMap["content-type"]);

    // !!!responseBody 가 반환되는 조건!!
    if (statusCode == 200) {
      responseBody = response.data;
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

class GetReturnTextStringSampleAsyncResponseHeaderVo {
  // content-type : ResponseHeader 예시용
  String contentType;

  GetReturnTextStringSampleAsyncResponseHeaderVo(this.contentType);
}

////
// (text/html 반환 샘플)
// Response Body 가 text/html 타입입니다.
Future<
    gc_template_classes.NetworkResponseObject<
        GetReturnTextHtmlSampleAsyncResponseHeaderVo,
        String>> getReturnTextHtmlSampleAsync() async {
  // !!!개발 / 배포 모드별 요청 Path 지정!!
  String devServerUrl = "/return-text-html-sample";
  String prodServerUrl = "/return-text-html-sample";

  Map<String, dynamic> requestHeaders = {};
  Map<String, dynamic> requestQueryParams = {};

  // !!!Request Object 를 Map 으로 만들기!!

  // baseUrl + Request path + QueryParam
  String requestUrlAndParam = gf_template_functions.mergeNetworkQueryParam(
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

    GetReturnTextHtmlSampleAsyncResponseHeaderVo responseHeader;
    String? responseBody;

    // !!!Response Map 을 Response Object 로 변경!!
    responseHeader = GetReturnTextHtmlSampleAsyncResponseHeaderVo(
        responseHeaderMap["content-type"]);

    // !!!responseBody 가 반환되는 조건!!
    if (statusCode == 200) {
      responseBody = response.data;
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

class GetReturnTextHtmlSampleAsyncResponseHeaderVo {
  // content-type : ResponseHeader 예시용
  String contentType;

  GetReturnTextHtmlSampleAsyncResponseHeaderVo(this.contentType);
}
