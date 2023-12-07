// (external)
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget.dart' as page_widget;
import 'inner_widgets/iw_sample_list/sf_widget_state.dart'
    as iw_sample_list_state;
import 'inner_widgets/iw_sample_list/sf_widget.dart' as iw_sample_list;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget_business.dart'
    as gw_page_outer_frame_business;
import '../../../pages/all/all_page_page_and_router_sample_list/page_widget.dart'
    as all_page_page_and_router_sample_list;
import '../../../pages/all/all_page_dialog_sample_list/page_widget.dart'
    as all_page_dialog_sample_list;
import '../../../pages/all/all_page_dialog_animation_sample_list/page_widget.dart'
    as all_page_dialog_animation_sample_list;
import '../../../pages/all/all_page_network_request_sample_list/page_widget.dart'
    as all_page_network_request_sample_list;
import '../../../pages/all/all_page_auth_sample/page_widget.dart'
    as all_page_auth_sample;
import '../../../pages/all/all_page_etc_sample_list/page_widget.dart'
    as all_page_etc_sample_list;

// (mobile)
import '../../../pages/mobile/mobile_page_permission_sample_list/page_entrance.dart'
    as mobile_page_permission_sample_list;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageWidgetBusiness {
  // [콜백 함수]
  // (전체 위젯 initState)
  void initState() {
    // !!!initState 로직 작성!!!

    setListItem();
  }

  // (전체 위젯 dispose)
  void dispose() {
    // !!!initState 로직 작성!!!
  }

  // (전체 위젯의 FocusDetector 콜백들)
  Future<void> onFocusGained() async {
    // !!!onFocusGained 로직 작성!!!
  }

  Future<void> onFocusLost() async {
    // !!!onFocusLost 로직 작성!!!
  }

  Future<void> onVisibilityGained() async {
    // !!!onFocusLost 로직 작성!!!
  }

  Future<void> onVisibilityLost() async {
    // !!!onVisibilityLost 로직 작성!!!
  }

  Future<void> onForegroundGained() async {
    // !!!onForegroundGained 로직 작성!!!
  }

  Future<void> onForegroundLost() async {
    // !!!onForegroundLost 로직 작성!!!
  }

  void onCheckPageInputVo({required GoRouterState goRouterState}) {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   // 필수 파라미터가 없는 경우에 대한 처리
    // }

    // !!!PageInputVo 입력!!!
    inputVo = const page_widget.InputVo();
  }

  // [public 변수]
  late BuildContext context;

  // (위젯 입력값)
  late page_widget.InputVo inputVo;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // (pageOutFrameBusiness)
  final gw_page_outer_frame_business.SlWidgetBusiness pageOutFrameBusiness =
      gw_page_outer_frame_business.SlWidgetBusiness();

  final GlobalKey<iw_sample_list_state.SfWidgetState> iwSampleListStateGk =
      GlobalKey();

  List<iw_sample_list.SampleItem> itemList = [];

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  void setListItem() {
    itemList = [];
    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "페이지 / 라우터 샘플 리스트",
        itemDescription: "페이지 이동, 파라미터 전달 등의 샘플 리스트",
        onItemClicked: () {
          context.pushNamed(all_page_page_and_router_sample_list.pageName);
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "다이얼로그 샘플 리스트",
        itemDescription: "다이얼로그 호출 샘플 리스트",
        onItemClicked: () {
          context.pushNamed(all_page_dialog_sample_list.pageName);
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "다이얼로그 애니메이션 샘플 리스트",
        itemDescription: "다이얼로그 호출 애니메이션 샘플 리스트",
        onItemClicked: () {
          context.pushNamed(all_page_dialog_animation_sample_list.pageName);
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "네트워크 요청 샘플 리스트",
        itemDescription: "네트워크 요청 및 응답 처리 샘플 리스트",
        onItemClicked: () {
          context.pushNamed(all_page_network_request_sample_list.pageName);
        }));

    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      itemList.add(iw_sample_list.SampleItem(
          itemTitle: "모바일 권한 샘플 리스트",
          itemDescription: "모바일 디바이스 권한 처리 샘플 리스트",
          onItemClicked: () {
            context.pushNamed(mobile_page_permission_sample_list.pageName);
          }));
    }

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "계정 샘플",
        itemDescription: "계정 관련 기능 샘플",
        onItemClicked: () {
          context.pushNamed(all_page_auth_sample.pageName);
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "기타 샘플 리스트",
        itemDescription: "기타 테스트 샘플을 모아둔 리스트",
        onItemClicked: () {
          context.pushNamed(all_page_etc_sample_list.pageName);
        }));

    iwSampleListStateGk.currentState?.refreshUi();
  }

// [private 함수]
}
