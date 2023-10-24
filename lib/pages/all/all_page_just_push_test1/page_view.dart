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

    return gw_page_out_frames.PageOutFrame(
      "페이지 Push 테스트1",
      Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    pageBusiness.countPlus1();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black)),
                    ),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: BlocBuilder<page_business.BlocSampleNumber, bool>(
                      builder: (c, s) {
                        return Text(
                            "${pageBusiness.pageViewModel.sampleNumber}",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: "MaruBuri"));
                      },
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    pageBusiness.goToJustPushTest1Page();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    "페이지 Push 테스트1 으로 이동",
                    style:
                        TextStyle(color: Colors.white, fontFamily: "MaruBuri"),
                  )),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    pageBusiness.goToJustPushTest2Page();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    "페이지 Push 테스트2 로 이동",
                    style:
                        TextStyle(color: Colors.white, fontFamily: "MaruBuri"),
                  )),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
