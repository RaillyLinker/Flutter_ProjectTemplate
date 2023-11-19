// (external)
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

// (page)
import 'page_business.dart' as page_business;

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
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: 70,
        height: 70,
        child: LoadingSpinnerGif(
          _pageBusiness.pageViewModel.loadingSpinnerGifViewModel,
          key: _pageBusiness.pageViewModel.loadingSpinnerGifStateGk,
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

// (Gif 재생 위젯)
class LoadingSpinnerGif extends StatefulWidget {
  const LoadingSpinnerGif(this.viewModel, {required super.key});

  // 위젯 뷰모델
  final LoadingSpinnerGifViewModel viewModel;

  //!!!주입 받을 하위 위젯 선언 하기!!!

  @override
  LoadingSpinnerGifState createState() => LoadingSpinnerGifState();
}

class LoadingSpinnerGifViewModel {
  LoadingSpinnerGifViewModel();

  // !!!위젯 상태 변수 선언하기!!!
  GifController? dialogSpinnerGifController;
}

class LoadingSpinnerGifState extends State<LoadingSpinnerGif>
    with SingleTickerProviderStateMixin {
  // Stateful Widget 화면 갱신
  void refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.viewModel.dialogSpinnerGifController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String gifSrc = 'lib/assets/images/loading_spinner.gif';

    if (widget.viewModel.dialogSpinnerGifController == null) {
      // 컨트롤러 처음 생성시점
      //  pageBusiness.pageViewModel 에 저장
      widget.viewModel.dialogSpinnerGifController = GifController(vsync: this);

      // 최초 컨트롤러 설정
      widget.viewModel.dialogSpinnerGifController!
          .repeat(period: const Duration(milliseconds: 500));
    }

    return Gif(
      image: AssetImage(gifSrc),
      controller: widget.viewModel.dialogSpinnerGifController!,
      placeholder: (context) => const Text(''),
      onFetchCompleted: () {},
    );
  }
}
