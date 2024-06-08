import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:web/common/video_paths.dart';
import 'package:web/components/image_input.dart';
import 'package:web/styles/web_colors.dart';
import 'package:web/widgets/header.dart';
import 'package:web/widgets/vertical_line.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  VideoPlayerController? _controller1;
  VideoPlayerController? _controller2;
  VideoPlayerController? _controller3;

  String titleVideo1 = '';
  String titleVideo2 = '';
  String titleVideo3 = '';

  String similarity1 = '';
  String similarity2 = '';
  String similarity3 = '';

  @override
  void initState() {
    super.initState();
    VideoPaths.paths.addListener(() {
      if (VideoPaths.paths.value.isNotEmpty) {
        _initializeVideoControllers(VideoPaths.paths.value);
      }
    });
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  Future<void> _initializeVideoControllers(List<String> videoPaths) async {
    if (videoPaths.length < 9) {
      print('Not enough video paths provided.');
      return;
    }

    // Giải phóng các controller cũ
    _disposeControllers();

    _controller1 = VideoPlayerController.asset(videoPaths[2])
      ..initialize().then((_) {
        setState(() {});
      });
    _controller1!.addListener(() {
      setState(() {});
    });

    _controller2 = VideoPlayerController.asset(videoPaths[5])
      ..initialize().then((_) {
        setState(() {});
      });
    _controller2!.addListener(() {
      setState(() {});
    });

    _controller3 = VideoPlayerController.asset(videoPaths[8])
      ..initialize().then((_) {
        setState(() {});
      });
    _controller3!.addListener(() {
      setState(() {});
    });

    // Cập nhật tiêu đề video
    setState(() {
      titleVideo1 = videoPaths[0];
      titleVideo2 = videoPaths[3];
      titleVideo3 = videoPaths[6];

      similarity1 = videoPaths[1];
      similarity2 = videoPaths[4];
      similarity3 = videoPaths[7];
    });
  }

  void _disposeControllers() {
    _controller1?.dispose();
    _controller2?.dispose();
    _controller3?.dispose();
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
                  ValueListenableBuilder<List<String>>(
                    valueListenable: VideoPaths.paths,
                    builder: (context, paths, child) {
                      // if (paths.isEmpty) {
                      //   return CircularProgressIndicator();
                      // }
                      return videoField();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget videoField() => Column(
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
                    style: TextStyle(color: WebColor.textColor, fontSize: 30),
                  ),
                  Text(
                    titleVideo1,
                    style: TextStyle(color: WebColor.text, fontSize: 30),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Độ tương đồng: ',
                    style: TextStyle(color: WebColor.textColor, fontSize: 30),
                  ),
                  Text(
                    similarity1,
                    style: TextStyle(color: WebColor.text, fontSize: 30),
                  ),
                ],
              ),
              videoEach1(),
              // VideosOutput(controller: _controller1),
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
                    style: TextStyle(color: WebColor.textColor, fontSize: 30),
                  ),
                  Text(
                    titleVideo2,
                    style: TextStyle(color: WebColor.text, fontSize: 30),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Độ tương đồng: ',
                    style: TextStyle(color: WebColor.textColor, fontSize: 30),
                  ),
                  Text(
                    similarity2,
                    style: TextStyle(color: WebColor.text, fontSize: 30),
                  ),
                ],
              ),
              videoEach2(),
              // VideosOutput(
              //   controller: _controller2!,
              // ),
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
                    style: TextStyle(color: WebColor.textColor, fontSize: 30),
                  ),
                  Text(
                    titleVideo3,
                    style: TextStyle(color: WebColor.text, fontSize: 30),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Độ tương đồng: ',
                    style: TextStyle(color: WebColor.textColor, fontSize: 30),
                  ),
                  Text(
                    similarity3,
                    style: TextStyle(color: WebColor.text, fontSize: 30),
                  ),
                ],
              ),
              videoEach3(),
              // VideosOutput(
              //   controller: _controller3,
              // ),
            ],
          ),
        ],
      );

  Widget videoEach1() => Center(
          child: DottedBorder(
        color: WebColor.textColor,
        dashPattern: [8, 4],
        strokeWidth: 2,
        child: Container(
            height: 450,
            width: 500,
            child: _controller1 != null && _controller1!.value.isInitialized
                ? videoPlay1()
                : Center(child: CircularProgressIndicator())),
      ));

  Widget videoPlay1() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: _controller1!.value.aspectRatio,
              child: VideoPlayer(_controller1!),
            ),
          ),
          VideoProgressIndicator(
            _controller1!,
            allowScrubbing: false,
            padding: EdgeInsets.all(10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _controller1!.value.isPlaying
                        ? _controller1!.pause()
                        : _controller1!.play();
                  });
                },
                child: Container(
                  height: 24,
                  width: 24,
                  child: Image.asset(_controller1!.value.isPlaying
                      ? 'web/assets/icons/pause.png'
                      : 'web/assets/icons/play.png'),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      );

  Widget videoEach2() => Center(
          child: DottedBorder(
        color: WebColor.textColor,
        dashPattern: [8, 4],
        strokeWidth: 2,
        child: Container(
            height: 450,
            width: 500,
            child: _controller1 != null && _controller1!.value.isInitialized
                ? videoPlay2()
                : Center(child: CircularProgressIndicator())),
      ));

  Widget videoPlay2() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: _controller2!.value.aspectRatio,
              child: VideoPlayer(_controller2!),
            ),
          ),
          VideoProgressIndicator(
            _controller2!,
            allowScrubbing: false,
            padding: EdgeInsets.all(10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _controller2!.value.isPlaying
                        ? _controller2!.pause()
                        : _controller2!.play();
                  });
                },
                child: Container(
                  height: 24,
                  width: 24,
                  child: Image.asset(_controller2!.value.isPlaying
                      ? 'web/assets/icons/pause.png'
                      : 'web/assets/icons/play.png'),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      );

  Widget videoEach3() => Center(
          child: DottedBorder(
        color: WebColor.textColor,
        dashPattern: [8, 4],
        strokeWidth: 2,
        child: Container(
            height: 450,
            width: 500,
            child: _controller1 != null && _controller1!.value.isInitialized
                ? videoPlay3()
                : Center(child: CircularProgressIndicator())),
      ));

  Widget videoPlay3() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: _controller3!.value.aspectRatio,
              child: VideoPlayer(_controller3!),
            ),
          ),
          VideoProgressIndicator(
            _controller3!,
            allowScrubbing: false,
            padding: EdgeInsets.all(10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _controller3!.value.isPlaying
                        ? _controller3!.pause()
                        : _controller3!.play();
                  });
                },
                child: Container(
                  height: 24,
                  width: 24,
                  child: Image.asset(_controller3!.value.isPlaying
                      ? 'web/assets/icons/pause.png'
                      : 'web/assets/icons/play.png'),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
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
        onPressed: () {
          setState(() {});
        },
        label: Text(
          'Top Video',
          style: TextStyle(color: WebColor.textColor),
        ),
        icon: Image.asset(
          'web/assets/icons/vid.png',
          fit: BoxFit.cover,
          height: 25,
          width: 25,
        ),
      );
}
