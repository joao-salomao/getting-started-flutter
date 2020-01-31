import 'package:flutter/material.dart';
import 'package:getting_started/entities/car.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:getting_started/pages/cars/car_form_page.dart';
import 'package:getting_started/services/api/api.dart';
import 'package:getting_started/services/api/cars_api.dart';
import 'package:getting_started/utils/navigation.dart';
import 'package:getting_started/widgets/app_alert.dart';
import 'car_video_page.dart';
import 'package:url_launcher/url_launcher.dart';

class CarPage extends StatefulWidget {
  static String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam illud quidem adduci vix possum, ut ea, quae senserit ille, tibi non vera videantur. Quamvis enim depravatae non sint, pravae tamen esse possunt. Minime vero istorum quidem, inquit. Sic enim censent, oportunitatis esse beate vivere. Sin est etiam corpus, ista explanatio naturae nempe hoc effecerit, ut ea, quae ante explanationem tenebamus, relinquamus. Duo Reges: constructio interrete. Esse enim quam vellet iniquus iustus poterat inpune. Quorum altera prosunt, nocent altera. Aperiendum est igitur, quid sit voluptas;Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam illud quidem adduci vix possum, ut ea, quae senserit ille, tibi non vera videantur. Quamvis enim depravatae non sint, pravae tamen esse possunt. Minime vero istorum quidem, inquit. Sic enim censent, oportunitatis esse beate vivere. Sin est etiam corpus, ista explanatio naturae nempe hoc effecerit, ut ea, quae ante explanationem tenebamus, relinquamus. Duo Reges: constructio interrete. Esse enim quam vellet iniquus iustus poterat inpune. Quorum altera prosunt, nocent altera. Aperiendum est igitur, quid sit voluptas;Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam illud quidem adduci vix possum, ut ea, quae senserit ille, tibi non vera videantur. Quamvis enim depravatae non sint, pravae tamen esse possunt. Minime vero istorum quidem, inquit. Sic enim censent, oportunitatis esse beate vivere. Sin est etiam corpus, ista explanatio naturae nempe hoc effecerit, ut ea, quae ante explanationem tenebamus, relinquamus. Duo Reges: constructio interrete. Esse enim quam vellet iniquus iustus poterat inpune. Quorum altera prosunt, nocent altera. Aperiendum est igitur, quid sit voluptas;Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam illud quidem adduci vix possum, ut ea, quae senserit ille, tibi non vera videantur. Quamvis enim depravatae non sint, pravae tamen esse possunt. Minime vero istorum quidem, inquit. Sic enim censent, oportunitatis esse beate vivere. Sin est etiam corpus, ista explanatio naturae nempe hoc effecerit, ut ea, quae ante explanationem tenebamus, relinquamus. Duo Reges: constructio interrete. Esse enim quam vellet iniquus iustus poterat inpune. Quorum altera prosunt, nocent altera. Aperiendum est igitur, quid sit voluptas;Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam illud quidem adduci vix possum, ut ea, quae senserit ille, tibi non vera videantur. Quamvis enim depravatae non sint, pravae tamen esse possunt. Minime vero istorum quidem, inquit. Sic enim censent, oportunitatis esse beate vivere. Sin est etiam corpus, ista explanatio naturae nempe hoc effecerit, ut ea, quae ante explanationem tenebamus, relinquamus. Duo Reges: constructio interrete. Esse enim quam vellet iniquus iustus poterat inpune. Quorum altera prosunt, nocent altera. Aperiendum est igitur, quid sit voluptas;";
  final Car car;

  CarPage(this.car);

  @override
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  Car get car => widget.car;
  String get loremIpsum => CarPage.loremIpsum;

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
            onPressed: _onClickShowVideo,
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
          CachedNetworkImage(
            imageUrl: car.urlFoto ??
                "https://cdn.europosters.eu/image/750/posters/cars-3-mcqueen-race-i47515.jpg",
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                Center(child: Icon(Icons.error)),
          ),
          _carHeader(),
          _carBody(),
        ],
      ),
    );
  }

  Row _carHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[_text(car.nome, bold: true), _text(car.tipo)],
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
    );
  }

  _carBody() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          _text("Descrição", bold: true),
          _text(
            loremIpsum,
            justify: true,
          )
        ],
      ),
    );
  }

  Text _text(String text, {bool bold = false, bool justify = false}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
      textAlign: justify ? TextAlign.justify : TextAlign.left,
    );
  }

  void _onClickPopupMenuItem(String value) {
    switch (value) {
      case "share":
        break;
      case 'edit':
        push(context, CarFormPage(car: car));
        break;
      case 'delete':
        _deleteCar(car);
        break;
    }
  }

  _deleteCar(Car car) async {
    ApiResponse response = await CarsApi.delete(car);
    if (response.ok) {
      alert(context, "Sucesso", "O carro foi deletado com sucesso",
          callback: () {
        Navigator.pop(context);
      });
    } else {
      alert(context, "Algo deu errado", response.message);
    }
  }

  void _onClickFavorite() {}

  void _onClickShare() {}

  void _onClickShowVideo() async {
    //push(context, CarVideoPage(car));
    var url = car.urlVideo;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      alert(context,"Erro", "Não foi possível abrir o vídeo");
    }
  }
}
