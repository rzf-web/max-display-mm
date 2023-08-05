import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:max_display_app/helper/const.dart';
import 'package:max_display_app/helper/style_utils.dart';
import 'package:max_display_app/helper/theme.dart';
import 'package:max_display_app/helper/validator.dart';
import 'package:max_display_app/view/login/login.controller.dart';
import 'package:max_display_app/widget/auth_textfield.dart';
import 'package:max_display_app/widget/custom_btn.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 24.0),
                  child: Image.asset(rzfLogo, height: 70),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 18.0),
                  child: Text(
                    "Selamat Datang. Silakan masukkan email dan password untuk login",
                  ),
                ),
                const _FormInput(),
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: _SaveIp(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Obx(
                    () => TemplateButton(
                      borderRadius: 4.0,
                      onTap: controller.login,
                      isLoading: controller.btnLoading.value,
                      child: const Text("Login", style: btnStyle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormInput extends GetView<LoginController> {
  const _FormInput();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Obx(
        () => Column(
          children: [
            if (!controller.connect.value)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: AuthTextField(
                  label: "Ip Addres",
                  hint: "Masukkan ip address",
                  keyForm: controller.ipFormKey,
                  keyboardType: TextInputType.number,
                  controller: controller.ipController,
                  isLoading: controller.isConnecting.value,
                  onChanged: controller.onChanged,
                  validator: ipValidator,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: AuthTextField(
                label: "Username",
                hint: "Masukkan username",
                controller: controller.usernameController,
                validator: (value) => emptyValidator("Username", value!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: AuthTextField(
                label: "Password",
                hint: "Masukkan password",
                isPassword: true,
                controller: controller.pwController,
                validator: (value) => emptyValidator("Password", value!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SaveIp extends GetView<LoginController> {
  const _SaveIp();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          const SizedBox(width: 12),
          SizedBox(
            height: 20,
            width: 20,
            child: Checkbox(
              value: controller.saveIp.value,
              onChanged: (_) => changeValue(),
              fillColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  return primaryColor;
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => changeValue(),
            child: const Text("Simpan Ip"),
          ),
        ],
      ),
    );
  }

  changeValue() {
    var value = !controller.saveIp.value;
    controller.saveIp.value = value;
  }
}
