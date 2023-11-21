// (external)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;
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

    return gw_page_out_frames.PageOutFrame(
      pageTitle: "이미지 선택 샘플",
      business: pageBusiness.pageViewModel.pageOutFrameBusiness,
      floatingActionButton: null,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
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
                          if (pageBusiness.pageViewModel.selectedImage ==
                              null) {
                            return ClipOval(
                                child: Container(
                              color: Colors.blue,
                              width: 150,
                              height: 150,
                              child: const Icon(
                                Icons.photo_outlined,
                                color: Colors.white,
                                size: 120,
                              ),
                            ));
                          } else {
                            return ClipOval(
                              child: SizedBox(
                                width: 150,
                                height: 150,
                                child: Image(
                                  image: MemoryImage(pageBusiness
                                      .pageViewModel.selectedImage!),
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    // 로딩 중일 때 플레이스 홀더를 보여줍니다.
                                    if (loadingProgress == null) {
                                      return child; // 로딩이 끝났을 경우
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    // 에러 발생 시 설정한 에러 위젯을 반환합니다.
                                    return const Center(
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    );
                                  },
                                ),
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

              // 이미지 리스트 선택
              Container(
                margin: const EdgeInsets.only(
                  top: 50,
                  left: 20,
                  right: 20,
                ),
                height: 120,
                //decoration: const BoxDecoration(
                //  color: Color.fromARGB(255, 249, 249, 249),
                //),
                child: Center(
                  child: BlocBuilder<page_business.BlocImageList, bool>(
                    builder: (context, state) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            pageBusiness.pageViewModel.imageFiles.length + 1,
                        itemBuilder: (context, index) {
                          // 첫번째 인덱스는 무조건 추가 버튼
                          if (0 == index) {
                            return Stack(
                              children: [
                                Positioned(
                                    top: 50,
                                    width: 76,
                                    child: Center(
                                        child: Text(
                                      "${pageBusiness.pageViewModel.imageFiles.length}/${pageBusiness.pageViewModel.imageFileListMaxCount}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color.fromARGB(
                                              255, 158, 158, 158)),
                                    ))),
                                Container(
                                  width: 76,
                                  height: 76,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          width: 1.0, color: Colors.black),
                                      bottom: BorderSide(
                                          width: 1.0, color: Colors.black),
                                      left: BorderSide(
                                          width: 1.0, color: Colors.black),
                                      right: BorderSide(
                                          width: 1.0, color: Colors.black),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          pageBusiness.pressAddPictureBtn();
                                        },
                                        iconSize: 35,
                                        color: const Color.fromARGB(
                                            255, 158, 158, 158),
                                        icon: const Icon(Icons.photo_library),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            Uint8List imageFile;
                            imageFile = pageBusiness
                                .pageViewModel.imageFiles[index - 1];

                            return Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 76,
                                    height: 76,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image(
                                      image: MemoryImage(imageFile),
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        // 로딩 중일 때 플레이스 홀더를 보여줍니다.
                                        if (loadingProgress == null) {
                                          return child; // 로딩이 끝났을 경우
                                        }
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        // 에러 발생 시 설정한 에러 위젯을 반환합니다.
                                        return const Center(
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    top: -10,
                                    right: -10,
                                    child: IconButton(
                                      onPressed: () {
                                        pageBusiness
                                            .pressDeletePicture(index - 1);
                                      },
                                      iconSize: 15,
                                      color: Colors.white,
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: Colors.grey,
                                        size: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
