// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_widgets/gw_page_outer_frame/widget_view.dart'
    as gw_page_outer_frame_view;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;

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

    return gw_page_outer_frame_view.WidgetView(
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
                        transitionBuilder: pageBusiness.pageViewModel
                            .widgetChangeAnimatedSwitcherConfig.transitionBuilder,
                        child: pageBusiness.pageViewModel.sampleWidget);
                  },
                ),
              ),
              BlocBuilder<page_business.BlocSampleList, bool>(
                builder: (c, s) {
                  return ListView.builder(
                      shrinkWrap: true, // 리스트뷰 크기 고정
                      primary: false, // 리스트뷰 내부는 스크롤 금지
                      itemCount: pageBusiness.pageViewModel.allSampleList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            _HoverListTileWrapper(
                              index,
                              pageBusiness.onRouteListItemClick,
                              ListTile(
                                mouseCursor: SystemMouseCursors.click,
                                title: Text(
                                  pageBusiness.pageViewModel.allSampleList[index]
                                      .sampleItemTitle,
                                  style: const TextStyle(fontFamily: "MaruBuri"),
                                ),
                                subtitle: Text(
                                  pageBusiness.pageViewModel.allSampleList[index]
                                      .sampleItemDescription,
                                  style: const TextStyle(fontFamily: "MaruBuri"),
                                ),
                                trailing: const Icon(Icons.chevron_right),
                              ),
                            ),
                            const Divider(
                              color: Colors.grey,
                              height: 0.1,
                            ),
                          ],
                        );
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 호버 리스트 타일 래퍼
class _HoverListTileWrapper extends StatefulWidget {
  const _HoverListTileWrapper(
      this.index, this.onRouteListItemClick, this.listTileChild);

  final int index;
  final void Function(int index) onRouteListItemClick;
  final Widget listTileChild;

  @override
  _HoverListTileWrapperState createState() => _HoverListTileWrapperState();
}

class _HoverListTileWrapperState extends State<_HoverListTileWrapper> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      // 커서 변경 및 호버링 상태 변경
      cursor: SystemMouseCursors.click,
      onEnter: (details) => setState(() => _isHovering = true),
      onExit: (details) => setState(() => _isHovering = false),
      child: GestureDetector(
        // 클릭시 제스쳐 콜백
        onTap: () {
          widget.onRouteListItemClick(widget.index);
        },
        child: Container(
          color: _isHovering ? Colors.blue.withOpacity(0.2) : Colors.white,
          child: widget.listTileChild,
        ),
      ),
    );
  }
}
