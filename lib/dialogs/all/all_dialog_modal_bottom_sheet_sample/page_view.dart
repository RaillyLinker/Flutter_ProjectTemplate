// (external)
import 'package:flutter/material.dart';
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

    return SingleChildScrollView(
      child: Container(
        height: 300,
        decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(child: Container()),
                IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    pageBusiness.closeDialog();
                  },
                ),
              ],
            ),
            const Expanded(
                child: Text(
              "테스트 다이얼로그",
              style: TextStyle(fontFamily: "MaruBuri"),
            )),
          ],
        ),
      ),
    );
  }
}
