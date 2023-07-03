import 'package:DrBalcony/inputbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;

  CustomForm({
    required this.userNameController,
    required this.passwordController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: Builder(
        builder: (BuildContext context) {
          if (Theme.of(context).platform == TargetPlatform.android) {
            return _buildCupertinoForm(context);
          } else {
            return _buildMaterialForm(context);
          }
        },
      ),
    );
  }

  Widget _buildCupertinoForm(BuildContext context) {
    return CupertinoFormSection(
      children: [
        CupertinoTextFormFieldRow(
          controller: userNameController,
          prefix: Icon(CupertinoIcons.person_solid),
          placeholder: "Username",
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
        ),
        CupertinoTextFormFieldRow(
          controller: passwordController,
          obscureText: true,
          prefix: Icon(CupertinoIcons.lock_fill),
          placeholder: "Password",
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          onEditingComplete: onSubmit,
        ),
      ],
    );
  }

  Widget _buildMaterialForm(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: userNameController,
          decoration: inputTheme(
              context, "Enter your UserName", "UserName", Icon(Icons.person)),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: passwordController,
          decoration: inputTheme(
              context, "Enter your Password", "password", Icon(Icons.lock)),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          onEditingComplete: onSubmit,
        ),
      ],
    );
  }
}
