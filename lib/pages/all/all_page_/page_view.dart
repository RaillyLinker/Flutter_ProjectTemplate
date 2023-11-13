// (external)
import 'package:flutter/material.dart';

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
// !!!세부 화면 정의!!!
class PageView extends StatelessWidget {
  const PageView(this._pageBusiness, {super.key});

  // 페이지 비즈니스 객체
  final page_business.PageBusiness _pageBusiness;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                child: SampleNumber(
                  _pageBusiness.pageViewModel.sampleNumberViewModel,
                  key: _pageBusiness.sampleNumberStateGk,
                ),
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
                style: TextStyle(color: Colors.white, fontFamily: "MaruBuri"),
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
                style: TextStyle(color: Colors.white, fontFamily: "MaruBuri"),
              )),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}

class SampleNumber extends StatefulWidget {
  const SampleNumber(this._sampleNumberViewModel, {super.key});

  final SampleNumberViewModel _sampleNumberViewModel;

  @override
  // ignore: no_logic_in_create_state
  SampleNumberState createState() => SampleNumberState();
}

class SampleNumberViewModel {
  SampleNumberViewModel(this.sampleInt);

  int sampleInt;
}

class SampleNumberState extends State<SampleNumber> {
  // Stateful Widget 화면 갱신
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Text("${widget._sampleNumberViewModel.sampleInt}",
        style: const TextStyle(
            fontSize: 20, color: Colors.black, fontFamily: "MaruBuri"));
  }
}
