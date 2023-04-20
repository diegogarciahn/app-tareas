import 'dart:async';
import 'dart:io';

int getCodErrorService(Object e) {
  if (e is TimeoutException) {
    return 4500;
  }
  if (e is SocketException) {
    return 4501;
  }
  return 1200;
}
