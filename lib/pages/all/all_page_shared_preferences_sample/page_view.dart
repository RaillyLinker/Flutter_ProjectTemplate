// (external)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_widgets/gw_page_outer_frame/widget_view.dart'
    as gw_page_outer_frame_view;
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

    return gw_page_outer_frame_view.WidgetView(
      business: pageBusiness.pageViewModel.pageOutFrameBusiness,
      inputVo: gw_page_outer_frame_view.InputVo(

        pageTitle: "SharedPreferences 샘플",
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                        child: Text("키 : ",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "MaruBuri",
                                fontWeight: FontWeight.bold))),
                    Expanded(
                        child: Text("\"${pageBusiness.pageViewModel.spwKey}\"",
                            style: const TextStyle(
                                color: Colors.black, fontFamily: "MaruBuri")))
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: const Row(
                    children: [
                      Text("값 : ",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "MaruBuri",
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      const Expanded(
                          child: Text("    {\"sampleInt\" : ",
                              style: TextStyle(
                                  color: Colors.black, fontFamily: "MaruBuri"))),
                      BlocBuilder<page_business.BlocSampleInt, bool>(
                          builder: (c, s) {
                            return Expanded(
                                child: Text(
                                    "${pageBusiness.pageViewModel.sampleInt},",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "MaruBuri")));
                          }),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      const Expanded(
                          child: Text("    \"sampleString\" : ",
                              style: TextStyle(
                                  color: Colors.black, fontFamily: "MaruBuri"))),
                      BlocBuilder<page_business.BlocSampleString, bool>(
                          builder: (c, s) {
                            return Expanded(
                                child: Text(
                                    "${pageBusiness.pageViewModel.sampleString}}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "MaruBuri")));
                          }),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: const Row(
                    children: [
                      Text("입력값 : ",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "MaruBuri",
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: BlocBuilder<page_business.BlocSampleIntTextField,
                            bool>(
                          builder: (c, s) {
                            return TextField(
                              onChanged: (value) {
                                pageBusiness.sampleIntTextFieldOnChanged(value);
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: pageBusiness
                                  .pageViewModel.sampleIntTextEditController,
                              decoration: InputDecoration(
                                  errorText: pageBusiness
                                      .pageViewModel.sampleIntTextFieldErrorMsg,
                                  labelText: "정수값 입력",
                                  hintText: "정수값을 입력하세요.",
                                  border: const OutlineInputBorder()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: BlocBuilder<
                            page_business.BlocSampleStringTextField, bool>(
                          builder: (c, s) {
                            return TextField(
                              onChanged: (value) {
                                pageBusiness
                                    .sampleStringTextFieldOnChanged(value);
                              },
                              controller: pageBusiness
                                  .pageViewModel.sampleStringTextEditController,
                              decoration: InputDecoration(
                                  errorText: pageBusiness.pageViewModel
                                      .sampleStringTextFieldErrorMsg,
                                  labelText: "문자열 입력",
                                  hintText: "문자열을 입력하세요.",
                                  border: const OutlineInputBorder()),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        pageBusiness.spValueChangeBtnClick();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text(
                        "SharedPreferences 값 변경",
                        style: TextStyle(
                            color: Colors.white, fontFamily: "MaruBuri"),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        pageBusiness.spValueDeleteBtnClick();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text(
                        "SharedPreferences 값 삭제",
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
