// (external)
import 'package:flutter/material.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_classes/gc_my_classes.dart' as gc_my_classes;

// [페이지 화면 위젯 작성 파일]
// 페이지 화면 구현을 담당합니다.
// 로직 처리는 pageBusiness 객체에 위임하세요.

//------------------------------------------------------------------------------
// (페이지 UI 위젯)
// !!!세부 화면 정의!!!
class PageView extends StatelessWidget {
  const PageView(this._pageBusiness, {super.key});

  // 페이지 비즈니스 객체
  final page_business.PageBusiness _pageBusiness;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
            child: Container(
                height: 280,
                width: 300,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Center(
                    child: gc_my_classes.ContextMenuRegion(
                        contextMenuRegionItemVoList: [
                      gc_my_classes.ContextMenuRegionItemVo(
                          const Text(
                            "토스트 테스트",
                            style: TextStyle(
                                color: Colors.black, fontFamily: "MaruBuri"),
                          ), () {
                        _pageBusiness.toastTestMenuBtn();
                      }),
                      gc_my_classes.ContextMenuRegionItemVo(
                          const Text(
                            "다이얼로그 닫기",
                            style: TextStyle(
                                color: Colors.black, fontFamily: "MaruBuri"),
                          ), () {
                        _pageBusiness.closeDialog();
                      }),
                    ],
                        child: Container(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 10, right: 10),
                            color: Colors.blue[100], // 옅은 파란색
                            child: const Text('우클릭 해보세요.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "MaruBuri"))))))));
  }
}
