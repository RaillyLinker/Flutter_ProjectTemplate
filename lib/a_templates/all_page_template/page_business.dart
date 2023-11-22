// (external)
import 'package:flutter/cupertino.dart';

// (inner Folder)
import 'page_view.dart' as page_view;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// -----------------------------------------------------------------------------
class PageBusiness extends State<page_view.PageView> {
  PageBusiness();

  // [오버라이드]
  @override
  Widget build(BuildContext context) {
    return widget.viewWidgetBuild(context: context);
  }

  // [public 변수]
  // !!!public 변수를 선언 하세요!!!
  // (페이지 pop 가능 여부 변수)
  bool pageCanPop = true;

  // (pageOutFrameBusiness)
  gw_page_out_frames.PageOutFrameBusiness pageOutFrameBusiness =
  gw_page_out_frames.PageOutFrameBusiness();

  // [private 변수]
  // !!!private 변수를 선언 하세요!!!

  // [public 함수]
  // !!!public 함수를 작성 하세요!!!
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }

  // [private 함수]
  // !!!private 함수를 작성하세요!!!
}