import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_login/presentation/auth/auth_event.dart';
import 'package:social_login/presentation/auth/auth_view_model.dart';
import 'package:social_login/presentation/home/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text('홈 화면'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('${viewModel.user.photoUrl}'),
            Text('${viewModel.user.userName} 님 안녕하세요'),
            ElevatedButton(
              onPressed: () {
                context.read<AuthViewModel>().onEvent(
                      const AuthEvent.logout(),
                    );
              },
              child: const Text('로그아웃'),
            ),
          ],
        ),
      ),
    );
  }
}
