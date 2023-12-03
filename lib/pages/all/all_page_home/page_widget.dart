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
const pageName = "all_page_home";

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
        itemTitle: "페이지 / 라우터 샘플 리스트",
        itemDescription: "페이지 이동, 파라미터 전달 등의 샘플 리스트",
        onItemClicked: () {
          business.onPageRouterSampleListItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "다이얼로그 샘플 리스트",
        itemDescription: "다이얼로그 호출 샘플 리스트",
        onItemClicked: () {
          business.onDialogSampleListItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "다이얼로그 애니메이션 샘플 리스트",
        itemDescription: "다이얼로그 호출 애니메이션 샘플 리스트",
        onItemClicked: () {
          business.onDialogAnimationSampleListItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "네트워크 요청 샘플 리스트",
        itemDescription: "네트워크 요청 및 응답 처리 샘플 리스트",
        onItemClicked: () {
          business.onNetworkRequestSampleListItemClicked();
        }));

    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      itemList.add(iw_sample_list.SampleItem(
          itemTitle: "모바일 권한 샘플 리스트",
          itemDescription: "모바일 디바이스 권한 처리 샘플 리스트",
          onItemClicked: () {
            business.onMobilePermissionSampleListItemClicked();
          }));
    }

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "계정 샘플",
        itemDescription: "계정 관련 기능 샘플",
        onItemClicked: () {
          business.onAuthSampleItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "기타 샘플 리스트",
        itemDescription: "기타 테스트 샘플을 모아둔 리스트",
        onItemClicked: () {
          business.onEtcSampleListItemClicked();
        }));

    return gw_page_outer_frame.SlWidget(
      business: business.pageOutFrameBusiness,
      inputVo: gw_page_outer_frame.InputVo(
        pageTitle: "홈",
        child: iw_sample_list.SfWidget(
          globalKey: business.iwSampleListStateGk,
          inputVo: iw_sample_list.InputVo(itemList: itemList),
        ),
      ),
    );
  }
}