// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gif/flutter_gif.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;

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

    // Mobile 앱 status bar 색상 변경
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !kIsWeb,
        title: const Text(
          "GIF 샘플",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: const Center(
        child: SizedBox(
          width: 70,
          height: 70,
          child: TestGif(),
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
    // pageBusiness 객체
    pageBusiness = BlocProvider.of<gc_template_classes.BlocPageInfo>(context)
        .state
        .pageBusiness;

    if (pageBusiness.pageViewModel.testGifController == null) {
      // 컨트롤러 처음 생성시점
      //  pageBusiness.pageViewModel 에 저장
      pageBusiness.pageViewModel.testGifController =
          FlutterGifController(vsync: this);

      rootBundle.load('lib/assets/images/test.gif').then((value) {
        var info = gf_my_functions.getGifDetails(value);
        print("++++++++++++++++++++++++++");
        print(info.frameCount);
        print(info.duration);

        // 최초 컨트롤러 설정
        pageBusiness.pageViewModel.testGifController!.repeat(
            min: 0,
            max: info.frameCount.toDouble(),
            period: Duration(milliseconds: info.duration));
      });
    }

    return GifImage(
      image: const AssetImage("lib/assets/images/test.gif"),
      controller: pageBusiness.pageViewModel.testGifController!,
    );
  }
}