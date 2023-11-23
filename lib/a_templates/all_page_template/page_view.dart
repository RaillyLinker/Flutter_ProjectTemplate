// (external)
import 'package:flutter/cupertino.dart';

// (inner Folder)
import 'page_entrance.dart' as page_entrance;
import 'page_business.dart' as page_business;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
class PageView extends StatefulWidget {
  PageView(
      {super.key,
      required page_business.PageBusiness business,
      required this.pageInputVo})
      : _business = business {
    _business.view = this;
  }

  // [오버라이드]
  @override
  // ignore: no_logic_in_create_state
  page_business.PageBusiness createState() => _business;

  // [public 변수]
  // (페이지 입력 데이터)
  final page_entrance.PageInputVo pageInputVo;

  // [private 변수]
  // (위젯 비즈니스)
  final page_business.PageBusiness _business;

  // [public 함수]

  // [private 함수]

  // [뷰 위젯]
  // !!!뷰 위젯 반환 콜백 작성 하기!!!
  Widget viewWidgetBuild({required BuildContext context}) {
    return gw_page_out_frames.PageOutFrame(
      pageTitle: "페이지 템플릿",
      business: _business.pageOutFrameBusiness,
      floatingActionButton: null,
      child: const Center(
        child: Text(
          "페이지 템플릿입니다.",
          style: TextStyle(fontFamily: "MaruBuri"),
        ),
      ),
    );
  }
}
