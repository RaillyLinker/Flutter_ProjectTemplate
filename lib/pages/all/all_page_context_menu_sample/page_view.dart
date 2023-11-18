// (external)
import 'package:flutter/material.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;
import '../../../global_widgets/gw_custom_widgets.dart' as gw_custom_widgets;

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
      SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              gw_custom_widgets.ContextMenuRegion(
                _pageBusiness.pageViewModel.contextMenuRegionViewModel,
                Container(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 10, right: 10),
                  color: Colors.blue[100], // 옅은 파란색
                  child: const Text(
                    '우클릭 해보세요.',
                    style:
                        TextStyle(color: Colors.black, fontFamily: "MaruBuri"),
                  ),
                ),
                contextMenuRegionItemVoList: [
                  gw_custom_widgets.ContextMenuRegionItemVo(
                      const Text(
                        "토스트 테스트",
                        style: TextStyle(
                            color: Colors.black, fontFamily: "MaruBuri"),
                      ), () {
                    _pageBusiness.toastTestMenuBtn();
                  }),
                  gw_custom_widgets.ContextMenuRegionItemVo(
                      const Text(
                        "다이얼로그 테스트",
                        style: TextStyle(
                            color: Colors.black, fontFamily: "MaruBuri"),
                      ), () {
                    _pageBusiness.dialogTestMenuBtn();
                  }),
                ],
                key: _pageBusiness.pageViewModel.contextMenuRegionStateGk,
              ),
              const SizedBox(
                height: 100,
              ),
              gw_custom_widgets.ContextMenuRegion(
                _pageBusiness.pageViewModel.contextMenuRegionViewModel2,
                Container(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 10, right: 10),
                  color: Colors.blue[100], // 옅은 파란색
                  child: const Text(
                    '모바일에선 길게 누르세요.',
                    style:
                        TextStyle(color: Colors.black, fontFamily: "MaruBuri"),
                  ),
                ),
                contextMenuRegionItemVoList: [
                  gw_custom_widgets.ContextMenuRegionItemVo(
                      const Text(
                        "뒤로가기",
                        style: TextStyle(
                            color: Colors.black, fontFamily: "MaruBuri"),
                      ), () {
                    _pageBusiness.goBackBtn();
                  }),
                ],
                key: _pageBusiness.pageViewModel.contextMenuRegionStateGk2,
              ),
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
