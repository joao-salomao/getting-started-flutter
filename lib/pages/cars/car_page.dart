import 'package:flutter/material.dart';
import 'package:getting_started/entities/car.dart';

class CarPage extends StatefulWidget {
  Car car;

  CarPage(this.car);

  @override
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.car.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            onSelected: _onClickPopupMenuItem,
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: "share", child: Text("Compartilhar")),
                PopupMenuItem(value: "edit", child: Text("Editar")),
                PopupMenuItem(value: "delete", child: Text("Deletar")),
              ];
            },
          )
        ],
      ),
      body: _body(),
    );
  }

  _body() => Center(child: Image.network(widget.car.urlFoto));

  void _onClickPopupMenuItem(String value) {
    switch (value) {
      case "share":
        break;
      case 'edit':
        break;
      case 'delete':
        break;
    }
  }
}
