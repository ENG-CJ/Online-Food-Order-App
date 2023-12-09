import 'package:flutter/material.dart';
import 'package:online_food_order_app/const/colors.dart';
import 'package:online_food_order_app/widgets/text_field.dart';

import '../../const/texts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 380,
            decoration: const BoxDecoration(
                // shape: BoxShape.circle,
                // color: Colors.blue,
                ),
            child: Stack(
              children: [
                Positioned(
                  top: -130,
                  right: 10,
                  // left: -60,
                  child: Container(
                    width: 500,
                    height: 500,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green[50],
                    ),
                  ),
                ),
                Positioned(
                  top: -10,
                  left: -20,
                  child: Image.asset(
                    'assets/burger.png',
                    width: 400,
                    height: 400,
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 20,),
          Container(
            padding: const EdgeInsets.only(left: 8.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loginTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  loginSubTitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Divider(),
                const SizedBox(
                  height: 20.0,
                ),
                const CustomField(
                  fielTitleTxt: emailTitle,
                  hintText: emailPlaceholder,
                ),
                const CustomField(
                  fielTitleTxt: passwordTitle,
                  hintText: passwordPlaceholder,
                  suffixIcon: Icon(Icons.remove_red_eye_rounded),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text.rich(TextSpan(
                      text: dontHaveAcc,
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(
                            text: signUp,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey)),
                      ])),
                ),

                const SizedBox(height: 10,),

                SizedBox(
                  width: double.infinity,

                  child: Container(
                    height: 65,
                    padding: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors['primary'],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)
                        )
                      ),
                      onPressed: () {},
                      child:  Text(
                        loginTitle,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: colors['body-color']
                        )),
                      ),
                  ),
                )

              ],
            ),
          )
        ],
      ),
    ));
  }
}
