// (external)
import 'package:flutter/material.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;

// [페이지 화면 위젯 작성 파일]
// 페이지 화면 구현을 담당합니다. (Widget 과 Business 간의 결합을 담당)
// 로직 처리는 pageBusiness 객체에 위임하세요.

//------------------------------------------------------------------------------
// (페이지 UI 위젯)
// !!!세부 화면 정의!!!
class PageView extends StatelessWidget {
  const PageView(this._pageBusiness, {super.key});

  // 페이지 비즈니스 객체
  final page_business.PageBusiness _pageBusiness;

  @override
  Widget build(BuildContext context) {
    return gw_page_out_frames.PageOutFrame(
      _pageBusiness.pageViewModel.pageOutFrameViewModel,
      Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    _pageBusiness.countPlus1();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black)),
                    ),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: SampleNumberText(
                        _pageBusiness.pageViewModel.sampleWidgetState),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    _pageBusiness.goToJustPushTest1Page();
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
                    _pageBusiness.goToJustPushTest2Page();
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

// ex :
// (Stateless 위젯 템플릿)
// class StatelessWidgetTemplate extends StatelessWidget {
//   const StatelessWidgetTemplate(this.viewModel, {required super.key});
//
//   // 위젯 뷰모델
//   final StatelessWidgetTemplateViewModel viewModel;
//
//   //!!!주입 받을 하위 위젯 선언 하기!!!
//
//   // !!!하위 위젯 작성하기. (viewModel 에서 데이터를 가져와 사용)!!!
//   @override
//   Widget build(BuildContext context) {
//     return Text(viewModel.sampleText);
//   }
// }
//
// class StatelessWidgetTemplateViewModel {
//   StatelessWidgetTemplateViewModel(this.sampleText);
//
//   // !!!위젯 상태 변수 선언하기!!!
//   final String sampleText;
// }

// (Stateful 위젯 템플릿)
// class StatefulWidgetTemplate extends StatefulWidget {
//   const StatefulWidgetTemplate(this.viewModel, {required super.key});
//
//   // 위젯 뷰모델
//   final StatefulWidgetTemplateViewModel viewModel;
//
//   //!!!주입 받을 하위 위젯 선언 하기!!!
//
//   @override
//   StatefulWidgetTemplateState createState() => StatefulWidgetTemplateState();
// }
//
// class StatefulWidgetTemplateViewModel {
//   StatefulWidgetTemplateViewModel(this.sampleInt);
//
//   // !!!위젯 상태 변수 선언하기!!!
//   int sampleInt;
// }
//
// class StatefulWidgetTemplateState extends State<StatefulWidgetTemplate> {
//   // Stateful Widget 화면 갱신
//   void refresh() {
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // !!!하위 위젯 작성하기. (widget.viewModel 에서 데이터를 가져와 사용)!!!
//     return Text(widget.viewModel.sampleInt.toString());
//   }
// }

class SampleNumberText extends StatefulWidget {
  const SampleNumberText(this.state, {super.key});

  // 위젯 뷰모델
  final SampleNumberTextState state;

  //!!!주입 받을 하위 위젯 선언 하기!!!

  @override
  SampleNumberTextState createState() => state;
}

class SampleNumberTextState extends State<SampleNumberText> {
  // Stateful Widget 화면 갱신
  void refresh() {
    setState(() {});
  }

  // !!!위젯 상태 변수 선언하기!!!
  int sampleInt = 0;

  @override
  Widget build(BuildContext context) {
    // !!!하위 위젯 작성하기. (widget.viewModel 에서 데이터를 가져와 사용)!!!
    return Text("$sampleInt",
        style: const TextStyle(
            fontSize: 20, color: Colors.black, fontFamily: "MaruBuri"));
  }
}
