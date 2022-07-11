import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  var isObscure = true.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  void Login() async {
    //check value is null or not
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      // code to firebase
      try {
        final credential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );

        print(credential);
        if (credential.user != null) {
          if (credential.user!.emailVerified == true) {
            Get.offAllNamed(Routes.HOME);
          } else {
            Get.defaultDialog(
              title: "Belum di verifikasi",
              middleText:
                  "Kamu belum verifikasi akun ini. Lakukan verifikasi pada email kamu.",
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar("Terjadi kesalahan", "User tidak Ditemukan");
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Terjadi kesalahan", "Password salah");
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        Get.snackbar("Terjadi kesalahan", "Tidak dapat login");
        print('User tidak dapat login : ' + e.toString());
      }
    } else {
      //something in null
      Get.snackbar("Terjadi kesalahan", "Email atau Password salah");
    }
  }
}
