// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

// (inner_folder)
import 'main_widget.dart' as main_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;
import 'package:flutter_project_template/dialogs/all/all_dialog_image_selector_menu/main_widget.dart'
    as all_dialog_image_selector_menu;

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

  // 이미지 선택자
  ImagePicker imagePicker = ImagePicker();

  // 선택된 이미지
  Uint8List? selectedImage;

  // 선택 이미지 리스트 최대 개수
  int imageFileListMaxCount = 20;

  // 선택된 이미지 리스트
  List<Uint8List> imageFiles = [];

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> profileImageAreaGk =
      GlobalKey();
  late BuildContext profileImageAreaContext;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> imageListAreaGk =
      GlobalKey();
  late BuildContext imageListAreaContext;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!비즈니스 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (메인 위젯 화면 갱신)
  late VoidCallback refreshUi;

  // (프로필 이미지 클릭)
  Future<void> onProfileImageTap() async {
    final GlobalKey<all_dialog_image_selector_menu.MainWidgetState>
        allDialogImageSelectorMenuAreaGk = GlobalKey();

    if (!mainContext.mounted) return;
    var pageOutputVo = await showDialog(
        barrierDismissible: true,
        context: mainContext,
        builder: (context) => all_dialog_image_selector_menu.MainWidget(
              key: allDialogImageSelectorMenuAreaGk,
              inputVo: all_dialog_image_selector_menu.InputVo(
                onDialogCreated: () {},
              ),
            ));

    if (pageOutputVo != null) {
      switch (pageOutputVo.imageSourceType) {
        case all_dialog_image_selector_menu.ImageSourceType.gallery:
          {
            // 갤러리에서 선택하기
            try {
              final XFile? pickedFile = await imagePicker.pickImage(
                  source: ImageSource.gallery,
                  maxHeight: 1280,
                  maxWidth: 1280,
                  imageQuality: 70);
              if (pickedFile != null) {
                // JPG or PNG
                var image = XFile(pickedFile.path);
                var bytes = await image.readAsBytes();
                selectedImage = bytes;
                profileImageAreaGk.currentState?.refreshUi();
              }
            } catch (_) {}
          }
          break;
        case all_dialog_image_selector_menu.ImageSourceType.camera:
          {
            // 사진 찍기
            try {
              final XFile? pickedFile = await imagePicker.pickImage(
                  source: ImageSource.camera,
                  maxHeight: 1280,
                  maxWidth: 1280,
                  imageQuality: 70);
              if (pickedFile != null) {
                // JPG or PNG
                var image = XFile(pickedFile.path);
                var bytes = await image.readAsBytes();
                selectedImage = bytes;
                profileImageAreaGk.currentState?.refreshUi();
              }
            } catch (_) {}
          }
          break;
        case all_dialog_image_selector_menu.ImageSourceType.defaultImage:
          {
            // 기본 프로필 이미지 적용
            selectedImage = null;
            profileImageAreaGk.currentState?.refreshUi();
          }
          break;
        default:
          {
            // 알 수 없는 코드일 때
            throw Exception("unKnown Error Code");
          }
      }
    }
  }

  // (이미지 추가 버튼 클릭)
  Future<void> pressAddPictureBtn() async {
    //최대 3장까지 입력
    if (imageFiles.length >= imageFileListMaxCount) {
      showToast("최대 ${imageFileListMaxCount}장까지만 입력 가능합니다",
          context: mainContext, animation: StyledToastAnimation.scale);
      return;
    }

    final GlobalKey<all_dialog_image_selector_menu.MainWidgetState>
        allDialogImageSelectorMenuAreaGk = GlobalKey();

    if (!mainContext.mounted) return;
    var pageOutputVo = await showDialog(
        barrierDismissible: true,
        context: mainContext,
        builder: (context) => all_dialog_image_selector_menu.MainWidget(
              key: allDialogImageSelectorMenuAreaGk,
              inputVo: all_dialog_image_selector_menu.InputVo(
                onDialogCreated: () {},
              ),
            ));

    // todo : 추가시 로딩 다이얼로그
    if (pageOutputVo != null) {
      switch (pageOutputVo.imageSourceType) {
        case all_dialog_image_selector_menu.ImageSourceType.gallery:
          {
            // 갤러리에서 선택하기
            try {
              final List<XFile> pickedFiles = await imagePicker.pickMultiImage(
                  maxHeight: 1280, maxWidth: 1280, imageQuality: 70);
              if (pickedFiles.isNotEmpty) {
                for (var i = 0; i < pickedFiles.length; i++) {
                  if (imageFiles.length >= imageFileListMaxCount) {
                    break;
                  }

                  var pickedFile = pickedFiles[i];
                  var image = XFile(pickedFile.path);
                  var bytes = await image.readAsBytes();
                  imageFiles.add(bytes);
                }

                imageListAreaGk.currentState?.refreshUi();
              }
            } catch (_) {}
          }
          break;
        case all_dialog_image_selector_menu.ImageSourceType.camera:
          {
            // 사진 찍기
            try {
              final XFile? pickedFile = await imagePicker.pickImage(
                  source: ImageSource.camera,
                  maxHeight: 1280,
                  maxWidth: 1280,
                  imageQuality: 70);
              if (pickedFile != null) {
                // JPG or PNG
                var image = XFile(pickedFile.path);
                var bytes = await image.readAsBytes();
                imageFiles.add(bytes);

                imageListAreaGk.currentState?.refreshUi();
              }
            } catch (_) {}
          }
          break;
        case all_dialog_image_selector_menu.ImageSourceType.defaultImage:
          {
            // 기본 프로필 이미지 적용
            selectedImage = null;
            imageListAreaGk.currentState?.refreshUi();
          }
          break;
        default:
          {
            // 알 수 없는 코드일 때
            throw Exception("unKnown Error Code");
          }
      }
    }
  }

  void pressDeletePicture(int pictureListItemIdx) {
    imageFiles.removeAt(pictureListItemIdx);
    imageListAreaGk.currentState?.refreshUi();
  }

  // [private 함수]
  void _doNothing() {}
}
