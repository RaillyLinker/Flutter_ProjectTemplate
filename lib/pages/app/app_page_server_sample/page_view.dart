// (external)
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
        title: const Text(
          '서버 샘플',
          style: TextStyle(color: Colors.white, fontFamily: "MaruBuri"),
        ),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Row(
                  children: [
                    const Text(
                      '접속 IP 주소:',
                      style: TextStyle(fontFamily: "MaruBuri"),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: BlocBuilder<page_business.BlocServerBtn, bool>(
                        builder: (c, s) {
                          return TextFormField(
                            enabled: pageBusiness.pageViewModel.serverBtn ==
                                "서버 열기",
                            controller: pageBusiness
                                .pageViewModel.portTextEditController,
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(
                              hintText: '기본 포트 번호 9090',
                              labelText: '포트 번호 입력',
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    BlocBuilder<page_business.BlocServerBtn, bool>(
                        builder: (c, s) {
                      return Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          if (pageBusiness.pageViewModel.serverBtn ==
                              "서버 열기") {
                            pageBusiness.onClickOpenServerBtnAsync();
                          } else if (pageBusiness.pageViewModel.serverBtn ==
                              "서버 닫기") {
                            pageBusiness.onClickCloseServerBtnAsync();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: Text(
                          pageBusiness.pageViewModel.serverBtn,
                          style: const TextStyle(
                              color: Colors.white, fontFamily: "MaruBuri"),
                        ),
                      ));
                    }),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                margin: const EdgeInsets.all(8.0),
                child: BlocBuilder<page_business.BlocLogList, bool>(
                  builder: (c, s) {
                    return ListView.builder(
                      itemCount: pageBusiness.pageViewModel.logList.length,
                      itemBuilder: (context, index) {
                        String log = pageBusiness.pageViewModel.logList[index];
                        return ListTile(
                          title: Text(
                            log,
                            style: const TextStyle(fontFamily: "MaruBuri"),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
