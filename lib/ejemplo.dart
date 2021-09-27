import 'package:flutter/material.dart';

class EjemploConEstadoWidget extends StatefulWidget {
  const EjemploConEstadoWidget({ Key? key }) : super(key: key);

  @override
  _EjemploConEstadoWidgetState createState() => _EjemploConEstadoWidgetState();
}

class _EjemploConEstadoWidgetState extends State<EjemploConEstadoWidget> {

  bool valorCheckbox = false;

  @override
  Widget build(BuildContext context) {

    return CheckboxListTile(
      title: Text('Mi checkbox'),
      value: valorCheckbox, 
      onChanged: (value){
        print(value);
       
        setState(() {
           valorCheckbox = value ?? false;
        });
      }
    );
  }
}