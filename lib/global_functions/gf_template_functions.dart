// (external)

// [전역 함수 작성 파일]
// 프로그램 전역에서 사용할 함수들은 여기에 모아둡니다.

// -----------------------------------------------------------------------------
// (RequestUrl 에 QueryParam 붙이는 함수)
// ex : queryParams = {"testParam1" : "testParam"}, requestUrl = "/test/url" => "/test/url?testParam1=testParam"
String mergeNetworkQueryParam(
    {required Map<String, dynamic> queryParams, required String requestUrl}) {
  StringBuffer resultUrl = StringBuffer(requestUrl);

  int idx = 0;
  queryParams.forEach((key, value) {
    if (value is List) {
      int innerIdx = 0;
      for (dynamic listValue in value) {
        if (idx == 0 && innerIdx == 0) {
          if (listValue != null) {
            resultUrl.write("?$key=$listValue");
          }
        } else {
          if (listValue != null) {
            resultUrl.write("&$key=$listValue");
          }
        }
        ++innerIdx;
      }
    } else {
      if (idx == 0) {
        if (value != null) {
          resultUrl.write("?$key=$value");
        }
      } else {
        if (value != null) {
          resultUrl.write("&$key=$value");
        }
      }
    }
    ++idx;
  });

  return resultUrl.toString();
}
