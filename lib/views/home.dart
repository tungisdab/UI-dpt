import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:web/styles/web_colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  late VideoPlayerController _controller1;
  late VideoPlayerController _controller2;
  late VideoPlayerController _controller3;
  late Duration videoLength;
  late Duration videoPosition;

  @override
  void initState() {
    super.initState();
    try {
      _controller1 = VideoPlayerController.asset(
        'web/assets/animal/v1_animal.mp4', // Đường dẫn tới video trong thư mục assets
      )..initialize().then((_) {
          // Đảm bảo cập nhật giao diện sau khi khởi tạo video
          setState(() {
            videoLength = _controller1.value.duration; 
          });
        });
      _controller1.addListener(() {
        setState(() {
          videoPosition = _controller1.value.position;
          // Cập nhật trạng thái khi video thay đổi
        });
      });

      _controller2 = VideoPlayerController.asset(
        'web/assets/animal/v2_animal.mp4', // Đường dẫn tới video trong thư mục assets
      )..initialize().then((_) {
          // Đảm bảo cập nhật giao diện sau khi khởi tạo video
          setState(() {
            log('kkk');
          });
        });
      _controller2.addListener(() {
        setState(() {
          // Cập nhật trạng thái khi video thay đổi
        });
      });

      _controller3 = VideoPlayerController.asset(
        'web/assets/animal/v3_animal.mp4', // Đường dẫn tới video trong thư mục assets
      )..initialize().then((_) {
          // Đảm bảo cập nhật giao diện sau khi khởi tạo video
          setState(() {
            log('kkk');
          });
        });
      _controller3.addListener(() {
        setState(() {
          // Cập nhật trạng thái khi video thay đổi
        });
      });

    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      buttonUploadImage(),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Image Input:',
                            style: TextStyle(
                                color: WebColor.textColor, fontSize: 30),
                          ),
                          imageField(),
                        ],
                      )
                    ],
                  ),
                  DottedLine(
                    direction: Axis.vertical,
                    lineLength: 1500,
                    dashColor: WebColor.textColor,
                    lineThickness: 2,
                    dashLength: 20,
                    dashGapLength: 20,
                    dashGradient: [Colors.red, Colors.blue],
                    dashGapRadius: 4,
                  ),
                  Column(
                    children: [
                      buttonRecognition(),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Top 1:',
                            style: TextStyle(
                                color: WebColor.textColor, fontSize: 30),
                          ),
                          videoField1(),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Top 2:',
                            style: TextStyle(
                                color: WebColor.textColor, fontSize: 30),
                          ),
                          videoField2(),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Top 3:',
                            style: TextStyle(
                                color: WebColor.textColor, fontSize: 30),
                          ),
                          videoField3()
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget videoField1() => Center(
        child: _controller1.value.isInitialized
            ? DottedBorder(
                color: WebColor.textColor,
                dashPattern: [8, 4],
                strokeWidth: 2,
                child: Container(
                  height: 400,
                  width: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: _controller1.value.aspectRatio,
                        child: VideoPlayer(_controller1),
                      ),
                      VideoProgressIndicator(
                        _controller1,
                        allowScrubbing: true,
                        padding: EdgeInsets.all(10),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _controller1.value.isPlaying
                                    ? _controller1.pause()
                                    : _controller1.play();
                              });
                            },
                            child: Container(
                              height: 24,
                              width: 24,
                              child: Image.asset(_controller1.value.isPlaying
                                  ? 'assets/icons/pause.png'
                                  : 'assets/icons/play.png'),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text(
                            '${videoPosition.inSeconds}:${videoLength.inSeconds}',
                            style: TextStyle(color: WebColor.textColor),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : CircularProgressIndicator(),
      );

  Widget videoField2() => Center(
        child: _controller1.value.isInitialized
            ? DottedBorder(
                color: WebColor.textColor,
                dashPattern: [8, 4],
                strokeWidth: 2,
                child: Container(
                  height: 400,
                  width: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: _controller2.value.aspectRatio,
                        child: VideoPlayer(_controller2),
                      ),
                      VideoProgressIndicator(
                        _controller2,
                        allowScrubbing: true,
                        padding: EdgeInsets.all(10),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _controller2.value.isPlaying
                                ? _controller2.pause()
                                : _controller2.play();
                          });
                        },
                        child: Container(
                          height: 24,
                          width: 24,
                          child: Image.asset(_controller2.value.isPlaying
                              ? 'assets/icons/pause.png'
                              : 'assets/icons/play.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : CircularProgressIndicator(),
      );

  Widget videoField3() => Center(
        child: _controller3.value.isInitialized
            ? DottedBorder(
                color: WebColor.textColor,
                dashPattern: [8, 4],
                strokeWidth: 2,
                child: Container(
                  height: 400,
                  width: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: _controller3.value.aspectRatio,
                        child: VideoPlayer(_controller3),
                      ),
                      VideoProgressIndicator(
                        _controller3,
                        allowScrubbing: true,
                        padding: EdgeInsets.all(10),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _controller3.value.isPlaying
                                ? _controller3.pause()
                                : _controller3.play();
                          });
                        },
                        child: Container(
                          height: 24,
                          width: 24,
                          child: Image.asset(_controller3.value.isPlaying
                              ? 'assets/icons/pause.png'
                              : 'assets/icons/play.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : CircularProgressIndicator(),
      );

  Widget imageField() => Container(
          child: DottedBorder(
        color: WebColor.textColor,
        dashPattern: [8, 4],
        strokeWidth: 2,
        child: Container(
            height: 400,
            width: 500,
            child: _pickedImage == null
                ? GestureDetector(
                    onTap: () {
                      _pickImage();
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            scale: 3,
                            'assets/icons/photo.png',
                            // fit: BoxFit.contain,
                          ),
                          Text(
                            'Choose an image',
                            style: TextStyle(
                                color: WebColor.textColor, fontSize: 40),
                          )
                        ],
                      ),
                    ),
                  )
                : kIsWeb
                    ? Image.memory(
                        webImage,
                        fit: BoxFit.contain,
                      )
                    : Image.file(
                        _pickedImage!,
                        fit: BoxFit.contain,
                      )),
      ));

  Widget header() => ShaderMask(
      shaderCallback: (Rect bounds) {
        return WebColor()
            .gradient
            .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
      },
      child: Text(
        'Videos',
        style: TextStyle(fontSize: 50, color: Colors.white),
      ));

  Widget buttonUploadImage() => ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(WebColor.buttonColor),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
          fixedSize: MaterialStateProperty.all(
              Size(170, 50)), // Đặt kích thước cố định
          elevation: MaterialStateProperty.all(5), // Độ cao của nút
          shadowColor: MaterialStateProperty.all(Colors.grey), // Màu bóng đổ
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Bo tròn góc nút
            ),
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.red.withOpacity(0.2); // Màu khi nhấn
              }
              return null; // Sử dụng màu mặc định cho các trạng thái khác
            },
          ),
        ),
        onPressed: () {
          _pickImage();
        },
        label: Text(
          'Upload Image',
          style: TextStyle(color: WebColor.textColor),
        ),
        icon: const Icon(
          Icons.upload,
          color: Colors.red,
        ),
      );

  Widget buttonRecognition() => ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(WebColor.buttonColor),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
          fixedSize: MaterialStateProperty.all(
              Size(170, 50)), // Đặt kích thước cố định
          elevation: MaterialStateProperty.all(5), // Độ cao của nút
          shadowColor: MaterialStateProperty.all(Colors.grey), // Màu bóng đổ
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Bo tròn góc nút
            ),
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.red.withOpacity(0.2); // Màu khi nhấn
              }
              return null; // Sử dụng màu mặc định cho các trạng thái khác
            },
          ),
        ),
        onPressed: () {},
        label: Text(
          'Recognition',
          style: TextStyle(color: WebColor.textColor),
        ),
        icon: Image.asset(
          'assets/icons/video.png',
          fit: BoxFit.cover,
          height: 25,
          width: 25,
        ),
      );

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selectedImage = File(image.path);
        setState(() {
          _pickedImage = selectedImage;
        });
      } else {
        log('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pickedImage = File('a');
        });
      } else {
        log('No image has been picked');
      }
    } else {
      log('Something went wrong');
    }
  }
}
