// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// [페이지의 외곽 프레임 위젯 작성 파일]
// 전역의 페이지에서 사용 가능한 위젯입니다.
// View 에 해당하며, Business Logic 생성자에 콜백 함수 파라미터를 넣어주어 처리하세요.
// todo : 홈으로 이동 버튼

//------------------------------------------------------------------------------
// (페이지 최외곽 프레임 템플릿)
class PageOutFrame extends StatelessWidget {
  const PageOutFrame(this.pageTitle, this.child,
      {super.key, this.isPageBackgroundBlue = false});

  // 페이지 타이틀
  final String pageTitle;

  // 프레임 위젯 child
  final Widget child;

  // 페이지 배경색을 파란색으로 할지 여부
  final bool isPageBackgroundBlue;

  @override
  Widget build(BuildContext context) {
    // Mobile 앱 status bar 색상 변경
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: !kIsWeb,
            title: Text(pageTitle, style: const TextStyle(color: Colors.white)),
            backgroundColor: Colors.blue,
            iconTheme:
                const IconThemeData(color: Colors.white //change your color here
                    )),
        backgroundColor:
            isPageBackgroundBlue ? Colors.blue : const Color(0xFFFFFFFF),
        body: child);
  }
}

////
// (Sliver 타입 페이지 최외곽 프레임 템플릿)
class SliverPageOutFrame extends StatelessWidget {
  const SliverPageOutFrame(this.pageTitle, this.sliverChildren,
      {super.key, this.isPageBackgroundBlue = false});

  // 페이지 타이틀
  final String pageTitle;

  // 프레임 위젯 sliver 타입 child
  final List<Widget> sliverChildren;

  // 페이지 배경색을 파란색으로 할지 여부
  final bool isPageBackgroundBlue;

  @override
  Widget build(BuildContext context) {
    // Mobile 앱 status bar 색상 변경
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));

    sliverChildren.insert(
        0,
        SliverAppBar(
          automaticallyImplyLeading: !kIsWeb,
          pinned: true,
          centerTitle: false,
          title: Text(
            pageTitle,
            style: const TextStyle(color: Colors.white, fontFamily: "MaruBuri"),
          ),
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
        ));

    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: sliverChildren));
  }
}
