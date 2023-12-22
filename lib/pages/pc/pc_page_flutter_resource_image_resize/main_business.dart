// (external)
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

// (inner_folder)
import 'main_widget.dart' as main_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;
import 'package:flutter_project_template/dialogs/all/all_dialog_loading_spinner/main_widget.dart'
    as all_dialog_loading_spinner;

// [위젯 비즈니스]

//------------------------------------------------------------------------------
class MainBusiness {
  // [CallBack 함수]
  // (inputVo 확인 콜백)
  // State 클래스의 initState 에서 실행 되며, Business 클래스의 initState 실행 전에 실행 됩니다.
  // 필수 정보 누락시 null 을 반환, null 이 반환 되었을 때는 inputError 가 true 가 됩니다.
  main_widget.InputVo? onCheckPageInputVo(
      {required GoRouterState goRouterState}) {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters.containsKey("inputValueString")) {
    //   return null;
    // }

    // !!!PageInputVo 입력!!!
    return const main_widget.InputVo();
  }

  // (진입 최초 단 한번 실행) - 아직 위젯이 생성 되기 전
  void initState() {
    // !!!initState 로직 작성!!!
  }

  // (종료 시점 단 한번 실행)
  void dispose() {
    // !!!dispose 로직 작성!!!
  }

  // (최초 실행시 단 한번 실행) - 위젯 build 바로 직전, 모든 것이 준비 되었을 때
  void onCreate() {
    // !!!onCreate 로직 작성!!!
  }

  Future<void> onFocusGainedAsync() async {
    // !!!onFocusGainedAsync 로직 작성!!!
  }

  Future<void> onFocusLostAsync() async {
    // !!!onFocusLostAsync 로직 작성!!!
  }

  Future<void> onVisibilityGainedAsync() async {
    // !!!onVisibilityGainedAsync 로직 작성!!!
  }

  Future<void> onVisibilityLostAsync() async {
    // !!!onVisibilityLostAsync 로직 작성!!!
  }

  Future<void> onForegroundGainedAsync() async {
    // !!!onForegroundGainedAsync 로직 작성!!!
  }

  Future<void> onForegroundLostAsync() async {
    // !!!onForegroundLostAsync 로직 작성!!!
  }

  //----------------------------------------------------------------------------
  // !!!메인 위젯에서 사용할 변수는 이곳에서 저장하여 사용하세요.!!!
  // [public 변수]
  // (위젯 입력값)
  late main_widget.InputVo inputVo;

  // (페이지 pop 가능 여부 변수) - false 로 설정시 pop 불가
  bool canPop = true;

  // (입력값 미충족 여부)
  bool inputError = false;

  // (context 객체)
  late BuildContext mainContext;

  // (최초 실행 플래그)
  bool pageInitFirst = true;

  // (pageOutFrameBusiness)
  final gw_slw_page_outer_frame.SlwPageOuterFrameBusiness pageOutFrameBusiness =
      gw_slw_page_outer_frame.SlwPageOuterFrameBusiness();

  // (선택한 이미지)
  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> pickedFileImageAreaGk =
      GlobalKey();
  late BuildContext pickedFileImageAreaContext;
  XFile? pickedFile;
  Uint8List? pickedFileImage;

  // todo 경로 변경 로직
  String? saveDirectory = "C:/Users/raill/Downloads/resizedImages";

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!비즈니스 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (메인 위젯 화면 갱신)
  late VoidCallback refreshUi;

  Future<void> onTabImageAreaAsync() async {
    if (pickedFileImage == null) {
      ImagePicker imagePicker = ImagePicker();
      pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        var image = XFile(pickedFile!.path);
        pickedFileImage = await image.readAsBytes();
        pickedFileImageAreaGk.currentState?.refreshUi();
      }
    }
  }

  void deleteImage() {
    pickedFile = null;
    pickedFileImage = null;
    pickedFileImageAreaGk.currentState?.refreshUi();
  }

  Future<void> imageResizing() async {
    if (saveDirectory == null) {
      return;
    }

    if (pickedFile != null) {
      GlobalKey<all_dialog_loading_spinner.MainWidgetState>
          allDialogLoadingSpinnerStateGk = GlobalKey();

      // todo 로딩 다이얼로그 멈춤
      await showDialog(
          barrierDismissible: false,
          context: mainContext,
          builder: (context) => all_dialog_loading_spinner.MainWidget(
                key: allDialogLoadingSpinnerStateGk,
                inputVo: all_dialog_loading_spinner.InputVo(
                    onDialogCreated: () async {
                  final image = File(pickedFile!.path);
                  final imageBytes = await image.readAsBytes();

                  // 이미지 로드
                  img.Image originalImage = img.decodeImage(imageBytes)!;

                  img.Image resizedImage075 = img.copyResize(originalImage,
                      width: originalImage.width ~/ (4 / 0.75),
                      height: originalImage.height ~/ (4 / 0.75));
                  img.Image resizedImage1 = img.copyResize(originalImage,
                      width: originalImage.width ~/ (4 / 1),
                      height: originalImage.height ~/ (4 / 1));
                  img.Image resizedImage15 = img.copyResize(originalImage,
                      width: originalImage.width ~/ (4 / 1.5),
                      height: originalImage.height ~/ (4 / 1.5));
                  img.Image resizedImage2 = img.copyResize(originalImage,
                      width: originalImage.width ~/ (4 / 2),
                      height: originalImage.height ~/ (4 / 2));
                  img.Image resizedImage3 = img.copyResize(originalImage,
                      width: originalImage.width ~/ (4 / 3),
                      height: originalImage.height ~/ (4 / 3));

                  final directory075 =
                      Directory('$saveDirectory/0.75x'); // 다운로드할 위치 설정
                  if (!directory075.existsSync()) {
                    directory075.createSync(recursive: true);
                  }
                  final file075 =
                      File('${directory075.path}/${pickedFile!.name}');
                  await file075.writeAsBytes(img.encodeJpg(resizedImage075));

                  final directory1 = Directory('$saveDirectory'); // 다운로드할 위치 설정
                  if (!directory1.existsSync()) {
                    directory1.createSync(recursive: true);
                  }
                  final file1 = File('${directory1.path}/${pickedFile!.name}');
                  await file1.writeAsBytes(img.encodeJpg(resizedImage1));

                  final directory15 =
                      Directory('$saveDirectory/1.5x'); // 다운로드할 위치 설정
                  if (!directory15.existsSync()) {
                    directory15.createSync(recursive: true);
                  }
                  final file15 =
                      File('${directory15.path}/${pickedFile!.name}');
                  await file15.writeAsBytes(img.encodeJpg(resizedImage15));

                  final directory2 =
                      Directory('$saveDirectory/2.0x'); // 다운로드할 위치 설정
                  if (!directory2.existsSync()) {
                    directory2.createSync(recursive: true);
                  }
                  final file2 = File('${directory2.path}/${pickedFile!.name}');
                  await file2.writeAsBytes(img.encodeJpg(resizedImage2));

                  final directory3 =
                      Directory('$saveDirectory/3.0x'); // 다운로드할 위치 설정
                  if (!directory3.existsSync()) {
                    directory3.createSync(recursive: true);
                  }
                  final file3 = File('${directory3.path}/${pickedFile!.name}');
                  await file3.writeAsBytes(img.encodeJpg(resizedImage3));

                  final directory4 =
                      Directory('$saveDirectory/4.0x'); // 다운로드할 위치 설정
                  if (!directory4.existsSync()) {
                    directory4.createSync(recursive: true);
                  }
                  final file4 = File('${directory4.path}/${pickedFile!.name}');
                  await file4.writeAsBytes(img.encodeJpg(originalImage));

                  allDialogLoadingSpinnerStateGk.currentState?.mainBusiness
                      .closeDialog();
                }),
              )).then((outputVo) {});
    }
  }

  // [private 함수]
  void _doNothing() {}
}
