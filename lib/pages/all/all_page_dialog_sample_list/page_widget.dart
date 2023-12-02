// (external)
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget_business.dart' as page_widget_business;
import 'inner_widgets/iw_sample_list/sf_widget.dart' as iw_sample_list;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget.dart'
    as gw_page_outer_frame;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!!
// 폴더명과 동일하게 작성하세요.
const pageName = "all_page_dialog_sample_list";

// !!!페이지 호출/반납 애니메이션!!!
// 동적으로 변경이 가능합니다.
Widget Function(BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child)
    pageTransitionsBuilder = (context, animation, secondaryAnimation, child) {
  return FadeTransition(opacity: animation, child: child);
};

// (입력 데이터)
class InputVo {
  // !!!위젯 입력값 선언!!!
  const InputVo();
}

// (결과 데이터)
class OutputVo {
  // !!!위젯 출력값 선언!!!
  const OutputVo();
}

//------------------------------------------------------------------------------
class PageWidget extends StatefulWidget {
  const PageWidget({super.key, required this.goRouterState});

  final GoRouterState goRouterState;

  @override
  PageWidgetState createState() => PageWidgetState();
}

class PageWidgetState extends State<PageWidget> with WidgetsBindingObserver {
  // [콜백 함수]
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    business = page_widget_business.PageWidgetBusiness();
    business.onCheckPageInputVo(goRouterState: widget.goRouterState);
    business.refreshUi = refreshUi;
    business.context = context;
    business.initState();
  }

  @override
  void dispose() {
    business.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    business.refreshUi = refreshUi;
    business.context = context;
    return PopScope(
      canPop: business.canPop,
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {
          await business.onFocusGained();
        },
        onFocusLost: () async {
          await business.onFocusLost();
        },
        onVisibilityGained: () async {
          await business.onVisibilityGained();
        },
        onVisibilityLost: () async {
          await business.onVisibilityLost();
        },
        onForegroundGained: () async {
          await business.onForegroundGained();
        },
        onForegroundLost: () async {
          await business.onForegroundLost();
        },
        child: WidgetUi.viewWidgetBuild(context: context, business: business),
      ),
    );
  }

  // [public 변수]
  late page_widget_business.PageWidgetBusiness business;

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }
}

class WidgetUi {
  // [뷰 위젯]
  static Widget viewWidgetBuild(
      {required BuildContext context,
      required page_widget_business.PageWidgetBusiness business}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!
    final List<iw_sample_list.SampleItem> itemList = [];
    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "다이얼로그 템플릿",
        itemDescription: "템플릿 다이얼로그를 호출합니다.",
        onItemClicked: () {
          business.onDialogTemplateItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "확인 다이얼로그",
        itemDescription: "버튼이 하나인 확인 다이얼로그를 호출합니다.",
        onItemClicked: () {
          business.onInfoDialogItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "예/아니오 다이얼로그",
        itemDescription: "버튼이 두개인 다이얼로그를 호출합니다.",
        onItemClicked: () {
          business.onYesOrNoDialogItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "로딩 스피너 다이얼로그",
        itemDescription: "로딩 스피너 다이얼로그를 호출하고 2초 후 종료합니다.",
        onItemClicked: () {
          business.onLoadingSpinnerDialogItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "아래에 붙은 다이얼로그",
        itemDescription: "아래에서 올라오는 다이얼로그를 호출합니다.",
        onItemClicked: () {
          business.onModalBottomDialogItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "다이얼로그 속 다이얼로그",
        itemDescription: "다이얼로그에서 다이얼로그를 호출합니다.",
        onItemClicked: () {
          business.onDialogInDialogItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "다이얼로그 외부 색 설정",
        itemDescription: "다이얼로그 영역 바깥의 색상을 지정합니다.",
        onItemClicked: () {
          business.onDialogOutsideColorItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "컨텍스트 메뉴 샘플",
        itemDescription: "다이얼로그에서 컨텍스트 메뉴를 사용하는 샘플",
        onItemClicked: () {
          business.onContextMenuDialogSampleItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "다이얼로그 생명주기 샘플",
        itemDescription: "다이얼로그에서의 생명주기를 확인하는 샘플",
        onItemClicked: () {
          business.onDialogLifecycleSampleItemClicked();
        }));

    return gw_page_outer_frame.SlWidget(
      business: business.pageOutFrameBusiness,
      inputVo: gw_page_outer_frame.InputVo(
        pageTitle: "다이얼로그 샘플 리스트",
        child: iw_sample_list.SfWidget(
          globalKey: business.iwSampleListStateGk,
          inputVo: iw_sample_list.InputVo(itemList: itemList),
        ),
      ),
    );
  }
}
