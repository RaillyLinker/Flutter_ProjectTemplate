// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          "암/복호화 샘플",
          style: TextStyle(color: Colors.white, fontFamily: "MaruBuri"),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                                flex: 20,
                                child: TextFormField(
                                  controller: pageBusiness
                                      .pageViewModel.encryptTextController,
                                  decoration: const InputDecoration(
                                      labelText: '암호화할 평문',
                                      hintText:
                                          "암호화할 평문을 입력하세요."),
                                )),
                            const Expanded(child: SizedBox()),
                            Expanded(
                                flex: 10,
                                child: ElevatedButton(
                                  onPressed: () {
                                    pageBusiness.doEncrypt();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "암호화",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "MaruBuri"),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Expanded(
                                flex: 20,
                                child: Text(
                                  "결과 :",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                )),
                            const Expanded(child: SizedBox()),
                            Expanded(
                                flex: 80,
                                child: BlocBuilder<
                                    page_business.BlocEncryptResultText, bool>(
                                  builder: (c, s) {
                                    return SelectableText(
                                      pageBusiness
                                          .pageViewModel.encryptResultText,
                                      style: const TextStyle(
                                          fontFamily: "MaruBuri"),
                                    );
                                  },
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                                flex: 20,
                                child: TextFormField(
                                  controller: pageBusiness
                                      .pageViewModel.decryptTextController,
                                  decoration: const InputDecoration(
                                      labelText: '복호화할 암호문',
                                      hintText:
                                          "복호화할 암호문을 입력하세요."),
                                )),
                            const Expanded(child: SizedBox()),
                            Expanded(
                                flex: 10,
                                child: ElevatedButton(
                                  onPressed: () {
                                    pageBusiness.doDecrypt();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "복호화",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "MaruBuri"),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Expanded(
                                flex: 20,
                                child: Text(
                                  "결과 :",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                )),
                            const Expanded(child: SizedBox()),
                            Expanded(
                                flex: 80,
                                child: BlocBuilder<
                                    page_business.BlocDecryptResultText, bool>(
                                  builder: (c, s) {
                                    return SelectableText(
                                      pageBusiness
                                          .pageViewModel.decryptResultText,
                                      style: const TextStyle(
                                          fontFamily: "MaruBuri"),
                                    );
                                  },
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
