import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controllers/controllers.dart';
import '../../providers/providers.dart';
import '../screens.dart';
import 'components/textfieldlogin.component.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  bool recordar = false;
  bool hidePass = true;

  IconData iconocontrasena = Icons.remove_red_eye_outlined;
  TextEditingController userTextController = TextEditingController(text: '');
  TextEditingController passTextController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final tema = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.grey[50],
              body: Stack(
                children: [
                  SizedBox(
                    height: size.height,
                    width: size.width,
                    child: OrientationBuilder(builder:
                        (BuildContext context, Orientation orientation) {
                      bool vertical = true;
                      orientation == Orientation.portrait
                          ? vertical = true
                          : vertical = false;
                      return SizedBox(
                        width: size.width,
                        height: size.height,
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            SizedBox(height: size.height * 0.2,),
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //       top: vertical
                            //           ? size.height * 0.15
                            //           : size.height * 0.04,
                            //       bottom: 5),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: [
                            //       Image.asset(
                            //         appAssets.logo,
                            //         height: vertical
                            //             ? size.height * 0.2
                            //             : size.height * 0.2,
                            //         // width: vertical ? size.width * 0.5 : size.width * 0.4,
                            //         fit: BoxFit.contain,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    'Ingrese sus credenciales para acceder al sistema.',
                                    style: GoogleFonts.sourceSansPro(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                    )),
                              ],
                            ),
                            loginTextField(
                                vertical,
                                size,
                                authProvider,
                                userTextController,
                                'Usuario',
                                Icons.person_outline,
                                () {}),
                            loginTextField(
                                vertical,
                                size,
                                authProvider,
                                passTextController,
                                'Contaseña',
                                secreto: authProvider.ocultarContrasena,
                                iconocontrasena, () {
                              if (iconocontrasena ==
                                  Icons.remove_red_eye_outlined) {
                                iconocontrasena = Icons.remove_red_eye;
                                authProvider.ocultarContrasena = false;
                              } else {
                                iconocontrasena = Icons.remove_red_eye_outlined;
                                authProvider.ocultarContrasena = true;
                              }
                            }, errorText: authProvider.textError),
                            SizedBox(
                              height: size.height * 0.32,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      AuthController.logincontroller(userTextController,
                                              passTextController, context)
                                          .then((value) {
                                        if (value) {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const HomeScreen()),
                                              (route) => false);
                                        }
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: tema.secondary,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.3,
                                            vertical: 12)),
                                    child: Text('Iniciar Sesión',
                                        style: GoogleFonts.lato(
                                            color: tema.onSecondary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: vertical
                                                ? size.width * 0.05
                                                : 18)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                  if (authProvider.loading)
                    Container(
                      color: Colors.black12,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04, vertical: 10),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 80,
                                width: 80,
                                child: CircularProgressIndicator(
                                  color: tema.primary,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Cargando, por favor espere un momento.',
                                style: GoogleFonts.poppins(),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          );
  }
}
