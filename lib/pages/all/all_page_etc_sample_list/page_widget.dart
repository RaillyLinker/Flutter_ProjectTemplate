// (external)
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
const pageName = "all_page_etc_sample_list";

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
        itemTitle: "가로 스크롤 테스트",
        itemDescription: "모바일 이외 환경에서 가로 스크롤 작동을 테스트 하기 위한 샘플",
        onItemClicked: () {
          business.onHorizontalScrollTestItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "SharedPreferences 샘플",
        itemDescription: "SharedPreferences 사용 샘플",
        onItemClicked: () {
          business.onSharedPreferencesSampleItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "Url Launcher 샘플",
        itemDescription: "Url Launcher 사용 샘플",
        onItemClicked: () {
          business.onUrlLauncherSampleItemClicked();
        }));

    if (!kIsWeb) {
      itemList.add(iw_sample_list.SampleItem(
          itemTitle: "서버 샘플",
          itemDescription: "서버 포트 개방 샘플",
          onItemClicked: () {
            business.onServerSampleItemClicked();
          }));
    }

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "전역 변수 상태 확인 샘플",
        itemDescription: "전역 변수 사용시의 상태 확인용 샘플 (특히 웹에서 새 탭으로 접속 했을 때를 확인하기)",
        onItemClicked: () {
          business.onGlobalVariableStateTestSampleItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "위젯 변경 애니메이션 샘플 리스트",
        itemDescription: "위젯 변경시의 애니메이션 적용 샘플 리스트",
        onItemClicked: () {
          business.onWidgetChangeAnimationSampleListItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "암/복호화 샘플",
        itemDescription: "암호화, 복호화 적용 샘플",
        onItemClicked: () {
          business.onCryptSampleItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "GIF 샘플",
        itemDescription: "GIF 이미지 샘플",
        onItemClicked: () {
          business.onGifSampleItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "이미지 선택 샘플",
        itemDescription: "로컬 저장소, 혹은 카메라에서 이미지를 가져오는 샘플",
        onItemClicked: () {
          business.onImageSelectorSampleItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "이미지 로딩 샘플",
        itemDescription: "네트워크 이미지를 가져올 때 로딩 처리 및 에러 처리 샘플",
        onItemClicked: () {
          business.onImageLoadingSampleItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "컨텍스트 메뉴 샘플",
        itemDescription: "마우스 우클릭시(모바일에서는 롱 클릭) 나타나는 메뉴 샘플",
        onItemClicked: () {
          business.onContextMenuSampleItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "Gesture 위젯 영역 중첩 테스트",
        itemDescription: "Gesture 위젯 영역 중첩시 동작을 테스트합니다.",
        onItemClicked: () {
          business.onGestureAreaOverlapTestItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "Form 입력 샘플",
        itemDescription: "Form 입력 작성 샘플",
        onItemClicked: () {
          business.onFormSampleItemClicked();
        }));

    return gw_page_outer_frame.SlWidget(
      business: business.pageOutFrameBusiness,
      inputVo: gw_page_outer_frame.InputVo(
        pageTitle: "기타 샘플 리스트",
        child: iw_sample_list.SfWidget(
          globalKey: business.iwSampleListStateGk,
          inputVo: iw_sample_list.InputVo(itemList: itemList),
        ),
      ),
    );
  }
}
