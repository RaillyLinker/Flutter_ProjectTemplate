// (external)
import 'package:flutter/material.dart';

// (inner Folder)
import 'sf_widget_state.dart' as sf_widget_state;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
// (입력 데이터)
class InputVo {
  // !!!위젯 입력값 선언!!!
  const InputVo({required this.memberInfoVo});

  final MemberInfoVo? memberInfoVo;
}

class MemberInfoVo {
  const MemberInfoVo(
      {required this.memberUid,
      required this.tokenType,
      required this.accessToken,
      required this.accessTokenExpireWhen,
      required this.refreshToken,
      required this.refreshTokenExpireWhen});

  final String memberUid;
  final String tokenType;
  final String accessToken;
  final String accessTokenExpireWhen;
  final String refreshToken;
  final String refreshTokenExpireWhen;
}

class SfWidget extends StatefulWidget {
  const SfWidget({required this.globalKey, required this.inputVo})
      : super(key: globalKey);

  // [콜백 함수]
  @override
  sf_widget_state.SfWidgetState createState() =>
      sf_widget_state.SfWidgetState();

  // [public 변수]
  final InputVo inputVo;
  final GlobalKey<sf_widget_state.SfWidgetState> globalKey;

  // [화면 작성]
  Widget widgetUiBuild(
      {required BuildContext context,
      required sf_widget_state.SfWidgetState currentState}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          '멤버 정보',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "MaruBuri"),
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            const Expanded(
                flex: 2,
                child: Text(
                  '    - memberUid : ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: "MaruBuri"),
                )),
            Expanded(
                flex: 3,
                child: SelectableText(
                  currentState.memberInfoVo == null
                      ? "null"
                      : currentState.memberInfoVo!.memberUid,
                  style: const TextStyle(fontFamily: "MaruBuri"),
                )),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            const Expanded(
                flex: 2,
                child: Text(
                  '    - tokenType : ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: "MaruBuri"),
                )),
            Expanded(
                flex: 3,
                child: SelectableText(
                  currentState.memberInfoVo == null
                      ? "null"
                      : currentState.memberInfoVo!.tokenType,
                  style: const TextStyle(fontFamily: "MaruBuri"),
                )),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            const Expanded(
                flex: 2,
                child: Text(
                  '    - accessToken : ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: "MaruBuri"),
                )),
            Expanded(
                flex: 3,
                child: SelectableText(
                  currentState.memberInfoVo == null
                      ? "null"
                      : currentState.memberInfoVo!.accessToken,
                  style: const TextStyle(fontFamily: "MaruBuri"),
                )),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            const Expanded(
                flex: 2,
                child: Text(
                  '    - accessTokenExpireWhen : ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: "MaruBuri"),
                )),
            Expanded(
                flex: 3,
                child: SelectableText(
                  currentState.memberInfoVo == null
                      ? "null"
                      : currentState.memberInfoVo!.accessTokenExpireWhen,
                  style: const TextStyle(fontFamily: "MaruBuri"),
                )),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            const Expanded(
                flex: 2,
                child: Text(
                  '    - refreshToken : ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: "MaruBuri"),
                )),
            Expanded(
                flex: 3,
                child: SelectableText(
                  currentState.memberInfoVo == null
                      ? "null"
                      : currentState.memberInfoVo!.refreshToken,
                  style: const TextStyle(fontFamily: "MaruBuri"),
                )),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            const Expanded(
                flex: 2,
                child: Text(
                  '    - refreshTokenExpireWhen : ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: "MaruBuri"),
                )),
            Expanded(
                flex: 3,
                child: SelectableText(
                  currentState.memberInfoVo == null
                      ? "null"
                      : currentState.memberInfoVo!.refreshTokenExpireWhen,
                  style: const TextStyle(fontFamily: "MaruBuri"),
                )),
          ],
        ),
        const SizedBox(height: 40.0),
        const Text(
          '계정 관련 기능 샘플 리스트',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "MaruBuri"),
        ),
      ]),
    );
  }
}
