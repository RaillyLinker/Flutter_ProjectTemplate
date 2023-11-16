// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;

// [페이지 화면 위젯 작성 파일]
// 페이지 화면 구현을 담당합니다. (Widget 과 Business 간의 결합을 담당)
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

    return gw_page_out_frames.PageOutFrame(
      pageBusiness.pageViewModel.pageOutFrameViewModel,
      "기본 BLoC 샘플",
      Center(
        child: BlocBuilder<page_business.BlocSample, bool>(builder: (c, s) {
          return Text(pageBusiness.pageViewModel.sampleNumber.toString(),
              style: const TextStyle(
                  fontFamily: "MaruBuri",
                  fontSize: 20,
                  fontWeight: FontWeight.bold));
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pageBusiness
              .changeSampleNumber(pageBusiness.pageViewModel.sampleNumber + 1);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
