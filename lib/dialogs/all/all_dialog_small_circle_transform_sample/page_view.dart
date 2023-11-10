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

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: BlocBuilder<page_business.BlocOuterContainerForComplete, bool>(
          builder: (c, s) {
            page_business.BlocOuterContainerForComplete
                blocOuterContainerForComplete =
                BlocProvider.of<page_business.BlocOuterContainerForComplete>(c);

            return AnimatedContainer(
              width: blocOuterContainerForComplete.isComplete ? 64 : 300,
              height: blocOuterContainerForComplete.isComplete ? 64 : 220,
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 500),
              child: blocOuterContainerForComplete.isComplete
                  ? CompleteCircleContainer()
                  : Container(
                      height: 280,
                      width: 300,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: const Center(
                        child: Text("잠시 후 종료됩니다."),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}

// 작업 완료시 변경될 작은 원 위젯
class CompleteCircleContainer extends Container {
  CompleteCircleContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.5),
                spreadRadius: 5,
                blurRadius: 7)
          ]),
      child: const Center(child: Text('성공')),
    );
  }
}
