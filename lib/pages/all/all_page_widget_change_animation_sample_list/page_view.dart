// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (page)
import 'page_business.dart' as page_business;
import 'inner_widgets/iw_sample_list/sf_widget.dart' as iw_sample_list;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget.dart'
    as gw_page_outer_frame_view;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../global_widgets/gw_page_outer_frame/sl_widget.dart'
    as gw_page_outer_frame;

// [페이지 화면 위젯 작성 파일]
// 페이지 화면 구현을 담당합니다.
// 로직 처리는 pageBusiness 객체에 위임하세요.

//------------------------------------------------------------------------------
// (페이지 UI 위젯)
// !!!세부 화면 정의!!!
class PageView extends StatelessWidget {
  const PageView({super.key});

  @override
  Widget build(BuildContext context) {
    // pageBusiness 객체
    page_business.PageBusiness pageBusiness =
        BlocProvider.of<gc_template_classes.BlocPageInfo>(context)
            .state
            .pageBusiness;

    final List<iw_sample_list.SampleItem> itemList = [];
    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "애니메이션 없음",
        itemDescription: "애니메이션을 적용하지 않고 위젯 변경",
        onItemClicked: () {
          pageBusiness.onNoAnimationItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "Fade 애니메이션",
        itemDescription: "Fade 애니메이션을 적용하고 위젯 변경",
        onItemClicked: () {
          pageBusiness.onFadeAnimationItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "Scale Transition 애니메이션",
        itemDescription: "Scale Transition 애니메이션을 적용하고 위젯 변경",
        onItemClicked: () {
          pageBusiness.onScaleTransitionItemClicked();
        }));

    itemList.add(iw_sample_list.SampleItem(
        itemTitle: "Flip 애니메이션",
        itemDescription: "Flip 애니메이션을 적용하고 위젯 변경",
        onItemClicked: () {
          pageBusiness.onFlipAnimationItemClicked();
        }));

    return gw_page_outer_frame_view.SlWidget(
      business: pageBusiness.pageViewModel.pageOutFrameBusiness,
      inputVo: gw_page_outer_frame_view.InputVo(
        pageTitle: "위젯 변경 애니메이션 샘플 리스트",
        child: SingleChildScrollView(
          // <==== 주인공. Column 하나를 child로 가짐
          child: Column(
            // 물론 Row도 가능
            children: [
              Container(
                color: Colors.white,
                height: 150,
                alignment: Alignment.center,
                child: BlocBuilder<page_business.BlocAnimationSample, bool>(
                  builder: (c, s) {
                    return AnimatedSwitcher(
                        duration: pageBusiness.pageViewModel
                            .widgetChangeAnimatedSwitcherConfig.duration,
                        reverseDuration: pageBusiness.pageViewModel
                            .widgetChangeAnimatedSwitcherConfig.reverseDuration,
                        switchInCurve: pageBusiness.pageViewModel
                            .widgetChangeAnimatedSwitcherConfig.switchInCurve,
                        switchOutCurve: pageBusiness.pageViewModel
                            .widgetChangeAnimatedSwitcherConfig.switchOutCurve,
                        layoutBuilder: pageBusiness.pageViewModel
                            .widgetChangeAnimatedSwitcherConfig.layoutBuilder,
                        transitionBuilder: pageBusiness
                            .pageViewModel
                            .widgetChangeAnimatedSwitcherConfig
                            .transitionBuilder,
                        child: pageBusiness.pageViewModel.sampleWidget);
                  },
                ),
              ),
              iw_sample_list.SfWidget(
                globalKey: pageBusiness.pageViewModel.iwSampleListStateGk,
                inputVo: iw_sample_list.InputVo(itemList: itemList),
              )
            ],
          ),
        ),
      ),
    );
  }
}
