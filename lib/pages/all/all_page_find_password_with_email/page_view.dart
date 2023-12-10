// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
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

    return gw_slw_page_outer_frame.SlwPageOuterFrame(
      business: pageBusiness.pageViewModel.pageOutFrameBusiness,
      pageTitle: "비밀번호 찾기",
      child: SingleChildScrollView(
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
                                    page_business.BlocEmailEditText, bool>(
                                  builder: (c, s) {
                                    return TextFormField(
                                      onChanged: (text) {
                                        pageBusiness.emailTextEditOnChanged();
                                      },
                                      focusNode: pageBusiness
                                          .pageViewModel.emailTextEditFocus,
                                      controller: pageBusiness.pageViewModel
                                          .emailTextEditController,
                                      decoration: InputDecoration(
                                          errorText: pageBusiness.pageViewModel
                                              .emailTextEditErrorMsg,
                                          labelText: '이메일',
                                          hintText: "user@email.com"),
                                    );
                                  },
                                )),
                            const Expanded(child: SizedBox()),
                            Expanded(
                                flex: 10,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // 중복 확인 버튼 동작
                                    pageBusiness.sendVerificationEmail(
                                        context: context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 2, bottom: 2),
                                      child: const Text(
                                        "이메일\n발송",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "MaruBuri"),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
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
                                  pageBusiness.onVerificationCodeFieldSubmitted(
                                      context: c);
                                },
                                decoration: InputDecoration(
                                    errorText: pageBusiness.pageViewModel
                                        .verificationCodeTextEditErrorMsg,
                                    labelText: '본인 인증 코드',
                                    hintText: "이메일로 발송된 본인 인증 코드"),
                              );
                            }))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    pageBusiness.findPassword(context: context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    '비밀번호 찾기',
                    style:
                        TextStyle(color: Colors.white, fontFamily: "MaruBuri"),
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  width: 300,
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: const Text(
                    '이메일 주소를 입력 후 이메일 발송 버튼을 누르세요.\n\n'
                    '입력한 이메일 주소로 전송된 본인 인증 코드를 10분 안에 입력하세요.\n\n'
                    '이메일을 받지 못했다면,\n'
                    '- 입력한 이메일 주소가 올바른지 확인하세요.\n'
                    '- 이메일 스팸 보관함을 확인하세요.\n'
                    '- 이메일 저장소 용량이 충분한지 확인하세요.',
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
