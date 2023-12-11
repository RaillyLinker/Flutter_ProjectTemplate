// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_classes/todo_gc_delete.dart'
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

    return gw_slw_page_outer_frame.SlwPageOuterFrame(
      business: pageBusiness.pageViewModel.pageOutFrameBusiness,
      pageTitle: "Url Launcher 샘플",
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: const Row(
                    children: [
                      Text("입력 : ",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "MaruBuri",
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                        width: 300,
                        height: 45,
                        child:
                            BlocBuilder<page_business.BlocUrlTextField, bool>(
                                builder: (c, s) {
                          return TextField(
                              onChanged: (value) {
                                pageBusiness.urlTextFieldOnChanged(value);
                              },
                              controller: pageBusiness
                                  .pageViewModel.urlTextEditController,
                              decoration: InputDecoration(
                                  errorText: pageBusiness
                                      .pageViewModel.urlTextFieldErrorMsg,
                                  labelText: "Url",
                                  hintText: "https://www.test-url.com",
                                  border: const OutlineInputBorder()));
                        }))),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Center(
                        child: ElevatedButton(
                            onPressed: () {
                              pageBusiness.launchUrlInAppAsync();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: const Text("앱 자체에서 열기",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "MaruBuri"))))),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        pageBusiness.launchUrlInBrowserAsync();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child: const Text(
                        "브라우저 앱에서 열기",
                        style: TextStyle(
                            color: Colors.white, fontFamily: "MaruBuri"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
