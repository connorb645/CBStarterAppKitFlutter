import 'package:cb_app_starter_kit/cb_app_starter_kit.dart';
import 'package:cb_app_starter_kit/src/onboarding/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpFormView extends StatefulWidget {
  final SignUpViewModel viewModel;

  const SignUpFormView({Key? key, required this.viewModel}) : super(key: key);

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<SignUpViewModel>(
      create: (_) => SignUpViewModel(auth: auth),
      child: Consumer<SignUpViewModel>(
        builder: (_, viewModel, __) => SignUpFormView(
          viewModel: viewModel,
        ),
      ),
    );
  }

  @override
  _SignUpFormViewState createState() => _SignUpFormViewState();
}

class _SignUpFormViewState extends State<SignUpFormView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.viewModel.title,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: _buildColumnChildren(),
              ),
            ),
          ),
        ));
  }

  List<Widget> _buildColumnChildren() {
    List<Widget> c = [];

    c.addAll([
      _buildTitle(),
      SizedBox(height: 16.0),
      _buildEmailTextField(),
      SizedBox(height: 16.0),
      _buildPasswordTextField()
    ]);

    if (widget.viewModel.formType == SignUpFormType.signUp) {
      c.addAll([
        SizedBox(height: 16.0),
        _buildConfirmPasswordTextField(),
        SizedBox(height: 16.0),
        _buildPasswordRules(),
      ]);
    }

    c.addAll([SizedBox(height: 32.0), _buildBottomButtons()]);

    return c;
  }

  Widget _buildTitle() {
    return Text(
      "Welcome, Let's get started...",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 32.0,
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: "Email Address",
        hintText: "e.g. john.smith@gmail.com",
        errorText: widget.viewModel.emailErrorText,
        enabled: true,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: widget.viewModel.updateEmail,
      focusNode: _emailFocusNode,
      onEditingComplete: _onEmailEditingComplete,
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: "Password",
        errorText: widget.viewModel.passwordErrorText,
        enabled: true,
      ),
      autocorrect: false,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      obscureText: true,
      onChanged: widget.viewModel.updatePassword,
      focusNode: _passwordFocusNode,
      onEditingComplete: _onPasswordEditingComplete,
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return TextField(
      controller: _confirmPasswordController,
      decoration: InputDecoration(
        labelText: "Confirm Password",
        errorText: widget.viewModel.confirmPasswordErrorText,
        enabled: true,
      ),
      autocorrect: false,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      obscureText: true,
      onChanged: widget.viewModel.updateConfirmPassword,
      focusNode: _confirmPasswordFocusNode,
      onEditingComplete: _onConfirmPasswordEditingComplete,
    );
  }

  Widget _buildPasswordRules() {
    return Text(
      "Your password must contain at least 6 characters.",
      style: TextStyle(
        fontWeight: FontWeight.w200,
        fontSize: 12.0,
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CBButton(
          title: widget.viewModel.buttonTitle,
          backgroundColor: Colors.indigo,
          onPressed: () async {
            bool didSucceed = await widget.viewModel.submit(context);
            if (didSucceed) {
              Navigator.pop(context);
            }
          },
        ),
        TextButton(
          child: Text(widget.viewModel.formToggleButtonTitle),
          onPressed: widget.viewModel.toggleFormType,
        ),
        SizedBox(height: 16.0),
      ],
    );
  }

  void _onEmailEditingComplete() {
    final newFocus = _passwordFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _onPasswordEditingComplete() {
    final newFocus = _confirmPasswordFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _onConfirmPasswordEditingComplete() {
    // final newFocus = _passwordFocusNode;
    // FocusScope.of(context).requestFocus(newFocus);
    print("submit the form");
    FocusScope.of(context).unfocus();
  }
}
