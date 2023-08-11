import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_player/extentions.dart';
import 'package:video_player/video_player.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  late final VideoPlayerController controller =
      VideoPlayerController.asset('assets/example_video.mp4')
        ..initialize()
        ..setLooping(true)
        ..play();

  bool showControlPanel = false;

  Timer? timer;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void dispose() {
    widget.controller.dispose();
    widget.timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Stack(
            children: [
              Positioned(
                  top: 32,
                  right: 0,
                  left: 0,
                  /*
                  * Inkwell vs GestureDetector :
                  * اینکول یک ریپل افکتی داره که بعضی جاها جالب نیست.
                  * */
                  child: GestureDetector(
                    onTap: () {
                      if (!widget.showControlPanel) {
                        setState(() {
                          widget.showControlPanel = true;
                        });
                        initControlPanelTimer();
                      }
                    },
                    child: SizedBox(
                        width: double.infinity,
                        height: 300,
                        child: VideoPlayer(widget.controller)),
                  )),
              if (widget.showControlPanel)
                GestureDetector(
                    onTap: () {
                      if (widget.showControlPanel) {
                        setState(() {
                          widget.showControlPanel = false;
                        });
                        widget.timer?.cancel();
                      }
                    },
                    child: VideoControllPanel(controller: widget.controller))
            ],
          ),
        ),
      ),
    );
  }

  void initControlPanelTimer() {
    widget.timer?.cancel();
    widget.timer = Timer(const Duration(seconds: 5), () {
      setState(() {
        widget.showControlPanel = false;
      });
    });
  }
}

class VideoControllPanel extends StatefulWidget {
  VideoPlayerController controller;

  VideoControllPanel({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<VideoControllPanel> createState() => _VideoControllPanelState();
}

class _VideoControllPanelState extends State<VideoControllPanel> {
  @override
  Widget build(BuildContext context) {
    final Timer timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {});
    });

    return Positioned.fill(
        child: Container(
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(24.0),
                  child: Image.asset(
                    'assets/shark.jpg',
                    width: 54,
                    height: 54,
                    fit: BoxFit.fill,
                  )),
              const SizedBox(
                width: 16,
              ),
              const Text(
                'Sharky',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('The Earth', style: TextStyle(color: Colors.white)),
            const SizedBox(
              height: 4,
            ),
            const Text('پنجشنبه ۱۹ مرداد',
                style: TextStyle(color: Colors.white)),
            const SizedBox(
              height: 4,
            ),
            const Text('به یاد پویان', style: TextStyle(color: Colors.white)),
            const SizedBox(
              height: 4,
            ),
            /*
            * allowScrubbing :به کاربر اجازه میده با کلیک روی پروگرس بار جابه جا شه
            * */
            VideoProgressIndicator(
              widget.controller,
              allowScrubbing: true,
              colors: VideoProgressColors(
                  playedColor: Colors.white,
                  backgroundColor: Colors.white.withOpacity(0.5)),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.controller.value.position.toMinutesSeconds(),
                    style: TextStyle(color: Colors.white)),
                Text(widget.controller.value.duration.toMinutesSeconds(),
                    style: TextStyle(color: Colors.white)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {},
                    iconSize: 32,
                    icon: const Icon(
                      CupertinoIcons.backward_fill,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {},
                    iconSize: 56,
                    icon: Icon(
                      widget.controller.value.isPlaying
                          ? CupertinoIcons.pause_circle_fill
                          : CupertinoIcons.play_circle_fill,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {},
                    iconSize: 32,
                    icon: const Icon(
                      CupertinoIcons.forward_fill,
                      color: Colors.white,
                    )),
              ],
            )
          ])
        ],
      ),
    ));
  }
}
