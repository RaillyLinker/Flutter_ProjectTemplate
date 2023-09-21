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
              'Page And Router Test Sample',
              style: TextStyle(color: Colors.white),
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
                Widget listTile;
                if (pageBusiness.pageViewModel.filteredSampleList[index]
                        .sampleItemEnum ==
                    page_business.SampleItemEnum.inputAndOutputPushTest) {
                  listTile = Column(
                    children: [
                      ListTile(
                        title: Text(pageBusiness.pageViewModel
                            .filteredSampleList[index].sampleItemTitle),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(pageBusiness
                                .pageViewModel
                                .filteredSampleList[index]
                                .sampleItemDescription),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Expanded(
                                    child: Text("( Input Page Parameter : ")),
                                Expanded(child: BlocBuilder<
                                    page_business.BlocInputParamTextField,
                                    bool>(
                                  builder: (c, s) {
                                    return TextField(
                                      onChanged: (value) {
                                        pageBusiness
                                            .inputParamTextFieldOnChanged(
                                                value);
                                      },
                                      style: const TextStyle(fontSize: 12),
                                      controller: pageBusiness.pageViewModel
                                          .inputParamTextFieldController,
                                      decoration: InputDecoration(
                                          errorText: pageBusiness.pageViewModel
                                              .inputParamTextFieldErrorMsg,
                                          isDense: true,
                                          labelText: "PageInputVo.inputValue",
                                          hintText: "Page Input Parameter",
                                          border: const OutlineInputBorder()),
                                    );
                                  },
                                )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(child: BlocBuilder<
                                    page_business.BlocInputParamTextField,
                                    bool>(
                                  builder: (c, s) {
                                    return TextField(
                                      style: const TextStyle(fontSize: 12),
                                      controller: pageBusiness.pageViewModel
                                          .inputParamOptTextFieldController,
                                      decoration: const InputDecoration(
                                          isDense: true,
                                          labelText:
                                              "PageInputVo.inputValueOpt",
                                          hintText:
                                              "Page Input Parameter (Nullable)",
                                          border: OutlineInputBorder()),
                                    );
                                  },
                                )),
                                const Text(" )"),
                              ],
                            ),
                          ],
                        ),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 0.1,
                      ),
                    ],
                  );
                } else {
                  listTile = Column(
                    children: [
                      ListTile(
                        title: Text(pageBusiness.pageViewModel
                            .filteredSampleList[index].sampleItemTitle),
                        subtitle: Text(pageBusiness.pageViewModel
                            .filteredSampleList[index].sampleItemDescription),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 0.1,
                      ),
                    ],
                  );
                }

                return GestureDetector(
                  onTap: () {
                    pageBusiness.onRouteListItemClickAsync(index);
                  },
                  child: listTile,
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
