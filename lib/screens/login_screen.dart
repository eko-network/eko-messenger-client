import 'package:eko_messanger/providers/auth.dart';
import 'package:eko_messanger/utils/constants.dart' as c;
import 'package:eko_messanger/widgets/maybe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final serverController = TextEditingController(text: c.defaultUrl.toString());
  bool isLoading = false;
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    final auth = ref.read(authProvider);

    return Scaffold(
      body: Center(
        child: MaybeCard(
          border: ShadBorder.all(color: Colors.transparent),
          width: 400,
          title: Text('Login'),
          description: const Text('Sign in to your account'),
          footer: Align(
            alignment: Alignment.centerRight,
            child: ShadButton(
              enabled: !isLoading,
              child: isLoading
                  ? CircularProgressIndicator()
                  : const Text('Login'),
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                setState(() {
                  isLoading = true;
                });
                try {
                  await auth.login(
                    email: emailController.text,
                    password: passwordController.text,
                    url: Uri.parse(serverController.text),
                  );
                  // GoRouter.of(context).go('/home');
                } catch (e) {
                  debugPrint('$e');
                  if (context.mounted) {
                    ShadToaster.of(context).show(
                      ShadToast(
                        title: Text('Uh oh! Something went wrong'),
                        description: Text(
                          'There was a problem with your request: $e',
                        ),
                      ),
                    );
                  }
                } finally {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                const SizedBox(height: 16),
                const Text('Server Url'),
                const SizedBox(height: 6),
                ShadInput(
                  placeholder: Text(c.defaultUrl.toString()),
                  keyboardType: TextInputType.url,
                  controller: serverController,
                ),
                const SizedBox(height: 16),
                const Text('Email'),
                const SizedBox(height: 6),
                ShadInput(
                  placeholder: Text('user@example.com'),
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                ),
                const SizedBox(height: 16),
                const Text('Password'),
                const SizedBox(height: 6),
                ShadInput(
                  placeholder: const Text(''),
                  obscureText: obscure,
                  controller: passwordController,
                  trailing: ShadButton.ghost(
                    width: 24,
                    height: 24,
                    padding: EdgeInsets.zero,
                    child: Icon(obscure ? LucideIcons.eyeOff : LucideIcons.eye),
                    onPressed: () {
                      setState(() => obscure = !obscure);
                    },
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
