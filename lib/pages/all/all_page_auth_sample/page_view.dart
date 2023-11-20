// (external)
import 'package:flutter/material.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;
import '../../../global_widgets/gw_custom_widgets.dart' as gw_custom_widgets;

// [페이지 화면 위젯 작성 파일]
// 페이지 화면 구현을 담당합니다. (Widget 과 Business 간의 결합을 담당)
// 로직 처리는 pageBusiness 객체에 위임하세요.

//------------------------------------------------------------------------------
// (페이지 UI 위젯)
// !!!세부 화면 정의!!!
class PageView extends StatelessWidget {
  const PageView(this._pageBusiness, {super.key});

  // 페이지 비즈니스 객체
  final page_business.PageBusiness _pageBusiness;

  @override
  Widget build(BuildContext context) {
    return gw_page_out_frames.PageOutFrame(
      business: _pageBusiness.pageViewModel.pageOutFrameBusiness,
      floatingActionButton: null,
      child: SingleChildScrollView(
        child: Column(
          children: [
            MemberInfoWidget(
                _pageBusiness.pageViewModel.memberInfoWidgetViewModel,
                key: _pageBusiness.pageViewModel.memberInfoWidgetStateGk),
            MainListWidget(_pageBusiness.pageViewModel.mainListWidgetViewModel,
                key: _pageBusiness.pageViewModel.mainListWidgetStateGk)
          ],
        ),
      ),
    );
  }
}

// ex :
// (Stateless 위젯 템플릿)
// class StatelessWidgetTemplate extends StatelessWidget {
//   const StatelessWidgetTemplate(this.viewModel, {required super.key});
//
//   // 위젯 뷰모델
//   final StatelessWidgetTemplateViewModel viewModel;
//
//   //!!!주입 받을 하위 위젯 선언 하기!!!
//
//   // !!!하위 위젯 작성하기. (viewModel 에서 데이터를 가져와 사용)!!!
//   @override
//   Widget build(BuildContext context) {
//     return Text(viewModel.sampleText);
//   }
// }
//
// class StatelessWidgetTemplateViewModel {
//   StatelessWidgetTemplateViewModel(this.sampleText);
//
//   // !!!위젯 상태 변수 선언하기!!!
//   final String sampleText;
// }

// (Stateful 위젯 템플릿)
// class StatefulWidgetTemplate extends StatefulWidget {
//   const StatefulWidgetTemplate(this.viewModel, {required super.key});
//
//   // 위젯 뷰모델
//   final StatefulWidgetTemplateViewModel viewModel;
//
//   //!!!주입 받을 하위 위젯 선언 하기!!!
//
//   @override
//   StatefulWidgetTemplateState createState() => StatefulWidgetTemplateState();
// }
//
// class StatefulWidgetTemplateViewModel {
//   StatefulWidgetTemplateViewModel(this.sampleInt);
//
//   // !!!위젯 상태 변수 선언하기!!!
//   int sampleInt;
// }
//
// class StatefulWidgetTemplateState extends State<StatefulWidgetTemplate> {
//   // Stateful Widget 화면 갱신
//   void refresh() {
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // !!!하위 위젯 작성하기. (widget.viewModel 에서 데이터를 가져와 사용)!!!
//     return Text(widget.viewModel.sampleInt.toString());
//   }
// }

// (멤버 정보 위젯)
class MemberInfoWidget extends StatefulWidget {
  const MemberInfoWidget(this.viewModel, {required super.key});

  // 위젯 뷰모델
  final MemberInfoWidgetViewModel viewModel;

  //!!!주입 받을 하위 위젯 선언 하기!!!

  @override
  MemberInfoWidgetState createState() => MemberInfoWidgetState();
}

class MemberInfoWidgetViewModel {
  MemberInfoWidgetViewModel();

  // !!!위젯 상태 변수 선언하기!!!
  String? memberUid;
  String? tokenType;
  String? accessToken;
  String? accessTokenExpireWhen;
  String? refreshToken;
  String? refreshTokenExpireWhen;
}

class MemberInfoWidgetState extends State<MemberInfoWidget> {
  // Stateful Widget 화면 갱신
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // !!!하위 위젯 작성하기. (widget.viewModel 에서 데이터를 가져와 사용)!!!
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      fontWeight: FontWeight.bold, fontFamily: "MaruBuri"),
                )),
            Expanded(
                flex: 3,
                child: SelectableText(
                  widget.viewModel.memberUid == null
                      ? "null"
                      : widget.viewModel.memberUid!,
                  style: const TextStyle(fontFamily: "MaruBuri"),
                )),
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
                      fontWeight: FontWeight.bold, fontFamily: "MaruBuri"),
                )),
            Expanded(
                flex: 3,
                child: SelectableText(
                  widget.viewModel.tokenType == null
                      ? "null"
                      : widget.viewModel.tokenType!,
                  style: const TextStyle(fontFamily: "MaruBuri"),
                )),
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
                      fontWeight: FontWeight.bold, fontFamily: "MaruBuri"),
                )),
            Expanded(
                flex: 3,
                child: SelectableText(
                  widget.viewModel.accessToken == null
                      ? "null"
                      : widget.viewModel.accessToken!,
                  style: const TextStyle(fontFamily: "MaruBuri"),
                )),
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
                      fontWeight: FontWeight.bold, fontFamily: "MaruBuri"),
                )),
            Expanded(
                flex: 3,
                child: SelectableText(
                  widget.viewModel.accessTokenExpireWhen == null
                      ? "null"
                      : widget.viewModel.accessTokenExpireWhen!,
                  style: const TextStyle(fontFamily: "MaruBuri"),
                )),
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
                      fontWeight: FontWeight.bold, fontFamily: "MaruBuri"),
                )),
            Expanded(
                flex: 3,
                child: SelectableText(
                  widget.viewModel.refreshToken == null
                      ? "null"
                      : widget.viewModel.refreshToken!,
                  style: const TextStyle(fontFamily: "MaruBuri"),
                )),
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
                      fontWeight: FontWeight.bold, fontFamily: "MaruBuri"),
                )),
            Expanded(
                flex: 3,
                child: SelectableText(
                  widget.viewModel.refreshTokenExpireWhen == null
                      ? "null"
                      : widget.viewModel.refreshTokenExpireWhen!,
                  style: const TextStyle(fontFamily: "MaruBuri"),
                )),
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
    );
  }
}

// (리스트 위젯)
class MainListWidget extends StatefulWidget {
  const MainListWidget(this.viewModel, {required super.key});

  // 위젯 뷰모델
  final MainListWidgetViewModel viewModel;

  //!!!주입 받을 하위 위젯 선언 하기!!!

  @override
  MainListWidgetState createState() => MainListWidgetState();
}

class MainListWidgetViewModel {
  MainListWidgetViewModel();

  // !!!위젯 상태 변수 선언하기!!!
  List<MainListWidgetViewModelMainItemVo>
      mainListWidgetViewModelMainItemVoList = [];
}

class MainListWidgetViewModelMainItemVo {
  MainListWidgetViewModelMainItemVo(
    this.sampleItemTitle,
    this.sampleItemDescription,
    this.hoverListTileWrapperBusiness,
  );

  // 샘플 타이틀
  String sampleItemTitle;

  // 샘플 설명
  String sampleItemDescription;

  // HoverListTileWrapperState 의 key 와 viewModel
  gw_custom_widgets.HoverListTileWrapperBusiness hoverListTileWrapperBusiness;
}

class MainListWidgetState extends State<MainListWidget> {
  // Stateful Widget 화면 갱신
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // !!!하위 위젯 작성하기. (widget.viewModel 에서 데이터를 가져와 사용)!!!
    return ListView.builder(
      shrinkWrap: true, // 리스트뷰 크기 고정
      primary: false, // 리스트뷰 내부는 스크롤 금지
      itemCount: widget.viewModel.mainListWidgetViewModelMainItemVoList.length,
      itemBuilder: (context, index) {
        var itemInfo =
            widget.viewModel.mainListWidgetViewModelMainItemVoList[index];
        return Column(
          children: [
            gw_custom_widgets.HoverListTileWrapper(
              business: itemInfo.hoverListTileWrapperBusiness,
              listTileChild: ListTile(
                mouseCursor: SystemMouseCursors.click,
                title: Text(
                  itemInfo.sampleItemTitle,
                  style: const TextStyle(fontFamily: "MaruBuri"),
                ),
                subtitle: Text(
                  itemInfo.sampleItemDescription,
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
  }
}
