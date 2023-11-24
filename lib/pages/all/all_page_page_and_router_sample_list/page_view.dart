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
// todo : 입출력 테스트 입력창 에러 표시 배경색 수정, 에러 표시 입력 시점에 에러 없애기

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
        pageTitle: "페이지 / 라우터 샘플 리스트",
        business: pageBusiness.pageViewModel.pageOutFrameBusiness,
        floatingActionButton: null,
        child: BlocBuilder<page_business.BlocSampleList, bool>(builder: (c, s) {
          return ListView.builder(
            itemCount: pageBusiness.pageViewModel.allSampleList.length,
            itemBuilder: (context, index) {
              Widget listTile;
              if (pageBusiness
                      .pageViewModel.allSampleList[index].sampleItemEnum ==
                  page_business.SampleItemEnum.inputAndOutputPushTest) {
                listTile = Column(
                  children: [
                    _HoverListTileWrapper(
                        index,
                        pageBusiness.onRouteListItemClickAsync,
                        ListTile(
                          mouseCursor: SystemMouseCursors.click,
                          title: Text(
                            pageBusiness.pageViewModel.allSampleList[index]
                                .sampleItemTitle,
                            style: const TextStyle(fontFamily: "MaruBuri"),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pageBusiness.pageViewModel.allSampleList[index]
                                    .sampleItemDescription,
                                style: const TextStyle(fontFamily: "MaruBuri"),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Form(
                                key: pageBusiness
                                    .pageViewModel.inputAndOutputFormKey,
                                child: Row(
                                  children: [
                                    const Expanded(
                                        child: Text(
                                      "( 페이지 입력 파라미터 : ",
                                      style: TextStyle(fontFamily: "MaruBuri"),
                                    )),
                                    Expanded(
                                      child: Container(
                                        color: Colors.white,
                                        child: TextFormField(
                                          key: pageBusiness.pageViewModel
                                              .inputAndOutputFormInputValueTextFieldKey,
                                          autofocus: true,
                                          keyboardType: TextInputType.text,
                                          style: const TextStyle(fontSize: 12),
                                          decoration: const InputDecoration(
                                            labelText: 'PageInputVo.inputValue',
                                            hintText: "페이지 입력 파라미터",
                                            isDense: true,
                                            border: OutlineInputBorder(),
                                          ),
                                          controller: pageBusiness.pageViewModel
                                              .inputAndOutputFormInputValueTextFieldController,
                                          focusNode: pageBusiness.pageViewModel
                                              .inputAndOutputFormInputValueTextFieldFocus,
                                          validator: (value) {
                                            // 검사 : return 으로 반환하는 에러 메세지가 null 이 아니라면 에러로 처리
                                            if (value == null ||
                                                value.isEmpty) {
                                              return '이 항목을 입력 하세요.';
                                            }
                                            return null;
                                          },
                                          onFieldSubmitted: (value) {
                                            // 입력창 포커스 상태에서 엔터
                                            if (pageBusiness
                                                .pageViewModel
                                                .inputAndOutputFormKey
                                                .currentState!
                                                .validate()) {
                                              FocusScope.of(context)
                                                  .requestFocus(pageBusiness
                                                      .pageViewModel
                                                      .inputAndOutputFormNullableInputValueTextFieldFocus);
                                            } else {
                                              FocusScope.of(context)
                                                  .requestFocus(pageBusiness
                                                      .pageViewModel
                                                      .inputAndOutputFormInputValueTextFieldFocus);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.white,
                                        child: TextFormField(
                                          key: pageBusiness.pageViewModel
                                              .inputAndOutputFormNullableInputValueTextFieldKey,
                                          keyboardType: TextInputType.text,
                                          style: const TextStyle(fontSize: 12),
                                          decoration: const InputDecoration(
                                            labelText:
                                                'PageInputVo.inputValueOpt',
                                            hintText: "페이지 입력 파라미터 (Nullable)",
                                            isDense: true,
                                            border: OutlineInputBorder(),
                                          ),
                                          controller: pageBusiness.pageViewModel
                                              .inputAndOutputFormNullableInputValueTextFieldController,
                                          focusNode: pageBusiness.pageViewModel
                                              .inputAndOutputFormNullableInputValueTextFieldFocus,
                                          validator: (value) {
                                            // 검사 : return 으로 반환하는 에러 메세지가 null 이 아니라면 에러로 처리
                                            return null;
                                          },
                                          onFieldSubmitted: (value) {
                                            // 입력창 포커스 상태에서 엔터
                                            if (pageBusiness
                                                .pageViewModel
                                                .inputAndOutputFormKey
                                                .currentState!
                                                .validate()) {
                                              pageBusiness
                                                  .onRouteListItemClickAsync(
                                                      index);
                                            } else {
                                              FocusScope.of(context)
                                                  .requestFocus(pageBusiness
                                                      .pageViewModel
                                                      .inputAndOutputFormNullableInputValueTextFieldFocus);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      " )",
                                      style: TextStyle(fontFamily: "MaruBuri"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          trailing: const Icon(Icons.chevron_right),
                        )),
                    const Divider(
                      color: Colors.grey,
                      height: 0.1,
                    ),
                  ],
                );
              } else {
                listTile = Column(
                  children: [
                    _HoverListTileWrapper(
                        index,
                        pageBusiness.onRouteListItemClickAsync,
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
                        )),
                    const Divider(
                      color: Colors.grey,
                      height: 0.1,
                    ),
                  ],
                );
              }

              return listTile;
            },
          );
        }));
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
