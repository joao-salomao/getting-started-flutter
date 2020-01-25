import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getting_started/entities/car.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:getting_started/services/api/api.dart';
import 'package:getting_started/services/api/cars_api.dart';
import 'package:getting_started/widgets/app_alert.dart';
import 'package:getting_started/widgets/app_raised_button.dart';
import 'package:getting_started/widgets/app_text_form_field.dart';

class CarFormPage extends StatefulWidget {
  final Car car;

  CarFormPage({this.car});

  @override
  State<StatefulWidget> createState() => _CarFormPageState();
}

class _CarFormPageState extends State<CarFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final tNome = TextEditingController();
  final tDesc = TextEditingController();
  final tTipo = TextEditingController();

  int _radioIndex = 0;

  var _showProgress = false;

  Car get car => widget.car;

  // Add validate email function.
  String _validateNome(String value) {
    if (value.isEmpty) {
      return 'Informe o nome do carro.';
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    // Copia os dados do carro para o form
    if (car != null) {
      tNome.text = car.nome;
      tDesc.text = car.descricao;
      _radioIndex = getTipoInt(car);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          car != null ? car.nome : "Novo Car",
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: _form(),
      ),
    );
  }

  _form() {
    return Form(
      key: this._formKey,
      child: ListView(
        children: <Widget>[
          _headerFoto(),
          Text(
            "Clique na imagem para tirar uma foto",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Divider(),
          Text(
            "Tipo",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
          _radioTipo(),
          Divider(),
          AppTextFormField(
            'Nome',
            '',
            controller: tNome,
            keyboardType: TextInputType.text,
            validator: _validateNome,
          ),
          SizedBox(
            height: 16,
          ),
          AppTextFormField(
            'Descrição',
            '',
            controller: tDesc,
            keyboardType: TextInputType.text,
          ),
          SizedBox(
            height: 16,
          ),
          AppRaisedButton(
            car == null ? "Salvar" : "Atualizar",
            isLoading: _showProgress,
            onPressed: _onClickSalvar,
          ),
        ],
      ),
    );
  }

  _headerFoto() {
    return car != null
        ? CachedNetworkImage(
            imageUrl: car.urlFoto ?? "https://cdn.europosters.eu/image/750/posters/cars-3-mcqueen-race-i47515.jpg",
          )
        : Image.asset(
            "assets/images/camera.png",
            height: 150,
          );
  }

  _radioTipo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          value: 0,
          groupValue: _radioIndex,
          onChanged: _onClickTipo,
        ),
        Text(
          "Clássicos",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
        Radio(
          value: 1,
          groupValue: _radioIndex,
          onChanged: _onClickTipo,
        ),
        Text(
          "Esportivos",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
        Radio(
          value: 2,
          groupValue: _radioIndex,
          onChanged: _onClickTipo,
        ),
        Text(
          "Luxo",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
      ],
    );
  }

  void _onClickTipo(int value) {
    setState(() {
      _radioIndex = value;
    });
  }

  getTipoInt(Car carro) {
    switch (carro.tipo) {
      case "classicos":
        return 0;
      case "esportivos":
        return 1;
      default:
        return 2;
    }
  }

  String _getTipo() {
    switch (_radioIndex) {
      case 0:
        return "classicos";
      case 1:
        return "esportivos";
      default:
        return "luxo";
    }
  }

  _onClickSalvar() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      _showProgress = true;
    });

    if (car == null) {
      await _saveCar();
    } else {
      await _updateCar();
    }

    setState(() {
      _showProgress = false;
    });
  }

  _updateCar() async {
    car.nome = tNome.text;
    car.descricao = tDesc.text;
    car.tipo = _getTipo();

    ApiResponse<Car> response = await CarsApi.update(car);

    if (response.ok) {
      alert(context, "Sucesso", "O carro foi atualizado com sucesso");
    } else {
      alert(context, "Algo deu errado", response.message);
    }
  }

  _saveCar() async {
    // Cria o carro
    var c = new Car();
    c.nome = tNome.text;
    c.descricao = tDesc.text;
    c.tipo = _getTipo();

    ApiResponse<Car> response = await CarsApi.create(c);

    if (response.ok) {
      alert(context, "Sucesso", "O carro foi salvo com sucesso");
    } else {
      alert(context, "Algo deu errado", response.message);
    }
  }
}
