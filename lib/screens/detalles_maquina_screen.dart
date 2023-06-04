import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:gymfo/widgets/appbar_widget.dart';
import 'package:video_player/video_player.dart';
import '../models/models.dart';

class DetallesMaquinaScreen extends StatefulWidget {
  final Cliente clienteActual;
  final Maquina maquina;
  final Color color;
  const DetallesMaquinaScreen({super.key, required this.maquina, required this.clienteActual, required this.color});

  @override
  State<DetallesMaquinaScreen> createState() => _DetallesMaquinaScreenState();
}

class _DetallesMaquinaScreenState extends State<DetallesMaquinaScreen> {
  late ChewieController _chewieController;

@override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.network(
          widget.maquina.video!),
          autoInitialize: true,
          aspectRatio: 16 / 9,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: appBar(context, widget.clienteActual, widget.color),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(top: BorderSide(
                width: 2,
                color: Colors.black
              )),
              color: widget.color
            ),
            child: Text(
              widget.maquina.nombre, style: TextStyle(fontSize: 32), textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.color,
                border: Border(bottom: BorderSide(
                width: 2,
                color: Colors.black
              )),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: Text(
                  widget.maquina.descripcion,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                  image: NetworkImage(widget.maquina.imagen),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
              ),
              child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Chewie(controller: _chewieController),
              ),
            ),
            SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
  }
}