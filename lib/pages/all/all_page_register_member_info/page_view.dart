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
          'Member Join : Member Info',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: true,
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
                    constraints: const BoxConstraints(maxWidth: 350),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            flex: 20,
                            child: SizedBox(
                              width: 200,
                              child: BlocBuilder<
                                  page_business.BlocNicknameEditText, bool>(
                                builder: (c, s) {
                                  return TextFormField(
                                    onChanged: (text) {
                                      pageBusiness.nickNameTextEditOnChanged();
                                    },
                                    enabled: pageBusiness
                                        .pageViewModel.nickNameTextEditEnabled,
                                    focusNode: pageBusiness
                                        .pageViewModel.nickNameTextEditFocus,
                                    controller: pageBusiness.pageViewModel
                                        .nickNameTextEditController,
                                    decoration: InputDecoration(
                                      errorText: pageBusiness.pageViewModel
                                          .nickNameTextEditErrorMsg,
                                      labelText: 'Nickname',
                                    ),
                                  );
                                },
                              ),
                            )),
                        const Expanded(child: SizedBox()),
                        Expanded(
                            flex: 10,
                            child: BlocBuilder<
                                page_business.BlocNicknameCheckBtn,
                                bool>(builder: (c, s) {
                              return ElevatedButton(
                                onPressed: () {
                                  // 중복 확인 버튼 동작
                                  pageBusiness.onNickNameCheckBtnClickAsync();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                child: Text(
                                  pageBusiness.pageViewModel.nickNameCheckBtn,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            })),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: () {
                    // 회원가입 버튼 동작
                    pageBusiness.onRegisterBtnClick();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'register membership',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  width: 300,
                  height: 300,
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 2, bottom: 2),
                  decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          // POINT
                          color: Colors.black,
                          width: 1.0,
                        ),
                        right: BorderSide(
                          // POINT
                          color: Colors.black,
                          width: 1.0,
                        ),
                        bottom: BorderSide(
                          // POINT
                          color: Colors.black,
                          width: 1.0,
                        ),
                        top: BorderSide(
                          // POINT
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: const SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Nickname generation rules",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '1. Set the length of the Nickname to at least 2 digits\n'
                          '2. Spaces cannot be used in the Nickname.\n'
                          '3. Do not use the following special characters as they are vulnerable to security\n'
                          '<, >, (, ), #, ’, /, |\n'
                          '4. If you use an inappropriate nickname such as abusive language or sexual content, you may be forced to change your nickname.',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        )
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
