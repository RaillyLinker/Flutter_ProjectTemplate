// (external)
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sync/semaphore.dart';

// [전역 클래스 선언 파일]
// 프로그램 전역에서 사용할 Class 를 선언하는 파일입니다.

// -----------------------------------------------------------------------------
// (스레드 합류 클래스)
// 나눠진 스레드를 하나의 시점에 모을 때 사용합니다.
// 사용법 :
// var threadConfluenceObj = ThreadConfluenceObj(2, () {
//     print("Threads all Complete!");
// });
// 위와 같이 먼저 합류 객체를 만듭니다.
// 첫번째 파라미터는 합류가 이루어지는 비동기 작업 개수이고,
// 두번째 파라미터는 합류가 이루어진 시점에 동작하는 콜백입니다.
// 위 객체를 해석하자면,
// 2 개의 스레드가 합류되면 Threads all Complete! 라는 문구를 출력한다는 것입니다.
// 합류할 각 스레드들은 비동기 작업이 끝난 후, 작업이 끝났음을 합류 객체에게 알려주기 위하여,
// threadConfluenceObj.threadComplete();
// 를 해줍니다.
// 여기선 threadConfluenceObj.threadComplete(); 가 2번 동작하면 합류 객체에 넘겨준 콜백이 실행되는 것입니다.
class ThreadConfluenceObj {
  late int numberOfThreadsBeingJoinedMbr;
  late final void Function() _onComplete;

  int _threadAccessCountMbr = 0;
  final Semaphore _threadAccessCountSemaphoreMbr = Semaphore(1);

  ThreadConfluenceObj(this.numberOfThreadsBeingJoinedMbr, this._onComplete);

  void threadComplete() {
    () async {
      _threadAccessCountSemaphoreMbr.acquire();
      if (_threadAccessCountMbr < 0) {
        // 오버플로우 방지
        return;
      }

      // 스레드 접근 카운트 +1
      ++_threadAccessCountMbr;

      if (_threadAccessCountMbr != numberOfThreadsBeingJoinedMbr) {
        // 접근 카운트가 합류 총 개수를 넘었을 때 or 접근 카운트가 합류 총 개수에 미치지 못했을 때
        _threadAccessCountSemaphoreMbr.release();
      } else {
        // 접근 카운트가 합류 총 개수에 다다랐을 때
        _threadAccessCountSemaphoreMbr.release();
        _onComplete();
      }
    }();
  }
}

// (네트워크 응답 Vo)
class NetworkResponseObject<ResponseHeaderVo, ResponseBodyVo> {
  // Dio Error 가 나지 않은 경우 not null
  NetworkResponseObjectOk? networkResponseObjectOk;

  // Dio Error 가 난 경우에 not null
  DioException? dioException;

  NetworkResponseObject(this.networkResponseObjectOk, this.dioException);
}

class NetworkResponseObjectOk<ResponseHeaderVo, ResponseBodyVo> {
  // Http Status Code
  int responseStatusCode;

  // Response Header Object
  ResponseHeaderVo responseHeaders;

  // Response Body Object (body 가 반환 되지 않는 조건에는 null)
  ResponseBodyVo? responseBody;

  NetworkResponseObjectOk(
      this.responseStatusCode, this.responseHeaders, this.responseBody);
}

// (AnimatedSwitcher 설정)
class AnimatedSwitcherConfig {
  Duration duration;
  Duration? reverseDuration;
  Curve switchInCurve;
  Curve switchOutCurve;
  AnimatedSwitcherTransitionBuilder transitionBuilder;
  AnimatedSwitcherLayoutBuilder layoutBuilder;

  AnimatedSwitcherConfig(this.duration,
      {this.reverseDuration,
      this.switchInCurve = Curves.linear,
      this.switchOutCurve = Curves.linear,
      this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder,
      this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder});

  AnimatedSwitcherConfig clone() {
    return AnimatedSwitcherConfig(duration,
        reverseDuration: reverseDuration,
        switchInCurve: switchInCurve,
        switchOutCurve: switchOutCurve,
        transitionBuilder: transitionBuilder,
        layoutBuilder: layoutBuilder);
  }
}
