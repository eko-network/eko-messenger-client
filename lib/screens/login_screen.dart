import 'package:eko_messenger/providers/auth.dart';
import 'package:eko_messenger/utils/constants.dart' as c;
import 'package:eko_messenger/widgets/maybe_card.dart';
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

  Future<void> _handleLogin() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });
    FocusManager.instance.primaryFocus?.unfocus();

    final auth = ref.read(authProvider);

    try {
      await auth.login(
        email: emailController.text,
        password: passwordController.text,
        url: Uri.parse(serverController.text),
      );
      // GoRouter.of(context).go('/home');
    } catch (e) {
      debugPrint('$e');
      if (mounted) {
        ShadToaster.of(context).show(
          ShadToast(
            title: Text('Uh oh! Something went wrong'),
            description: Text('There was a problem with your request: $e'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: _handleLogin,
              child: SizedBox(
                width: 80,
                child: Center(
                  child: isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: ShadTheme.of(context).colorScheme.background,
                          ),
                        )
                      : const Text('Login'),
                ),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: AutofillGroup(
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
                    textInputAction: TextInputAction.next,
                    controller: serverController,
                  ),
                  const SizedBox(height: 16),
                  const Text('Email'),
                  const SizedBox(height: 6),
                  ShadInput(
                    placeholder: Text('user@example.com'),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                    controller: emailController,
                  ),
                  const SizedBox(height: 16),
                  const Text('Password'),
                  const SizedBox(height: 6),
                  ShadInput(
                    placeholder: const Text(''),
                    obscureText: obscure,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.password],
                    controller: passwordController,
                    onSubmitted: (_) => _handleLogin(),
                    trailing: ShadButton.ghost(
                      width: 24,
                      height: 24,
                      padding: EdgeInsets.zero,
                      child: Icon(
                        obscure ? LucideIcons.eyeOff : LucideIcons.eye,
                      ),
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
      ),
    );
  }
}
