import 'package:http/http.dart' as http;

import '../globals/widgets/widgets.dart';

Future<bool> verificarConexionAInternet() async {
  final cliente = http.Client();
  try {
  var response = await cliente.get(
      Uri.parse('https://www.google.com/'),
    ).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      return true;
    } else {
      return true;
    }
  } catch (e) {
    return false;
  } finally {
    cliente.close();
  }
  // try {
  //   final result = await InternetAddress.lookup('google.com');
  //   if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
  //     print(result);
  //   }
  //   return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  // } on SocketException catch (_) {
  //   return false;
  // }
}

Future manejoDeConexionAinternet(context) async {
  String mensaje = '';
      (await verificarConexionAInternet())
      ?mensaje = 'Tiempo de espera agotado. Es posible que el servicio no esté disponible en este momento, vuelva a intentar más tarde o contacte con soporte técnico.'
      :mensaje = 'Tiempo de espera agotado. Verifique de que cuenta con conexión a internet.';
      alertError(context, mensaje: mensaje);
  return mensaje;
}