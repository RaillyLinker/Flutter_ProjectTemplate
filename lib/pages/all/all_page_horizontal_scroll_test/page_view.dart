// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_widgets/gw_page_outer_frame/widget_view.dart'
    as gw_page_outer_frame_view;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;

// [페이지 화면 위젯 작성 파일]
// 페이지 화면 구현을 담당합니다. (Widget 과 Business 간의 결합을 담당)
// 로직 처리는 pageBusiness 객체에 위임하세요.

// 모바일 외에는 가로 스크롤에서 스크롤을 해도 아무 반응이 없습니다.
// 고로 main.dart 에서 MouseTouchScrollBehavior 를 설정하는 부분의 설정을 하여,
// 모바일 이외 환경에서 스크롤 드래그 상호작용이 가능하도록 설정해야합니다.

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

    return gw_page_outer_frame_view.WidgetView(
      pageTitle: "가로 스크롤 테스트",
      business: pageBusiness.pageViewModel.pageOutFrameBusiness,
      floatingActionButton: null,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 120,
              padding: const EdgeInsets.only(left: 10, bottom: 40),
              child: ListView.builder(
                  shrinkWrap: true, // 리스트뷰 크기 고정
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.blueAccent[100],
                      width: 120,
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  }),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.only(left: 10, bottom: 40),
              child: ListView.builder(
                  shrinkWrap: true, // 리스트뷰 크기 고정
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.blueAccent[100],
                      width: 120,
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  }),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.only(left: 10, bottom: 40),
              child: ListView.builder(
                  shrinkWrap: true, // 리스트뷰 크기 고정
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.blueAccent[100],
                      width: 120,
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  }),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.only(left: 10, bottom: 40),
              child: ListView.builder(
                  shrinkWrap: true, // 리스트뷰 크기 고정
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.blueAccent[100],
                      width: 120,
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  }),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.only(left: 10, bottom: 40),
              child: ListView.builder(
                  shrinkWrap: true, // 리스트뷰 크기 고정
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.blueAccent[100],
                      width: 120,
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  }),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.only(left: 10, bottom: 40),
              child: ListView.builder(
                  shrinkWrap: true, // 리스트뷰 크기 고정
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.blueAccent[100],
                      width: 120,
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  }),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.only(left: 10, bottom: 40),
              child: ListView.builder(
                  shrinkWrap: true, // 리스트뷰 크기 고정
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.blueAccent[100],
                      width: 120,
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  }),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.only(left: 10, bottom: 40),
              child: ListView.builder(
                  shrinkWrap: true, // 리스트뷰 크기 고정
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.blueAccent[100],
                      width: 120,
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  }),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.only(left: 10, bottom: 40),
              child: ListView.builder(
                  shrinkWrap: true, // 리스트뷰 크기 고정
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.blueAccent[100],
                      width: 120,
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  }),
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.only(left: 10, bottom: 40),
              child: ListView.builder(
                  shrinkWrap: true, // 리스트뷰 크기 고정
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.blueAccent[100],
                      width: 120,
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
