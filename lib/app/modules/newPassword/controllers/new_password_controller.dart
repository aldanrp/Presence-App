import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  var isObscure = true.obs;

  TextEditingController newPassC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  void newPassword() async {
    if (newPassC.text.isNotEmpty) {
      if (newPassC.text != "123456") {
        try {
          String email = auth.currentUser!.email!;

          await auth.currentUser!.updatePassword(newPassC.text);

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
              email: email, password: newPassC.text);

          Get.offAllNamed(Routes.HOME);
        } on FirebaseAuthException catch (e) {
          print(e.toString());
          if (e.code == 'weak-password') {
            Get.snackbar(
              "",
              "",
              backgroundColor: Colors.yellow.withOpacity(0.9),
              titleText: Text(
                "Peringatan",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              messageText: Text(
                "Password terlalu lemah.",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            );
            print('Password salah.');
          }
        } catch (e) {
          print("Password gagal diubah dengan error: " + e.toString());
          Get.snackbar(
            "",
            "",
            backgroundColor: Colors.redAccent,
            titleText: Text(
              "Terjadi Kesalahan",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            messageText: Text(
              "Password tidak dapat diubah, Mohon untuk mencoba kembali",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          );
        }
      } else {
        Get.snackbar(
          "",
          "",
          backgroundColor: Colors.redAccent,
          titleText: Text(
            "Terjadi Kesalahan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          messageText: Text(
            "Password baru harus di ubah.",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        );
      }
    } else {
      Get.snackbar(
        "",
        "",
        backgroundColor: Colors.redAccent,
        titleText: Text(
          "Terjadi Kesalahan",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        messageText: Text(
          "Password tidak boleh kosong.",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      );
    }
  }
}
