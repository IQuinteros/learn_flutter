import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/views/editar_perfil.dart';

class DatosView extends StatefulWidget {
  const DatosView({ Key? key }) : super(key: key);

  @override
  State<DatosView> createState() => _DatosViewState();
}

class _DatosViewState extends State<DatosView> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    CollectionReference collection = FirebaseFirestore.instance.collection('testingDelivery');

    
    return Scaffold(
      appBar: AppBar(
        title: Text('DATOS')
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Image(
                  image: NetworkImage('https://img.blogs.es/anexom/wp-content/uploads/2020/08/Ascii.jpg'),
                ),
                ListTile(
                  title: Text('Home')
                ),
                ListTile(
                  title: Text('Mapa')
                ),
                CheckboxListTile(
                  value: value, 
                  onChanged: (newValue) => setState(() {
                    value = newValue ?? false;
                  })
                )
              ]
            )
          ),
        )
      ),
      body: FutureBuilder(
        future: collection.get(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.done:
              return SingleChildScrollView(
                child: Column(
                  children: snapshot.data!.docs.map<Widget>((documento) {
                    return ListTile(
                      leading: Icon(Icons.person_outline),
                      title: Text((documento.data() as Map<String, dynamic>)['name']),
                      subtitle: Text((documento.data() as Map<String, dynamic>)['lastName']),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditarPerfilView(
                          titulo: (documento.data() as Map<String, dynamic>)['name']
                        )));
                      },
                      trailing: IconButton(
                        onPressed: () async {
                          await collection.doc(documento.id).update({
                            'name': 'OTRO NOMBRE'
                          });

                          setState((){});
                        },
                        icon: Icon(Icons.delete)
                      ),
                    );
                  }).toList()
                ),
              );
            default: return CircularProgressIndicator();
          }
        },
      )
    );
  }
}