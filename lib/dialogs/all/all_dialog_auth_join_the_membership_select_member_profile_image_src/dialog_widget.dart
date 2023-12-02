// (external)
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// (inner Folder)
import 'dialog_widget_state.dart' as dialog_widget_state;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
// (입력 데이터)
class InputVo {
  // !!!위젯 입력값 선언!!!
  const InputVo();
}

// (결과 데이터)
class OutputVo {
  // !!!위젯 출력값 선언!!!
  const OutputVo({required this.imageSourceType});

  // 선택한 이미지 소스 타입
  final ImageSourceType imageSourceType;
}

enum ImageSourceType {
  gallery, // 갤러리
  camera, // 카메라
  defaultImage, // 기본 이미지
}

class DialogWidget extends StatefulWidget {
  const DialogWidget(
      {required this.globalKey,
      required this.inputVo,
      required this.onDialogCreated})
      : super(key: globalKey);

  // [콜백 함수]
  @override
  dialog_widget_state.DialogWidgetState createState() =>
      dialog_widget_state.DialogWidgetState();

  // [public 변수]
  final InputVo inputVo;
  final GlobalKey<dialog_widget_state.DialogWidgetState> globalKey;

  // 다이얼로그가 Created 된 시점에 한번 실행됨
  final VoidCallback onDialogCreated;

  // [화면 작성]
  Widget widgetUiBuild(
      {required BuildContext context,
      required dialog_widget_state.DialogWidgetState currentState}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: SizedBox(
          width: 280,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 55,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: const Padding(
                  padding: EdgeInsets.only(left: 17, right: 17),
                  child: Center(
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      "프로필 사진 선택",
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: "MaruBuri",
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16))),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17, right: 17),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              currentState
                                  .onResultSelected(ImageSourceType.gallery);
                            },
                            child: const ListTile(
                              mouseCursor: SystemMouseCursors.click,
                              leading: Icon(Icons.photo),
                              title: Text('앨범에서 선택'),
                            ),
                          ),
                          // 카메라는 모바일 환경에서만
                          (!kIsWeb && (Platform.isAndroid || Platform.isIOS))
                              ? GestureDetector(
                                  onTap: () {
                                    currentState.onResultSelected(
                                        ImageSourceType.camera);
                                  },
                                  child: const ListTile(
                                    mouseCursor: SystemMouseCursors.click,
                                    leading: Icon(Icons.camera_alt),
                                    title: Text('사진 찍기'),
                                  ),
                                )
                              : const SizedBox(),
                          GestureDetector(
                            onTap: () {
                              currentState.onResultSelected(
                                  ImageSourceType.defaultImage);
                            },
                            child: const ListTile(
                              mouseCursor: SystemMouseCursors.click,
                              leading: Icon(Icons.account_box),
                              title: Text('기본 프로필 적용'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
