// (external)
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
const pageName = "all_page_network_request_sample_list";

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
        itemTitle: "Get 메소드 요청 샘플",
        itemDescription: "Get 요청 테스트 (Query Parameter)",
        onItemClicked: () {
          business.onGetMethodRequestSampleItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "Post 메소드 요청 샘플 1 (application/json)",
        itemDescription: "Post 요청 테스트 (Request Body)",
        onItemClicked: () {
          business.onPostMethodRequestSample1ItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "Post 메소드 요청 샘플 2 (x-www-form-urlencoded)",
        itemDescription: "Post 메소드 요청 테스트 (x-www-form-urlencoded)",
        onItemClicked: () {
          business.onPostMethodRequestSample2ItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "Post 메소드 요청 샘플 3 (multipart/form-data)",
        itemDescription: "Post 메소드 요청 테스트 (multipart/form-data)",
        onItemClicked: () {
          business.onPostMethodRequestSample3ItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "Post 메소드 요청 샘플 4 (multipart/form-data - JsonString)",
        itemDescription:
            "Post 메소드 요청 JsonString Parameter (multipart/form-data)",
        onItemClicked: () {
          business.onPostMethodRequestSample4ItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "Post 메소드 에러 발생 샘플",
        itemDescription: "에러 발생시의 신호를 응답하는 Post 메소드 샘플",
        onItemClicked: () {
          business.onPostMethodRequestErrorSampleItemClickedAsync();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "Get 메소드 String 응답 샘플",
        itemDescription: "String 을 반환하는 Get 메소드 샘플",
        onItemClicked: () {
          business.onStringReturnGetMethodRequestSampleItemClickedAsync();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "Get 메소드 Html 응답 샘플",
        itemDescription: "HTML String 을 반환하는 Get 메소드 샘플",
        onItemClicked: () {
          business.onHtmlReturnGetMethodRequestSampleItemClickedAsync();
        }));

    return gw_page_outer_frame.SlWidget(
      business: business.pageOutFrameBusiness,
      inputVo: gw_page_outer_frame.InputVo(
        pageTitle: "네트워크 요청 샘플 리스트",
        child: iw_sample_list.SfWidget(
          globalKey: business.iwSampleListStateGk,
          inputVo: iw_sample_list.InputVo(itemList: itemList),
        ),
      ),
    );
  }
}
