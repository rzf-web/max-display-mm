import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:max_display_app/helper/const.dart';
import 'package:max_display_app/helper/style_utils.dart';
import 'package:max_display_app/helper/validator.dart';
import 'package:max_display_app/view/login/login.controller.dart';
import 'package:max_display_app/view/login/widget/app_remember_me.dart';
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
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 18.0),
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
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: AuthTextField(
                label: "Ip Address",
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
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: AppRememberMe(onChanged: (v) => controller.reMe = v),
            ),
          ],
        ),
      ),
    );
  }
}
