// (external)
import 'package:dio/dio.dart';

// [템플릿 코드를 줄이기 위해 사용하는 클래스 모음 파일]

// -----------------------------------------------------------------------------
// (네트워크 응답 Vo)
class NetworkResponseObject<ResponseHeaderVo, ResponseBodyVo> {
  NetworkResponseObject(
      {required this.networkResponseObjectOk, required this.dioException});

  // Dio Error 가 나지 않은 경우 not null
  NetworkResponseObjectOk? networkResponseObjectOk;

  // Dio Error 가 난 경우에 not null
  DioException? dioException;
}

class NetworkResponseObjectOk<ResponseHeaderVo, ResponseBodyVo> {
  NetworkResponseObjectOk(
      {required this.responseStatusCode,
      required this.responseHeaders,
      required this.responseBody});

  // Http Status Code
  int responseStatusCode;

  // Response Header Object
  ResponseHeaderVo responseHeaders;

  // Response Body Object (body 가 반환 되지 않는 조건에는 null)
  ResponseBodyVo? responseBody;
}
