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
      pageTitle: "페이지 Grid 샘플",
      business: pageBusiness.pageViewModel.pageOutFrameBusiness,
      floatingActionButton: null,
      child: Center(
        child: Container(
          padding:
              const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
          child: GridView.builder(
            itemCount: 100, // 아이템 개수
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300, // item 최대 width 크기
                mainAxisSpacing: 2.0, // 행 간 여백
                crossAxisSpacing: 2.0, // 열 간 여백
                childAspectRatio: 1.5 // width / height
                ),
            itemBuilder: (BuildContext context, int index) {
              // 아이템 타일
              return Container(
                color: Colors.grey,
                child: ListTile(
                  title: Text('Item $index'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
