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
          'Find Password with PhoneNumber',
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
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                                flex: 20,
                                child: BlocBuilder<
                                    page_business.BlocPhoneNumberEditText,
                                    bool>(
                                  builder: (c, s) {
                                    return TextFormField(
                                      onChanged: (text) {
                                        pageBusiness
                                            .phoneNumberTextEditOnChanged();
                                      },
                                      focusNode: pageBusiness.pageViewModel
                                          .phoneNumberTextEditFocus,
                                      controller: pageBusiness.pageViewModel
                                          .phoneNumberTextEditController,
                                      decoration: InputDecoration(
                                          errorText: pageBusiness.pageViewModel
                                              .phoneNumberTextEditErrorMsg,
                                          labelText: 'Phone Number',
                                          hintText: "00)000-0000-0000"),
                                    );
                                  },
                                )),
                            const Expanded(child: SizedBox()),
                            Expanded(
                                flex: 10,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // 중복 확인 버튼 동작
                                    pageBusiness.sendVerificationSms();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Send\nSMS",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "MaruBuri"),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: BlocBuilder<
                                page_business.BlocVerificationCodeTextField,
                                bool>(builder: (c, s) {
                              return TextFormField(
                                onChanged: (text) {
                                  pageBusiness
                                      .verificationCodeTextEditOnChanged();
                                },
                                focusNode: pageBusiness.pageViewModel
                                    .verificationCodeTextFieldFocus,
                                controller: pageBusiness.pageViewModel
                                    .verificationCodeTextFieldController,
                                onFieldSubmitted: (value) {
                                  pageBusiness
                                      .onVerificationCodeFieldSubmitted();
                                },
                                decoration: InputDecoration(
                                    errorText: pageBusiness.pageViewModel
                                        .verificationCodeTextEditErrorMsg,
                                    labelText: 'Verification Code',
                                    hintText:
                                        "Please enter your verification code"),
                              );
                            }))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: () {
                    pageBusiness.findPassword();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Find Password',
                    style:
                        TextStyle(color: Colors.white, fontFamily: "MaruBuri"),
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  width: 300,
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 2, bottom: 2),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: const Text(
                    'Please enter the Verification Code sent to the Phone Number you entered within 10 minutes after pressing the Send SMS button.\n\nIf you do not receive an SMS,\n- Make sure the PhoneNumber you entered is correct.\n- Check your spam folder.\n- Check if the message box has enough space.',
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontFamily: "MaruBuri"),
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
