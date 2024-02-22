import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pocketclinic_assignment/utils.dart';
import '../controller/api_controller.dart';
import '../resources.dart';
import '../screens.dart';

class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({super.key});

  @override
  State<LoginScreenPage> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast.init(context);
    _emailController.text = USER_EMAIL1;
    _passwordController.text = USER_PASSWORD1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   // TRY THIS: Try changing the color here to a specific color (to
        //   // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        //   // change color while the other colors stay the same.
        //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        //   // Here we take the value from the MyHomePage object that was created by
        //   // the App.build method, and use it to set our appbar title.
        //   title: const Text('Login'),
        // ),
        body: isWeb() ? webLoginPage() : mobileLoginPage());
  }

  Widget webLoginPage() {
    return (Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: const BoxDecoration(color: PrimaryTealColor),
          padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                WELCOME,
                style: TextStyle(
                    color: whiteColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                HELP_US,
                style: TextStyle(color: whiteColor, fontSize: 20),
              ),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
          width: MediaQuery.of(context).size.width * 0.4,
          child: getLoginUI(),
          // decoration: BoxDecoration(color: Colors.yellow),
        ),
      ],
    ));
  }

  Widget mobileLoginPage() {
    return getLoginUI();
  }

  Widget getLoginUI() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      // alignment: Alignment.center,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              "assets/images/logo/logo_blue.png",
              // height: 200,
              // width: 200,
            ),
          ),
          const Text(
            LOG_IN,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
            readOnly: true,
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
            readOnly: true,
          ),
          const SizedBox(height: 20.0),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              child: const Text(FORGOT_PASSWORD),
              onPressed: () {},
            ),
          ),
          Row(
            children: [
              const Text(DO_NOT_HAVE_ACCOUNT),
              TextButton(
                child: const Text(SIGN_UP),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: 60,
          ),
          SizedBox(
            width: double.infinity,
            // height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(LOG_IN),
              onPressed: () {
                onLoginPress(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void onLoginPress(BuildContext context) async {
    await DataProvider().handleLoginProcess();
    if(fToast==null){
      fToast = FToast();
      fToast.init(context);
    }
    fToast.showToast(
      child: AppUtils().getCustomToast(LOGGED_IN_SUCEESSFULLY),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const VisitScreenPage(),
      ),
    );
  }
}
