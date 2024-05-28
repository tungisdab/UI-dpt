import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:web/common/time_convert.dart';
import 'package:web/styles/web_colors.dart';

class VideosOutput extends StatefulWidget {
  final VideoPlayerController controller;

  const VideosOutput({super.key, required this.controller});

  @override
  State<VideosOutput> createState() => _VideosOutputState();
}

class _VideosOutputState extends State<VideosOutput> {
  late VideoPlayerController controller;
  late Duration videoLength;
  late Duration videoPosition;

 @override
  void initState() {
    super.initState();
    controller = widget.controller;
    // controller.initialize().then((_) {
    //   setState(() {
    //     videoLength = controller.value.duration;
    //     // videoPosition = controller.value.position;
    //   }); 
    // });
    controller.addListener(() {
      setState(() {
        videoLength = controller.value.duration;
        videoPosition = controller.value.position;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        videoField(),
      ],
    );
  }

  Widget videoField() => Center(
        child: controller.value.isInitialized
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
                        aspectRatio: controller.value.aspectRatio,
                        child: VideoPlayer(controller),
                      ),
                      VideoProgressIndicator(
                        controller,
                        allowScrubbing: false,
                        padding: EdgeInsets.all(10),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                controller.value.isPlaying
                                    ? controller.pause()
                                    : controller.play();
                              });
                            },
                            child: Container(
                              height: 24,
                              width: 24,
                              child: Image.asset(controller.value.isPlaying
                                  ? 'assets/icons/pause.png'
                                  : 'assets/icons/play.png'),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${TimeConvert.convertTime(videoPosition.inSeconds.toString())} / ${TimeConvert.convertTime(videoLength.inSeconds.toString())}',
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
}
