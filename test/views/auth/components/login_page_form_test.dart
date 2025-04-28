import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery/views/auth/components/login_button.dart';
import 'package:mocktail/mocktail.dart';

import 'package:grocery/views/auth/components/login_page_form.dart';
import 'package:grocery/features/users/presentation/providers/user_provider_provider.dart'; // provider global
import 'package:grocery/features/users/presentation/providers/user_provider.dart'; // classe UserProvider
import 'package:grocery/features/users/domain/entities/user.dart';

// Mocks
class MockUserProvider extends Mock implements UserProvider {}
class _MockNavigatorObserver extends Mock implements NavigatorObserver {}
class FakeRoute extends Fake implements Route<dynamic> {}

void main() {
  late MockUserProvider mockUserProvider;
  late _MockNavigatorObserver navigatorObserver;

  setUpAll(() {
    registerFallbackValue(
      User(
        id: 0,
        name: 'no_name',
        email: 'no_email',
        password: 'no_password',
        phone: 'no_phone',
      ),
    );
    registerFallbackValue(FakeRoute());
  });

  setUp(() {
    mockUserProvider = MockUserProvider();
    navigatorObserver = _MockNavigatorObserver();
  });

  Future<void> pumpLoginPageForm(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userProvider.overrideWith((ref) => mockUserProvider),
        ],
        child: MaterialApp(
          home: Scaffold(body: SingleChildScrollView(child: LoginPageForm())),
          navigatorObservers: [navigatorObserver],
          routes: {
            '/entry_point': (context) => const Scaffold(body: Text('Home Page')),
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('LoginPageForm renders and allows input', (WidgetTester tester) async {
    when(() => mockUserProvider.currentUser).thenReturn(null);
    when(() => mockUserProvider.error).thenReturn(null);
    when(() => mockUserProvider.login(any())).thenAnswer((_) async {});

    await pumpLoginPageForm(tester);

    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123@');

    final loginButton = find.byType(LoginButton);
    expect(loginButton, findsOneWidget);

    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    verify(() => mockUserProvider.login(any())).called(1);
  });

  testWidgets('LoginPageForm navigates to home on successful login', (WidgetTester tester) async {
    when(() => mockUserProvider.currentUser).thenReturn(null);
    when(() => mockUserProvider.error).thenReturn(null);

    when(() => mockUserProvider.login(any())).thenAnswer((_) async {
      when(() => mockUserProvider.currentUser).thenReturn(
        User(
          id: 1,
          name: 'Test User',
          email: 'test@example.com',
          password: '',
          phone: '123456789',
        ),
      );
    });

    await pumpLoginPageForm(tester);

    await tester.enterText(find.byType(TextFormField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123@');

    await tester.tap(find.byType(LoginButton));
    await tester.pumpAndSettle();

    expect(find.text('Home Page'), findsOneWidget);
    verify(() => navigatorObserver.didPush(any(), any())).called(greaterThan(0));
  });

  // Teste simples corrigido, passando todos os parâmetros obrigatórios para User
  test('UserProvider mock login failure sets error', () async {
    when(() => mockUserProvider.error).thenReturn(null);

    when(() => mockUserProvider.login(any())).thenAnswer((_) async {
      when(() => mockUserProvider.error).thenReturn('Login failed');
    });

    await mockUserProvider.login(
      User(
        id: 0,
        name: 'no_name',
        email: 'bad@example.com',
        password: 'badpassword',
        phone: 'no_phone',
      ),
    );

    expect(mockUserProvider.error, 'Login failed');
  });
}


