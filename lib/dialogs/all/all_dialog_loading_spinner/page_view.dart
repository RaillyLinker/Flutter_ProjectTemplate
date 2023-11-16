// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif/gif.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
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

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: 70,
        height: 70,
        child: LoadingSpinnerGif(
            pageBusiness.pageViewModel.loadingSpinnerGifViewModel),
      ),
    );
  }
}

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

  // !!!위젯 상태 변수 선언하기!!!

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
