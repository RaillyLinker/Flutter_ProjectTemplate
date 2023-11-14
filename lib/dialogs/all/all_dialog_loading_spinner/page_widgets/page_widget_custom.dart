// (external)
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

// [페이지 위젯 작성 파일]
// 페이지 뷰에서 사용할 위젯은 여기에 작성하여 사용하세요.

//------------------------------------------------------------------------------
// (Stateful Widget 생성 예시)
// class StatefulWidgetSample extends StatefulWidget {
//   const StatefulWidgetSample(this.viewModel, {super.key});
//
//   final StatefulWidgetSampleViewModel viewModel;
//
//   @override
//   StatefulWidgetSampleState createState() => StatefulWidgetSampleState();
// }
//
// class StatefulWidgetSampleViewModel {
//   StatefulWidgetSampleViewModel(this.sampleNumber);
//
//   // !!!State 에서 사용할 상태 변수 선언!!!
//   int sampleNumber;
// }
//
// class StatefulWidgetSampleState extends State<StatefulWidgetSample> {
//   // Stateful Widget 화면 갱신
//   void refresh() {
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // !!!widget.viewModel 의 상태 변수를 반영한 하위 위젯 작성!!!
//     return Text(widget.viewModel.sampleNumber.toString());
//   }
// }

// (Gif 재생 위젯)
// SingleTickerProviderStateMixin 를 사용하기 위해 StatefulWidget 사용.
// BLoC 패턴을 위하여 컨트롤러의 경우는 pageBusiness.pageViewModel 안에 저장하여 사용
class LoadingSpinnerGif extends StatefulWidget {
  const LoadingSpinnerGif(this.viewModel, {super.key});

  final LoadingSpinnerGifViewModel viewModel;

  @override
  LoadingSpinnerGifState createState() => LoadingSpinnerGifState();
}

class LoadingSpinnerGifViewModel {
  LoadingSpinnerGifViewModel();

  // !!!State 에서 사용할 상태 변수 선언!!!

  // 다이얼로그 스피너 Gif 컨트롤러
  GifController? dialogSpinnerGifController;
}

class LoadingSpinnerGifState extends State<LoadingSpinnerGif>
    with SingleTickerProviderStateMixin {
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
