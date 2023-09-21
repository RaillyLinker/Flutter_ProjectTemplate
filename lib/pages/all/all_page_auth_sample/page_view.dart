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
      backgroundColor: const Color(0xFFFFFFFF),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            centerTitle: false,
            title: Text(
              'Auth Sample',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue,
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
          ),

          SliverToBoxAdapter(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Member Info',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  const Expanded(
                      flex: 2,
                      child: Text(
                        '    - memberUid : ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child:
                          BlocBuilder<page_business.BlocSignInMemberInfo, bool>(
                              builder: (c, s) {
                        var signInMemberInfo =
                            pageBusiness.pageViewModel.signInMemberInfo;
                        String text = (signInMemberInfo == null)
                            ? "null"
                            : signInMemberInfo.memberUid;
                        return Text(text);
                      })),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Expanded(
                      flex: 2,
                      child: Text(
                        '    - nickName : ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child:
                          BlocBuilder<page_business.BlocSignInMemberInfo, bool>(
                              builder: (c, s) {
                        var signInMemberInfo =
                            pageBusiness.pageViewModel.signInMemberInfo;
                        String text = (signInMemberInfo == null)
                            ? "null"
                            : signInMemberInfo.nickName;
                        return Text(text);
                      })),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Expanded(
                      flex: 2,
                      child: Text(
                        '    - roleCodeList : ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child:
                          BlocBuilder<page_business.BlocSignInMemberInfo, bool>(
                              builder: (c, s) {
                        var signInMemberInfo =
                            pageBusiness.pageViewModel.signInMemberInfo;
                        String text = (signInMemberInfo == null)
                            ? "null"
                            : signInMemberInfo.roleCodeList.toString();
                        return Text(text);
                      })),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Expanded(
                      flex: 2,
                      child: Text(
                        '    - tokenType : ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child:
                          BlocBuilder<page_business.BlocSignInMemberInfo, bool>(
                              builder: (c, s) {
                        var signInMemberInfo =
                            pageBusiness.pageViewModel.signInMemberInfo;
                        String text = (signInMemberInfo == null)
                            ? "null"
                            : signInMemberInfo.tokenType;
                        return Text(text);
                      })),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Expanded(
                      flex: 2,
                      child: Text(
                        '    - accessToken : ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child:
                          BlocBuilder<page_business.BlocSignInMemberInfo, bool>(
                              builder: (c, s) {
                        var signInMemberInfo =
                            pageBusiness.pageViewModel.signInMemberInfo;
                        String text = (signInMemberInfo == null)
                            ? "null"
                            : signInMemberInfo.accessToken;
                        return SizedBox(
                          width: 200,
                          child: Text(
                            text,
                          ),
                        );
                      })),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Expanded(
                      flex: 2,
                      child: Text(
                        '    - accessTokenExpireWhen : ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child:
                          BlocBuilder<page_business.BlocSignInMemberInfo, bool>(
                              builder: (c, s) {
                        var signInMemberInfo =
                            pageBusiness.pageViewModel.signInMemberInfo;
                        String text = (signInMemberInfo == null)
                            ? "null"
                            : signInMemberInfo.accessTokenExpireWhen;
                        return Text(text);
                      })),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Expanded(
                      flex: 2,
                      child: Text(
                        '    - refreshToken : ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child:
                          BlocBuilder<page_business.BlocSignInMemberInfo, bool>(
                              builder: (c, s) {
                        var signInMemberInfo =
                            pageBusiness.pageViewModel.signInMemberInfo;
                        String text = (signInMemberInfo == null)
                            ? "null"
                            : signInMemberInfo.refreshToken;
                        return SizedBox(
                          width: 200,
                          child: Text(
                            text,
                          ),
                        );
                      })),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Expanded(
                      flex: 2,
                      child: Text(
                        '    - refreshTokenExpireWhen : ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child:
                          BlocBuilder<page_business.BlocSignInMemberInfo, bool>(
                              builder: (c, s) {
                        var signInMemberInfo =
                            pageBusiness.pageViewModel.signInMemberInfo;
                        String text = (signInMemberInfo == null)
                            ? "null"
                            : signInMemberInfo.refreshTokenExpireWhen;
                        return Text(text);
                      })),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Expanded(
                      flex: 2,
                      child: Text(
                        '    - myEmailList : ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                    flex: 3,
                    child:
                        BlocBuilder<page_business.BlocSignInMemberInfo, bool>(
                            builder: (c, s) {
                      var signInMemberInfo =
                          pageBusiness.pageViewModel.signInMemberInfo;
                      String text = (signInMemberInfo == null)
                          ? "null"
                          : signInMemberInfo.myEmailList.toString();
                      return Text(text);
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Expanded(
                      flex: 2,
                      child: Text(
                        '    - myPhoneNumberList : ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                    flex: 3,
                    child:
                        BlocBuilder<page_business.BlocSignInMemberInfo, bool>(
                            builder: (c, s) {
                      var signInMemberInfo =
                          pageBusiness.pageViewModel.signInMemberInfo;
                      String text = (signInMemberInfo == null)
                          ? "null"
                          : signInMemberInfo.myPhoneNumberList.toString();
                      return Text(text);
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Expanded(
                      flex: 2,
                      child: Text(
                        '    - myOAuth2List : ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                    flex: 3,
                    child:
                        BlocBuilder<page_business.BlocSignInMemberInfo, bool>(
                            builder: (c, s) {
                      var signInMemberInfo =
                          pageBusiness.pageViewModel.signInMemberInfo;

                      String valueTxt;
                      if (signInMemberInfo == null) {
                        valueTxt = "null";
                      } else {
                        List<Map<String, dynamic>> myPhoneNumberMapList = [];
                        for (var myPhoneNumber
                            in signInMemberInfo.myOAuth2List) {
                          myPhoneNumberMapList.add({
                            "oauth2TypeCode": myPhoneNumber.oauth2TypeCode,
                            "oauth2Id": myPhoneNumber.oauth2Id
                          });
                        }

                        valueTxt = myPhoneNumberMapList.toString();
                      }

                      String text = valueTxt;
                      return Text(text);
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Auth Samples',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
            ]),
          ),
          // Other Sliver Widgets
          BlocBuilder<page_business.BlocSampleList, bool>(builder: (c, s) {
            return SliverList.builder(
              itemCount: pageBusiness.pageViewModel.allSampleList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      pageBusiness.onRouteListItemClick(index);
                    },
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(pageBusiness.pageViewModel
                              .allSampleList[index].sampleItemTitle),
                          subtitle: Text(pageBusiness.pageViewModel
                              .allSampleList[index].sampleItemDescription),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                        const Divider(
                          color: Colors.grey,
                          height: 0.1,
                        ),
                      ],
                    ));
              },
            );
          }),
        ],
      ),
    );
  }
}
