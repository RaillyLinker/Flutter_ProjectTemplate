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
          "이미지 선택 샘플",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Center(
          child: GestureDetector(
            onTap: () {
              pageBusiness.onProfileImageTap();
            },
            child: Container(
              padding: const EdgeInsets.only(top: 50),
              child: Stack(
                children: [
                  BlocBuilder<page_business.BlocProfileImage, bool>(
                      builder: (c, s) {
                    if (pageBusiness.pageViewModel.selectedImage == null) {
                      return ClipOval(
                          child: Container(
                        color: Colors.blue,
                        width: 200,
                        height: 200,
                        child: const Icon(
                          Icons.photo_outlined,
                          color: Colors.white,
                          size: 170,
                        ),
                      ));
                    } else {
                      return ClipOval(
                        child: Image.memory(
                          pageBusiness.pageViewModel.selectedImage!,
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        ),
                      );
                    }
                  }),
                  Positioned(
                    width: 40,
                    height: 40,
                    bottom: 10,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 2), // changes position of shadow
                            ),
                          ]),
                      child: const Icon(
                        Icons.photo_library,
                        color: Colors.grey,
                        size: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
