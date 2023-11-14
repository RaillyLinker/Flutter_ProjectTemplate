// (external)
import 'package:flutter/material.dart';

// (page)
import 'page_widgets/page_widget_custom.dart' as page_widget_custom;
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
        child: page_widget_custom.OuterContainerForComplete(
          _pageBusiness.pageViewModel.outerContainerForCompleteVm,
          key: _pageBusiness.pageViewModel.outerContainerForCompleteStateGk,
        ),
      ),
    );
  }
}
