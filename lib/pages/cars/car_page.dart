import 'package:flutter/material.dart';
import 'package:getting_started/entities/car.dart';

class CarPage extends StatefulWidget {
  Car car;

  CarPage(this.car);

  @override
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  Car get car => widget.car;

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

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          Image.network(car.urlFoto),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    car.nome,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    car.tipo,
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 35,
                    ),
                    onPressed: _onClickFavorite,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      size: 35,
                    ),
                    onPressed: _onClickShare,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

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

  void _onClickFavorite() {}

  void _onClickShare() {}
}
