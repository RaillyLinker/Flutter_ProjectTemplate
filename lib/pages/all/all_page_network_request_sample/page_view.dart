// (external)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;

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
      backgroundColor: const Color(0xFFFFFFFF),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: false,
            title: const Text(
              'Network Request Sample',
              style: TextStyle(color: Colors.white, fontFamily: "MaruBuri"),
            ),
            backgroundColor: Colors.blue,
            iconTheme: const IconThemeData(
              color: Colors.white, //change your color here
            ),
            bottom: AppBar(
              automaticallyImplyLeading: false,
              title: Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: Center(
                  child: TextField(
                    onChanged: (value) {
                      pageBusiness.filteringSamplePageList(value);
                    },
                    controller: pageBusiness
                        .pageViewModel.sampleSearchBarTextEditController,
                    decoration: const InputDecoration(
                        hintText: 'Search', prefixIcon: Icon(Icons.search)),
                  ),
                ),
              ),
            ),
          ),
          // Other Sliver Widgets
          BlocBuilder<page_business.BlocSampleList, bool>(builder: (c, s) {
            return SliverList.builder(
              itemCount: pageBusiness.pageViewModel.filteredSampleList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      pageBusiness.onRouteListItemClick(index);
                    },
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            pageBusiness.pageViewModel.filteredSampleList[index]
                                .sampleItemTitle,
                            style: const TextStyle(fontFamily: "MaruBuri"),
                          ),
                          subtitle: Text(
                            pageBusiness.pageViewModel.filteredSampleList[index]
                                .sampleItemDescription,
                            style: const TextStyle(fontFamily: "MaruBuri"),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                        const Divider(
                          color: Colors.grey,
                          height: 0.1,
                        ),
                      ],
                    ));
              },
            );
          }),
        ],
      ),
    );
  }
}
