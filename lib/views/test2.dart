import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:web/components/image_input.dart';
import 'package:web/components/videos_output.dart';
import 'package:web/styles/web_colors.dart';
import 'package:web/widgets/header.dart';
import 'package:web/widgets/vertical_line.dart';


class Test2 extends StatefulWidget {
  const Test2({super.key});

  @override
  State<Test2> createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  late VideoPlayerController _controller1;
  late VideoPlayerController _controller2;
  late VideoPlayerController _controller3;
  late String titleVideo1;
  late String titleVideo2;
  late String titleVideo3;

  @override
  void initState() {
    super.initState();
    _controller1 = VideoPlayerController.asset(
      'web/assets/animal/v1_animal.mp4', // Đường dẫn tới video trong thư mục assets
    )..initialize().then((_) {
        setState(() {});
      });
    _controller1.addListener(() {
      setState(() {});
    });

    _controller2 = VideoPlayerController.asset(
      'web/assets/animal/v2_animal.mp4',
    )..initialize().then((_) {
        setState(() {});
      });
    _controller2.addListener(() {
      setState(() {});
    });

    _controller3 = VideoPlayerController.asset(
      'web/assets/animal/v3_animal.mp4',
    )..initialize().then((_) {
        setState(() {});
      });
    _controller3.addListener(() {
      setState(() {});
    });

    //  _controller1 = VideoPlayerController.asset(
    //   'web/assets/animal/v1_animal.mp4',
    // );
    // _controller2 = VideoPlayerController.asset(
    //   'web/assets/animal/v2_animal.mp4',
    // );
    // _controller3 = VideoPlayerController.asset(
    //   'web/assets/animal/v3_animal.mp4',
    // );

    titleVideo1 = 'v1_animal.mp4';
    titleVideo2 = 'v2_animal.mp4';
    titleVideo3 = 'v3_animal.mp4';
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
                          Row(
                            children: [
                              Text(
                                'Top 1: ',
                                style: TextStyle(
                                    color: WebColor.textColor, fontSize: 30),
                              ),
                              Text(
                                titleVideo1,
                                style: TextStyle(
                                    color: WebColor.text, fontSize: 30),
                              ),
                            ],
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
                          Row(
                            children: [
                              Text(
                                'Top 2: ',
                                style: TextStyle(
                                    color: WebColor.textColor, fontSize: 30),
                              ),
                              Text(
                                titleVideo2,
                                style: TextStyle(
                                    color: WebColor.text, fontSize: 30),
                              ),
                            ],
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
                          Row(
                            children: [
                              Text(
                                'Top 3: ',
                                style: TextStyle(
                                    color: WebColor.textColor, fontSize: 30),
                              ),
                              Text(
                                titleVideo3,
                                style: TextStyle(
                                    color: WebColor.text, fontSize: 30),
                              ),
                            ],
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
          'Top Video',
          style: TextStyle(color: WebColor.textColor),
        ),
        icon: Image.asset(
          'assets/icons/vid.png',
          fit: BoxFit.cover,
          height: 25,
          width: 25,
        ),
      );
}
