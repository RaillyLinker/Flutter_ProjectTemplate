// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../global_classes/gc_my_classes.dart' as gc_my_classes;

// [페이지 화면 위젯 작성 파일]
// 페이지 화면 구현을 담당합니다.
// 로직 처리는 pageBusiness 객체에 위임하세요.

//------------------------------------------------------------------------------
// (페이지 UI 위젯)
// !!!세부 화면 정의!!
class PageView extends StatelessWidget {
  const PageView({super.key});

  @override
  Widget build(BuildContext context) {
    // pageBusiness 객체
    page_business.PageBusiness pageBusiness =
        BlocProvider.of<gc_template_classes.BlocPageInfo>(context)
            .state
            .pageBusiness;

    // Mobile 앱 status bar 색상 변경
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !kIsWeb,
        title: const Text(
          "컨텍스트 메뉴 샘플",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              gc_my_classes.ContextMenuRegion(
                contextMenuRegionItemVoList: [
                  gc_my_classes.ContextMenuRegionItemVo(
                      const Text(
                        "토스트 테스트",
                        style: TextStyle(
                            color: Colors.black, fontFamily: "MaruBuri"),
                      ), () {
                    pageBusiness.toastTestMenuBtn();
                  }),
                  gc_my_classes.ContextMenuRegionItemVo(
                      const Text(
                        "다이얼로그 닫기",
                        style: TextStyle(
                            color: Colors.black, fontFamily: "MaruBuri"),
                      ), () {
                    pageBusiness.dialogTestMenuBtn();
                  }),
                ],
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 10, right: 10),
                  color: Colors.blue[100], // 옅은 파란색
                  child: const Text(
                    '우클릭 해보세요.',
                    style:
                        TextStyle(color: Colors.black, fontFamily: "MaruBuri"),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              gc_my_classes.ContextMenuRegion(
                contextMenuRegionItemVoList: [
                  gc_my_classes.ContextMenuRegionItemVo(
                      const Text(
                        "뒤로가기",
                        style: TextStyle(
                            color: Colors.black, fontFamily: "MaruBuri"),
                      ), () {
                    pageBusiness.goBackBtn();
                  }),
                ],
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 10, right: 10),
                  color: Colors.blue[100], // 옅은 파란색
                  child: const Text(
                    '모바일에선 길게 누르세요.',
                    style:
                        TextStyle(color: Colors.black, fontFamily: "MaruBuri"),
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
