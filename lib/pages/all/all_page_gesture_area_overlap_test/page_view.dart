// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_widgets/page_outer_frame/widget_view.dart'
    as page_outer_frame_view;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;

// [페이지 화면 위젯 작성 파일]
// 페이지 화면 구현을 담당합니다.
// 로직 처리는 pageBusiness 객체에 위임하세요.

//------------------------------------------------------------------------------
// (페이지 UI 위젯)
// !!!세부 화면 정의!!!
class PageView extends StatelessWidget {
  const PageView({super.key});

  @override
  Widget build(BuildContext context) {
    // pageBusiness 객체
    page_business.PageBusiness pageBusiness =
        BlocProvider.of<gc_template_classes.BlocPageInfo>(context)
            .state
            .pageBusiness;

    return page_outer_frame_view.WidgetView(
      pageTitle: "Gesture 위젯 영역 중첩 테스트",
      business: pageBusiness.pageViewModel.pageOutFrameBusiness,
      floatingActionButton: null,
      child: Stack(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                pageBusiness.onTapRed();
              },
              child: Container(
                width: 400,
                height: 200,
                color: Colors.redAccent,
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                pageBusiness.onTapBlueOuter();
              },
              child: GestureDetector(
                onTap: () {
                  pageBusiness.onTapBlueInner();
                },
                child: Container(
                  width: 200,
                  height: 100,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
