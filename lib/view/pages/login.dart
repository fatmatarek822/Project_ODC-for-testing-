import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odcworkshop2/view/component/core/core_components.dart';
import 'package:odcworkshop2/view/pages/layout.dart';
import 'package:odcworkshop2/view/pages/register.dart';
import 'package:odcworkshop2/view_model/database/network/dio_helper.dart';
import 'package:odcworkshop2/view_model/login/login_cubit.dart';

import '../../view_model/database/network/end_points.dart';
import '../component/login/text_form_custom.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
         if(state is LoginSuccess)
         {
           print('Success');
           navigateAndFinish(context, LayoutScreen());
         }
        },
        builder: (context, state) {
          LoginCubit mycubit = LoginCubit().get(context);

          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OrangeText(),
                        const SizedBox(
                          height: 40,
                        ),
                       // Text("Login"),
                       // Text(mycubit.message),
                        const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        textCustom(
                          prefix: Icons.email_outlined,
                            controller: mycubit.emailController, type: TextInputType.emailAddress, label: 'Email'),

                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: textCustom(
                              type: TextInputType.visiblePassword,
                              label: 'Password',
                              controller: mycubit.passwordController,
                              isPassword: mycubit.get(context).isPassword,
                            suffix: mycubit.get(context).suffix,
                            suffixpressed: () {
                              mycubit.get(context)
                                  .ChangePasswordVisibility();
                            },
                              ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 30)),


                        DefaultElvatedButton(
                            text: 'Login', ontap: ()
                        {
                          mycubit.login();
                        }),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const [
                            Expanded(
                              child: Divider(
                                height: 5,
                                indent: 15,
                                endIndent: 15,
                                color: Colors.black26,
                              ),
                            ),
                            Text(
                              'OR',
                              style: TextStyle(fontSize: 15),
                            ),
                            Expanded(
                              child: Divider(
                                height: 5,
                                indent: 15,
                                endIndent: 15,
                                color: Colors.black26,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        Container(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton(onPressed: ()
                          {
                            navigateAndFinish(context, RegisterScreen());
                          }, child: Text('Sign Up', style: TextStyle(fontSize: 20),),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.orange,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            );

        },
      ),
    );
  }
}
