// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif/gif.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_widgets/gw_page_outer_frame/widget_view.dart'
    as gw_page_outer_frame_view;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;

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
        pageTitle: "GIF 샘플",
        child: const Center(
          child: SizedBox(
            width: 200,
            height: 200,
            child: TestGif(),
          ),
        ),
      ),
    );
  }
}

// (Gif 재생 위젯)
// SingleTickerProviderStateMixin 를 사용하기 위해 StatefulWidget 사용.
// BLoC 패턴을 위하여 컨트롤러의 경우는 pageBusiness.pageViewModel 안에 저장하여 사용
class TestGif extends StatefulWidget {
  const TestGif({super.key});

  @override
  TestGifState createState() => TestGifState();
}

class TestGifState extends State<TestGif> with SingleTickerProviderStateMixin {
  late page_business.PageBusiness pageBusiness;

  @override
  void dispose() {
    pageBusiness.pageViewModel.testGifController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String gifSrc = 'lib/assets/images/test.gif';

    // pageBusiness 객체
    pageBusiness = BlocProvider.of<gc_template_classes.BlocPageInfo>(context)
        .state
        .pageBusiness;

    if (pageBusiness.pageViewModel.testGifController == null) {
      // 컨트롤러 처음 생성시점
      //  pageBusiness.pageViewModel 에 저장
      pageBusiness.pageViewModel.testGifController = GifController(vsync: this);

      // rootBundle.load 사용시 사용 하지 않은 것 대비 느려짐.
      // 고로 정확히 duration, frame count 를 알고있다면 픽스해서 사용할 것.
      rootBundle.load(gifSrc).then((value) {
        var gifInfo = gf_my_functions.getGifDetails(byteData: value);

        if (kDebugMode) {
          print(gifInfo.frameCount);
          print(gifInfo.duration);
        }

        pageBusiness.pageViewModel.testGifController!
            .repeat(period: Duration(milliseconds: gifInfo.duration));
      });
    }

    return Gif(
      image: AssetImage(gifSrc),
      controller: pageBusiness.pageViewModel.testGifController!,
      placeholder: (context) => const Text('로딩중...'),
      onFetchCompleted: () {},
    );
  }
}
