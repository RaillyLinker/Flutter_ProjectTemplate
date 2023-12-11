// (external)
import 'package:sync/semaphore.dart';
import 'package:flutter/material.dart';

// [전역 클래스 선언 파일]
// 프로그램 전역에서 사용할 Class 를 선언하는 파일입니다.

// -----------------------------------------------------------------------------
// (스레드 합류 클래스)
// 나눠진 스레드를 하나의 시점에 모을 때 사용합니다.
// 사용법 :
// var threadConfluenceObj = ThreadConfluenceObj(numberOfThreadsBeingJoined: 2, onComplete: () {
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
  ThreadConfluenceObj(
      {required this.numberOfThreadsBeingJoined, required this.onComplete});

  late int numberOfThreadsBeingJoined;
  late final void Function() onComplete;

  int threadAccessCount = 0;
  final Semaphore threadAccessCountSemaphore = Semaphore(1);

  void threadComplete() {
    () async {
      threadAccessCountSemaphore.acquire();
      if (threadAccessCount < 0) {
        // 오버플로우 방지
        return;
      }

      // 스레드 접근 카운트 +1
      ++threadAccessCount;

      if (threadAccessCount != numberOfThreadsBeingJoined) {
        // 접근 카운트가 합류 총 개수를 넘었을 때 or 접근 카운트가 합류 총 개수에 미치지 못했을 때
        threadAccessCountSemaphore.release();
      } else {
        // 접근 카운트가 합류 총 개수에 다다랐을 때
        threadAccessCountSemaphore.release();
        onComplete();
      }
    }();
  }
}

////
// (AnimatedSwitcher 설정)
class AnimatedSwitcherConfig {
  AnimatedSwitcherConfig(
      {required this.duration,
      required this.reverseDuration,
      this.switchInCurve = Curves.linear,
      this.switchOutCurve = Curves.linear,
      this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder,
      this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder});

  Duration duration;
  Duration? reverseDuration;
  Curve switchInCurve;
  Curve switchOutCurve;
  AnimatedSwitcherTransitionBuilder transitionBuilder;
  AnimatedSwitcherLayoutBuilder layoutBuilder;

  AnimatedSwitcherConfig clone() {
    return AnimatedSwitcherConfig(
        duration: duration,
        reverseDuration: reverseDuration,
        switchInCurve: switchInCurve,
        switchOutCurve: switchOutCurve,
        transitionBuilder: transitionBuilder,
        layoutBuilder: layoutBuilder);
  }
}
