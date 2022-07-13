import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

        print(credential.user!.uid);

        print(credential);
        if (credential.user != null) {
          if (credential.user!.emailVerified == true) {
            if (passC.text == "123456") {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              print(passC.text);
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
              title: "Belum di verifikasi",
              middleText:
                  "Kamu belum verifikasi akun ini. Lakukan verifikasi pada email kamu.",
              actions: [
                OutlinedButton(
                  onPressed: () {
                    Get.back(); //untuk menutup dialog
                  },
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        await credential.user!.sendEmailVerification();
                        Get.back(); //untuk menutup dialog
                        Get.snackbar(
                          "",
                          "",
                          backgroundColor: Colors.green,
                          titleText: Text(
                            "Berhasil",
                            style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          messageText: Text(
                            "Email Verifikasi telah dikirimkan",
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        );
                      } catch (e) {
                        Get.back();
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
                            "Tidak dapat mengirim email harap hubungin admin.",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text("Kirim Ulang"))
              ],
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
