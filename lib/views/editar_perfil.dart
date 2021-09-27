import 'package:flutter/material.dart';

class EditarPerfilView extends StatelessWidget {
  const EditarPerfilView({ 
    Key? key,
    required this.titulo
  }) : super(key: key);

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar perfil')
      ),
      body: Container(
        child: Text(titulo),
      )
    );
  }
}