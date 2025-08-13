import 'package:flutter/material.dart';
import '../../core/app_state.dart';
import '../../core/app_constants.dart';

/// Kayıt sayfası:
/// Başlık/renkler sabitten, login akışıyla aynı mantık.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _mailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;
  bool _obscure = true;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    final ok = await AppState.of(context).auth.register(
          _mailCtrl.text.trim(),
          _passCtrl.text,
        );

    setState(() => _loading = false);
    if (!mounted) return;

    if (ok) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kayıt başarısız'),
          backgroundColor: AppConstants.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.titleRegister)),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.pagePadding),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _mailCtrl,
                      decoration: const InputDecoration(
                        labelText: 'E-posta',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email_outlined, color: AppConstants.secondaryColor),
                      ),
                      validator: (v) => (v == null || v.isEmpty) ? 'E-posta gerekli' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _passCtrl,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        labelText: 'Şifre',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock_outline, color: AppConstants.secondaryColor),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => _obscure = !_obscure),
                          icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off,
                              color: AppConstants.secondaryColor),
                        ),
                      ),
                      validator: (v) => (v == null || v.length < 3) ? 'Min 3 karakter' : null,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppConstants.primaryColor,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _loading ? null : _submit,
                        child: _loading
                            ? const SizedBox(
                                width: 20, height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : const Text('Kayıt Ol'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
