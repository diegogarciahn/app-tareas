import 'package:flutter/material.dart';

void alertError(BuildContext context,
    {String mensaje =
        'Ocurrio un error al realizar esta acción, intente de nuevo.'}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          mensaje,
          style: const TextStyle(fontSize: 18),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.all(10)),
            ),
            child: const Text('Aceptar',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}