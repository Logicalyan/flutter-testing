import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app_testing/login_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("Login Flow Integration Test", () {
    testWidgets("Login Flow - sukses", (tester) async {
      print("=== [INTEGRATION TEST] MULAI SKENARIO LOGIN SUKSES ===");

      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      print("[STEP] Render LoginPage selesai");

      await tester.enterText(find.byKey(const Key("emailField")), "user@mail.com");
      print("[STEP] Input email: user@mail.com");

      await tester.enterText(find.byKey(const Key("passwordField")), "123456");
      print("[STEP] Input password: 123456");

      await tester.tap(find.byKey(const Key("loginButton")));
      await tester.pumpAndSettle();
      print("[STEP] Tombol login ditekan, menunggu UI update");

      expect(find.textContaining("Login berhasil"), findsOneWidget);
      print("[RESULT] Pesan sukses ditemukan: 'Login berhasil dengan user@mail.com'");

      print("=== [INTEGRATION TEST] SKENARIO LOGIN SUKSES SELESAI ===");
    });

    testWidgets("Login Flow - gagal karena email kosong", (tester) async {
      print("=== [INTEGRATION TEST] MULAI SKENARIO LOGIN GAGAL (EMAIL KOSONG) ===");

      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      print("[STEP] Render LoginPage selesai");

      await tester.enterText(find.byKey(const Key("passwordField")), "123456");
      print("[STEP] Input password: 123456 (email kosong)");

      await tester.tap(find.byKey(const Key("loginButton")));
      await tester.pumpAndSettle();
      print("[STEP] Tombol login ditekan dengan email kosong");

      expect(find.text("Email tidak boleh kosong"), findsOneWidget);
      print("[RESULT] Pesan error ditemukan: 'Email tidak boleh kosong'");

      print("=== [INTEGRATION TEST] SKENARIO LOGIN GAGAL (EMAIL KOSONG) SELESAI ===");
    });

    testWidgets("Login Flow - gagal karena password terlalu pendek", (tester) async {
      print("=== [INTEGRATION TEST] MULAI SKENARIO LOGIN GAGAL (PASSWORD PENDEK) ===");

      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      print("[STEP] Render LoginPage selesai");

      await tester.enterText(find.byKey(const Key("emailField")), "user@mail.com");
      print("[STEP] Input email: user@mail.com");

      await tester.enterText(find.byKey(const Key("passwordField")), "123");
      print("[STEP] Input password: 123 (terlalu pendek)");

      await tester.tap(find.byKey(const Key("loginButton")));
      await tester.pumpAndSettle();
      print("[STEP] Tombol login ditekan dengan password pendek");

      expect(find.text("Password minimal 6 karakter"), findsOneWidget);
      print("[RESULT] Pesan error ditemukan: 'Password minimal 6 karakter'");

      print("=== [INTEGRATION TEST] SKENARIO LOGIN GAGAL (PASSWORD PENDEK) SELESAI ===");
    });
  });
}
