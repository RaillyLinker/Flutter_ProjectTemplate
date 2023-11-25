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
        pageTitle: "페이지 입/출력 테스트",
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: pageBusiness.pageViewModel.pageOutputFormKey,
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      key: pageBusiness.pageViewModel.pageOutputTextFieldKey,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: '페이지 출력 값',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          filled: true,
                          fillColor: Colors.grey[100],
                          isDense: true,
                          hintText: "페이지 출력 값 입력",
                          border: const OutlineInputBorder()),
                      controller: pageBusiness
                          .pageViewModel.pageOutputTextFieldController,
                      focusNode:
                          pageBusiness.pageViewModel.pageOutputTextFieldFocus,
                      validator: (value) {
                        // 검사 : return 으로 반환하는 에러 메세지가 null 이 아니라면 에러로 처리
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        // 입력창 포커스 상태에서 엔터
                        if (pageBusiness
                            .pageViewModel.pageOutputFormKey.currentState!
                            .validate()) {
                          pageBusiness.onPressedReturnBtn();
                        } else {
                          FocusScope.of(context).requestFocus(pageBusiness
                              .pageViewModel.pageOutputTextFieldFocus);
                        }
                      },
                    ),
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
                        "출력 값 반환",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontFamily: "MaruBuri"),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
