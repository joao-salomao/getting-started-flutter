import 'package:getting_started/entities/car.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class CarVideoPage extends StatefulWidget {
  final Car car;

  CarVideoPage(this.car);
  @override
  _CarVideoPageState createState() => _CarVideoPageState();
}

class _CarVideoPageState extends State<CarVideoPage> {
  VideoPlayerController _controller;

  Car get car => widget.car;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(car.urlVideo)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car.nome),
      ),
      body: Center(
        child: _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(
                child: Text(
                  "Esse carro não possui um vídeo cadastrado",
                  style: TextStyle(fontSize: 20),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
