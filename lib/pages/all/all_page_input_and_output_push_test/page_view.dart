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
      appBar: AppBar(
        title: const Text(
          'Page Input And Output Sample',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 200,
                margin: const EdgeInsets.only(top: 20),
                child:
                    BlocBuilder<page_business.BlocReturnValueTextField, bool>(
                  builder: (c, s) {
                    return TextField(
                      onChanged: (value) {
                        pageBusiness.returnValueTextFieldOnChanged(value);
                      },
                      controller: pageBusiness
                          .pageViewModel.returnValueTextFieldController,
                      decoration: InputDecoration(
                          errorText:
                              pageBusiness.pageViewModel.returnValueError,
                          contentPadding: const EdgeInsets.all(12),
                          isDense: true,
                          hintText: "Page Return Value",
                          border: const OutlineInputBorder()),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                    onPressed: () {
                      pageBusiness.onPressedReturnBtn();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(top: 8, bottom: 8),
                      child: const Text(
                        "Return Value",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
