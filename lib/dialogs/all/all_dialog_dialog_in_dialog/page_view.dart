// (external)
import 'package:flutter/material.dart';

// (page)
import 'page_business.dart' as page_business;

// [페이지 화면 위젯 작성 파일]
// 페이지 화면 구현을 담당합니다. (Widget 과 Business 간의 결합을 담당)
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
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          _pageBusiness.showInfoDialog();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          "확인 다이얼로그 호출",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "MaruBuri"),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _pageBusiness.showLoadingDialog();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          "로딩 스피너 다이얼로그 호출",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "MaruBuri"),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _pageBusiness.showDialogInDialog();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text("다중 다이얼로그 샘플 호출",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: "MaruBuri")))
                    ]))))));
  }
}
