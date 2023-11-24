// (external)
import 'dart:io';

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
      pageTitle: "모바일 권한 샘플",
      business: pageBusiness.pageViewModel.pageOutFrameBusiness,
      floatingActionButton: null,
      child: BlocBuilder<page_business.BlocSampleList, bool>(
        builder: (c, s) {
          return ListView.builder(
            itemCount: pageBusiness.pageViewModel.allSampleList.length,
            itemBuilder: (context, index) {
              List<Widget> listTiles = [];
              listTiles.add(GestureDetector(
                onTap: () {
                  pageBusiness.onRouteListItemClickAsync(index);
                },
                child: ListTile(
                  mouseCursor: SystemMouseCursors.click,
                  title: Text(
                    pageBusiness
                        .pageViewModel.allSampleList[index].sampleItemTitle,
                    style: const TextStyle(fontFamily: "MaruBuri"),
                  ),
                  subtitle: Text(
                    pageBusiness.pageViewModel.allSampleList[index]
                        .sampleItemDescription,
                    style: const TextStyle(fontFamily: "MaruBuri"),
                  ),
                  trailing: Switch(
                    value: pageBusiness
                        .pageViewModel.allSampleList[index].isChecked,
                    onChanged: (value) {
                      pageBusiness.onRouteListItemClickAsync(index);
                    },
                    activeColor: Colors.blueAccent,
                  ),
                ),
              ));

              if (pageBusiness
                      .pageViewModel.allSampleList[index].sampleItemEnum ==
                  page_business.SampleItemEnum.sensors) {
                if (pageBusiness.pageViewModel.allSampleList[index].isChecked &&
                    Platform.isAndroid) {
                  listTiles.add(
                    GestureDetector(
                      onTap: () {
                        pageBusiness.onSensorsAlwaysItemClickAsync();
                      },
                      child: Container(
                        color: Colors.blue[100],
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            mouseCursor: SystemMouseCursors.click,
                            title: const Text(
                              "sensorsAlways 권한",
                              style: TextStyle(fontFamily: "MaruBuri"),
                            ),
                            subtitle: const Text(
                              "Android : Background 에서도 Body Sensors 접근",
                              style: TextStyle(fontFamily: "MaruBuri"),
                            ),
                            trailing: Switch(
                              value: pageBusiness.pageViewModel.sensorsAlways,
                              onChanged: (value) {
                                pageBusiness.onSensorsAlwaysItemClickAsync();
                              },
                              activeColor: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              } else if (pageBusiness
                      .pageViewModel.allSampleList[index].sampleItemEnum ==
                  page_business.SampleItemEnum.locationWhenInUse) {
                if (pageBusiness.pageViewModel.allSampleList[index].isChecked &&
                    Platform.isAndroid) {
                  listTiles.add(
                    GestureDetector(
                      onTap: () {
                        pageBusiness.onLocationAlwaysItemClickAsync();
                      },
                      child: Container(
                        color: Colors.blue[100],
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            mouseCursor: SystemMouseCursors.click,
                            title: const Text(
                              "locationAlways 권한",
                              style: TextStyle(fontFamily: "MaruBuri"),
                            ),
                            subtitle: const Text(
                              "Android : Background 에서도 location 정보 접근",
                              style: TextStyle(fontFamily: "MaruBuri"),
                            ),
                            trailing: Switch(
                              value: pageBusiness
                                  .pageViewModel.androidLocationAlways,
                              onChanged: (value) {
                                pageBusiness.onLocationAlwaysItemClickAsync();
                              },
                              activeColor: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              }

              listTiles.add(
                const Divider(
                  color: Colors.grey,
                  height: 0.1,
                ),
              );

              return Column(
                children: listTiles,
              );
            },
          );
        },
      ),
    );
  }
}
