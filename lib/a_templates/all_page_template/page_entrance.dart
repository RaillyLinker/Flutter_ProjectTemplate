// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_view.dart' as page_view;
import 'page_business.dart' as page_business;

// [페이지 진입 파일]
// todo : business 와 합치기

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!!
// 폴더명과 동일하게 작성하세요.
const pageName = "all_page_template";

// !!!페이지 호출/반납 애니메이션!!!
// 동적으로 변경이 가능합니다.
Widget Function(BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child)
    pageTransitionsBuilder = (context, animation, secondaryAnimation, child) {
  return FadeTransition(opacity: animation, child: child);
};

// (페이지 호출시 필요한 입력값 데이터 형태)
// !!!페이지 입력 데이터 정의!!!
class PageInputVo {}

// (이전 페이지로 전달할 결과 데이터 형태)
// !!!페이지 반환 데이터 정의!!!
class PageOutputVo {}

//------------------------------------------------------------------------------
// 아래는 수정할 필요가 없는 코드입니다.
class PageEntrance extends StatefulWidget {
  PageEntrance({super.key, required GoRouterState goRouterState}) {
    _pageInputVo = _state._pageBusiness.getInputVo(goRouterState);
  }

  // [오버라이드]
  @override
  // ignore: no_logic_in_create_state
  PageEntranceState createState() => _state;

  // [private 변수]
  // (위젯 state)
  final PageEntranceState _state = PageEntranceState();

  // (페이지 입력 데이터)
  late final PageInputVo _pageInputVo;
}

class PageEntranceState extends State<PageEntrance>
    with WidgetsBindingObserver {
  PageEntranceState();

  // [오버라이드]
  // (페이지 위젯 initState)
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _pageBusiness.initPageState();
  }

  // (페이지 위젯 dispose)
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageBusiness.pageDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _pageBusiness.pageCanPop,
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {
          await _pageBusiness.onPageFocusGained();
        },
        onFocusLost: () async {
          await _pageBusiness.onPageFocusLost();
        },
        onVisibilityGained: () async {
          await _pageBusiness.onPageVisibilityGained();
        },
        onVisibilityLost: () async {
          await _pageBusiness.onPageVisibilityLost();
        },
        onForegroundGained: () async {
          await _pageBusiness.onPageForegroundGained();
        },
        onForegroundLost: () async {
          await _pageBusiness.onPageForegroundLost();
        },

        // (페이지 UI 위젯)
        child: page_view.PageView(
          business: _pageBusiness,
          pageInputVo: widget._pageInputVo,
        ),
      ),
    );
  }

  // [private 변수]
  // (페이지 Business)
  final page_business.PageBusiness _pageBusiness = page_business.PageBusiness();
}
