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

    return RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (v) {
          if (v.logicalKey == LogicalKeyboardKey.enter) {
            pageBusiness.closeDialog();
          }
        },
        autofocus: true,
        child: Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: SingleChildScrollView(
                child: SizedBox(
                    width: 280,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Container(
                        height: 55,
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 17, right: 17),
                          child: Center(
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              pageBusiness.pageInputVo.dialogTitle,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontFamily: "MaruBuri",
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 120,
                        color: Colors.white,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 17, right: 17),
                            child: SingleChildScrollView(
                              child: Text(
                                pageBusiness.pageInputVo.dialogContent,
                                style: const TextStyle(
                                    fontFamily: "MaruBuri",
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 0.1,
                      ),
                      Container(
                          height: 55,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16))),
                          child: Center(
                              child: Container(
                                  constraints: const BoxConstraints(
                                      minWidth: 100, maxWidth: 200),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        pageBusiness.onCheckBtnClicked();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                      ),
                                      child: Text(
                                        pageBusiness.pageInputVo.checkBtnTitle,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "MaruBuri"),
                                      )))))
                    ])))));
  }
}
