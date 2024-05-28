import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:web/components/image_input.dart';
import 'package:web/components/videos_output.dart';
import 'package:web/styles/web_colors.dart';
import 'package:web/widgets/header.dart';
import 'package:web/widgets/vertical_line.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late VideoPlayerController _controller1;
  late VideoPlayerController _controller2;
  late VideoPlayerController _controller3;
  late Duration videoLength;
  late Duration videoPosition;

  @override
  void initState() {
    super.initState();
    try {
      // _controller1 = VideoPlayerController.asset(
      //   'web/assets/animal/v1_animal.mp4', // Đường dẫn tới video trong thư mục assets
      // )..initialize().then((_) {
      //     // Đảm bảo cập nhật giao diện sau khi khởi tạo video
      //     setState(() {
      //       videoLength = _controller1.value.duration;
      //     });
      //   });
      // _controller1.addListener(() {
      //   setState(() {
      //     videoPosition = _controller1.value.position;
      //     // Cập nhật trạng thái khi video thay đổi
      //   });
      // });

      // _controller2 = VideoPlayerController.asset(
      //   'web/assets/animal/v2_animal.mp4', // Đường dẫn tới video trong thư mục assets
      // )..initialize().then((_) {
      //     // Đảm bảo cập nhật giao diện sau khi khởi tạo video
      //     setState(() {
      //       log('kkk');
      //     });
      //   });
      // _controller2.addListener(() {
      //   setState(() {
      //     // Cập nhật trạng thái khi video thay đổi
      //   });
      // });

      // _controller3 = VideoPlayerController.asset(
      //   'web/assets/animal/v3_animal.mp4', // Đường dẫn tới video trong thư mục assets
      // )..initialize().then((_) {
      //     // Đảm bảo cập nhật giao diện sau khi khởi tạo video
      //     setState(() {
      //       log('kkk');
      //     });
      //   });
      // _controller3.addListener(() {
      //   setState(() {
      //     // Cập nhật trạng thái khi video thay đổi
      //   });
      // });
      _controller1 = VideoPlayerController.asset(
        'web/assets/animal/v1_animal.mp4', 
      );
      _controller2 = VideoPlayerController.asset(
        'web/assets/animal/v2_animal.mp4',
      );
      _controller3 = VideoPlayerController.asset(
        'web/assets/animal/v3_animal.mp4', 
      );
    } catch (e) {
      print(e.toString());
    }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller1.dispose();
  //   _controller2.dispose();
  //   _controller3.dispose();
  // }

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
              Header(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageInput(),
                  VerticalLine(),
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
                          // videoField1(),
                          VideosOutput(
                            controller: _controller1,
                          ),
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
                          // videoField2(),
                          VideosOutput(
                            controller: _controller2,
                          ),
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
                          // videoField3()
                          VideosOutput(
                            controller: _controller3,
                          ),
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
                          SizedBox(
                            width: 10,
                          ),
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
}
