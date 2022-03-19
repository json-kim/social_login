import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 로고 이미지
            ElevatedButton(onPressed: () {}, child: const Text('구글 로그인')),
            ElevatedButton(onPressed: () {}, child: const Text('애플 로그인')),
            ElevatedButton(onPressed: () {}, child: const Text('카카오 로그인')),
            ElevatedButton(onPressed: () {}, child: const Text('네이버 로그인')),
            ElevatedButton(onPressed: () {}, child: const Text('페이스북 로그인')),
            ElevatedButton(onPressed: () {}, child: const Text('트위터 로그인')),
            ElevatedButton(onPressed: () {}, child: const Text('야후 로그인')),
          ],
        ),
      ),
    );
  }
}
