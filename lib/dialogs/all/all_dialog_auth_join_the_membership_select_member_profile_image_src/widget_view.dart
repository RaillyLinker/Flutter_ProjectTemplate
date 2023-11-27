// (external)
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';

// (inner Folder)
import 'widget_business.dart' as widget_business;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

//------------------------------------------------------------------------------
// (입력 데이터)
class InputVo {
  const InputVo();
// !!!위젯 입력값 선언!!!
}

// (결과 데이터)
class OutputVo {
  const OutputVo({required this.imageSourceType});

// !!!위젯 출력값 선언!!!

  // 선택한 이미지 소스 타입
  final ImageSourceType imageSourceType;
}

enum ImageSourceType {
  gallery, // 갤러리
  camera, // 카메라
  defaultImage, // 기본 이미지
}

//------------------------------------------------------------------------------
class WidgetView extends StatefulWidget {
  const WidgetView(
      {super.key,
      required this.business,
      required this.inputVo,
      required this.onDialogCreated});

  // 다이얼로그가 Created 된 시점에 한번 실행됨
  final VoidCallback onDialogCreated;

  @override
  WidgetViewState createState() => WidgetViewState();
  final widget_business.WidgetBusiness business;
  final InputVo inputVo;
}

class WidgetViewState extends State<WidgetView> with WidgetsBindingObserver {
  // [콜백 함수]
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    business = widget.business;
    business.context = context;
    business.inputVo = widget.inputVo;
    business.refreshUi = refreshUi;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    business.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: business.canPop,
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {
          if (!business.onPageCreated) {
            business.onCreated();
            widget.onDialogCreated();
            business.onPageCreated = true;
          }

          business.onFocusGained();
        },
        onFocusLost: () async {
          business.onFocusLost();
        },
        onVisibilityGained: () async {
          business.onVisibilityGained();
        },
        onVisibilityLost: () async {
          business.onVisibilityLost();
        },
        onForegroundGained: () async {
          business.onForegroundGained();
        },
        onForegroundLost: () async {
          business.onForegroundLost();
        },
        child: WidgetUi.viewWidgetBuild(context: context, business: business),
      ),
    );
  }

  // [public 변수]
  late widget_business.WidgetBusiness business;

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }
}

class WidgetUi {
  // [뷰 위젯]
  static Widget viewWidgetBuild(
      {required BuildContext context,
      required widget_business.WidgetBusiness business}) {
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
                              business
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
                                    business.onResultSelected(
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
                              business.onResultSelected(
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