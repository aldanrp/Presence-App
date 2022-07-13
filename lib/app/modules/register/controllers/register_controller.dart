import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController nipC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void prosesAddPegawai() async {
    print("add pegawai");
    try {
      String emailAdmin = auth.currentUser!.email!;

      final adminCredential = await auth.signInWithEmailAndPassword(
        email: emailAdmin,
        password: passAdminC.text,
      );

      final credential = await auth.createUserWithEmailAndPassword(
        email: emailC.text,
        password: "123456",
      );

      final user = auth.currentUser;
      if (user?.uid != null) {
        String uid = user!.uid;

        await firestore.collection("pegawai").doc(uid).set({
          "nip": nipC.text,
          "name": nameC.text,
          "email": emailC.text,
          "uid": uid,
          "createAt": DateTime.now().toIso8601String(),
        });

        await user.sendEmailVerification();

        await auth.signOut();

        final adminCredential = await auth.signInWithEmailAndPassword(
          email: emailAdmin,
          password: passAdminC.text,
        );

        Get.snackbar(
          "",
          "",
          titleText: Text(
            "BERHASIL",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.greenAccent,
          messageText: Text(
            "Data berhasil di input !!",
            style: TextStyle(
              fontSize: 16,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
          icon: Icon(Icons.check),
        );
      }

      print(credential);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'weak-password') {
        Get.snackbar(
            "Terjadi Kesalahan", "Password yang digunakan terlalu lemah");
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Terjadi Kesalahan", "Email sudah terdaftar");
        print('The account already exists for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Terjadi Kesalahan", "Password salah");
      } else {
        Get.snackbar("Terjadi Kesalahan", "${e.code}");
      }
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan",
          "Tidak dapat menambahkan akun, Harap dicoba kembali");
      print(e);
    }
  }

  void addPegawai() async {
    if (nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        nipC.text.isNotEmpty) {
      if (passAdminC.text.isEmpty) {
        Get.defaultDialog(
          title: "Validasi admin",
          content: Column(
            children: [
              Text("Masukan password untuk validasi admin"),
              TextFormField(
                autocorrect: false,
                obscureText: true,
                controller: passAdminC,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              )
            ],
          ),
          actions: [
            OutlinedButton(
              onPressed: () => Get.back(),
              child: Text("CANCEL"),
            ),
            ElevatedButton(
                onPressed: () {
                  prosesAddPegawai();
                },
                child: Text("ADD PEGAWAI"))
          ],
        );
      } else {
        prosesAddPegawai();
      }
    } else {
      Get.snackbar(
          "Terjadi Kesalahan", "NIP, Nama, dan Email tidak boleh kosong");
    }
  }
}
