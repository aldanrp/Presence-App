import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChangePassword'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Obx(
            () => TextField(
              autocorrect: false,
              controller: controller.newPassC,
              obscureText: controller.isObscure.value,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(controller.isObscure.value
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    controller.isObscure.value = !controller.isObscure.value;
                  },
                ),
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              controller.newPassword();
            },
            child: Text("Change Password"),
          ),
        ],
      ),
    );
  }
}
