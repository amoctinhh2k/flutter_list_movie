import 'package:flutter/material.dart';
import 'package:flutter_list_movie/widgets/login_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(BackgroundVideo());

class BackgroundVideo extends StatefulWidget {
  @override
  _BackgroundVideoState createState() => _BackgroundVideoState();
}

class _BackgroundVideoState extends State<BackgroundVideo> {
  late VideoPlayerController _controller;
  late ImageCache img;
  @override
  void initState() {
    super.initState();
    _controller =
        // VideoPlayerController.network(
        //     "https://amt2020.000webhostapp.com/mp4/ironman.mp4")
        VideoPlayerController.asset("assets/intro/ironman.mp4")
          ..initialize().then((_) {
            _controller.play();
            _controller.setLooping(true);
            setState(() {});
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.fill,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
            LoginWidget()
          ],
        ),
      ),
    );
  }
}

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Lottie.asset(
              // 'https://assets2.lottiefiles.com/packages/lf20_96cnyxkh.json',
              "assets/img/login.json",
              width: 100,
              height: 100),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Widget_Login(),
      ],
    );
  }
}
