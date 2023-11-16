// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;

// [페이지 화면 위젯 작성 파일]
// 페이지 화면 구현을 담당합니다.
// 로직 처리는 pageBusiness 객체에 위임하세요.

//------------------------------------------------------------------------------
// (페이지 UI 위젯)
// !!!세부 화면 정의!!!
int a = 0;

class PageView extends StatelessWidget {
  const PageView({super.key});

  @override
  Widget build(BuildContext context) {
    // pageBusiness 객체
    page_business.PageBusiness pageBusiness =
        BlocProvider.of<gc_template_classes.BlocPageInfo>(context)
            .state
            .pageBusiness;

    return gw_page_out_frames.PageOutFrame(
        pageBusiness.pageViewModel.pageOutFrameViewModel,
        "계정 샘플",
        SingleChildScrollView(
          // <==== 주인공. Column 하나를 child로 가짐
          child: Column(
            // 물론 Row도 가능
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 10, left: 10, right: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '멤버 정보',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "MaruBuri"),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          const Expanded(
                              flex: 2,
                              child: Text(
                                '    - memberUid : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "MaruBuri"),
                              )),
                          Expanded(
                              flex: 3,
                              child: BlocBuilder<
                                  page_business.BlocLoginMemberInfo,
                                  bool>(builder: (c, s) {
                                var loginMemberInfo =
                                    pageBusiness.pageViewModel.loginMemberInfo;
                                String text = (loginMemberInfo == null)
                                    ? "null"
                                    : loginMemberInfo.memberUid.toString();
                                return SelectableText(
                                  text,
                                  style:
                                      const TextStyle(fontFamily: "MaruBuri"),
                                );
                              })),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          const Expanded(
                              flex: 2,
                              child: Text(
                                '    - tokenType : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "MaruBuri"),
                              )),
                          Expanded(
                              flex: 3,
                              child: BlocBuilder<
                                  page_business.BlocLoginMemberInfo,
                                  bool>(builder: (c, s) {
                                var loginMemberInfo =
                                    pageBusiness.pageViewModel.loginMemberInfo;
                                String text = (loginMemberInfo == null)
                                    ? "null"
                                    : loginMemberInfo.tokenType;
                                return SelectableText(
                                  text,
                                  style:
                                      const TextStyle(fontFamily: "MaruBuri"),
                                );
                              })),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          const Expanded(
                              flex: 2,
                              child: Text(
                                '    - accessToken : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "MaruBuri"),
                              )),
                          Expanded(
                              flex: 3,
                              child: BlocBuilder<
                                  page_business.BlocLoginMemberInfo,
                                  bool>(builder: (c, s) {
                                var loginMemberInfo =
                                    pageBusiness.pageViewModel.loginMemberInfo;
                                String text = (loginMemberInfo == null)
                                    ? "null"
                                    : loginMemberInfo.accessToken;
                                return SizedBox(
                                  width: 200,
                                  child: SelectableText(
                                    text,
                                    style:
                                        const TextStyle(fontFamily: "MaruBuri"),
                                  ),
                                );
                              })),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          const Expanded(
                              flex: 2,
                              child: Text(
                                '    - accessTokenExpireWhen : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "MaruBuri"),
                              )),
                          Expanded(
                              flex: 3,
                              child: BlocBuilder<
                                  page_business.BlocLoginMemberInfo,
                                  bool>(builder: (c, s) {
                                var loginMemberInfo =
                                    pageBusiness.pageViewModel.loginMemberInfo;
                                String text = (loginMemberInfo == null)
                                    ? "null"
                                    : loginMemberInfo.accessTokenExpireWhen;
                                return SelectableText(
                                  text,
                                  style:
                                      const TextStyle(fontFamily: "MaruBuri"),
                                );
                              })),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          const Expanded(
                              flex: 2,
                              child: Text(
                                '    - refreshToken : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "MaruBuri"),
                              )),
                          Expanded(
                              flex: 3,
                              child: BlocBuilder<
                                  page_business.BlocLoginMemberInfo,
                                  bool>(builder: (c, s) {
                                var loginMemberInfo =
                                    pageBusiness.pageViewModel.loginMemberInfo;
                                String text = (loginMemberInfo == null)
                                    ? "null"
                                    : loginMemberInfo.refreshToken;
                                return SizedBox(
                                  width: 200,
                                  child: SelectableText(
                                    text,
                                    style:
                                        const TextStyle(fontFamily: "MaruBuri"),
                                  ),
                                );
                              })),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          const Expanded(
                              flex: 2,
                              child: Text(
                                '    - refreshTokenExpireWhen : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "MaruBuri"),
                              )),
                          Expanded(
                              flex: 3,
                              child: BlocBuilder<
                                  page_business.BlocLoginMemberInfo,
                                  bool>(builder: (c, s) {
                                var loginMemberInfo =
                                    pageBusiness.pageViewModel.loginMemberInfo;
                                String text = (loginMemberInfo == null)
                                    ? "null"
                                    : loginMemberInfo.refreshTokenExpireWhen;
                                return SelectableText(
                                  text,
                                  style:
                                      const TextStyle(fontFamily: "MaruBuri"),
                                );
                              })),
                        ],
                      ),
                      const SizedBox(height: 40.0),
                      const Text(
                        '계정 관련 기능 샘플 리스트',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "MaruBuri"),
                      ),
                    ]),
              ),
              BlocBuilder<page_business.BlocSampleList, bool>(
                builder: (c, s) {
                  page_business.BlocSampleList blocSampleList =
                      BlocProvider.of<page_business.BlocSampleList>(c);
                  return ListView.builder(
                    shrinkWrap: true, // 리스트뷰 크기 고정
                    primary: false, // 리스트뷰 내부는 스크롤 금지
                    itemCount: blocSampleList.allSampleList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          _HoverListTileWrapper(
                            index,
                            pageBusiness.onRouteListItemClick,
                            ListTile(
                              mouseCursor: SystemMouseCursors.click,
                              title: Text(
                                blocSampleList
                                    .allSampleList[index].sampleItemTitle,
                                style: const TextStyle(fontFamily: "MaruBuri"),
                              ),
                              subtitle: Text(
                                blocSampleList
                                    .allSampleList[index].sampleItemDescription,
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
                    },
                  );
                },
              )
            ],
          ),
        ));
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
