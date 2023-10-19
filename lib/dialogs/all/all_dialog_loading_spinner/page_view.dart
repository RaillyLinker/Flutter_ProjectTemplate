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
// !!!세부 화면 정의!!
class PageView extends StatelessWidget {
  const PageView({super.key});

  @override
  Widget build(BuildContext context) {
    // pageBusiness 객체
    page_business.PageBusiness pageBusiness =
        BlocProvider.of<gc_template_classes.BlocPageInfo>(context)
            .state
            .pageBusiness;

    return const Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: 70,
        height: 70,
        child: LoadingSpinnerGif(),
      ),
    );
  }
}

// (Gif 재생 위젯)
// SingleTickerProviderStateMixin 를 사용하기 위해 StatefulWidget 사용.
// BLoC 패턴을 위하여 컨트롤러의 경우는 pageBusiness.pageViewModel 안에 저장하여 사용
class LoadingSpinnerGif extends StatefulWidget {
  const LoadingSpinnerGif({super.key});

  @override
  LoadingSpinnerGifState createState() => LoadingSpinnerGifState();
}

class LoadingSpinnerGifState extends State<LoadingSpinnerGif>
    with SingleTickerProviderStateMixin {
  late page_business.PageBusiness pageBusiness;

  @override
  void dispose() {
    pageBusiness.pageViewModel.dialogSpinnerGifController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String gifSrc = 'lib/assets/images/loading_spinner.gif';

    // pageBusiness 객체
    pageBusiness = BlocProvider.of<gc_template_classes.BlocPageInfo>(context)
        .state
        .pageBusiness;

    if (pageBusiness.pageViewModel.dialogSpinnerGifController == null) {
      // 컨트롤러 처음 생성시점
      //  pageBusiness.pageViewModel 에 저장
      pageBusiness.pageViewModel.dialogSpinnerGifController =
          GifController(vsync: this);

      // 최초 컨트롤러 설정
      pageBusiness.pageViewModel.dialogSpinnerGifController!
          .repeat(period: const Duration(milliseconds: 500));
    }

    return Gif(
      image: AssetImage(gifSrc),
      controller: pageBusiness.pageViewModel.dialogSpinnerGifController!,
      placeholder: (context) => const Text(''),
      onFetchCompleted: () {},
    );
  }
}
