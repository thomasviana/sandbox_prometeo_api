import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/auth/application.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == LinkStatus.linked) {
            Navigator.pushNamed(context, '/accounts');
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: ListView.separated(
                //     shrinkWrap: true,
                //     separatorBuilder: (context, index) => const SizedBox(height: 16),
                //     itemCount: state.authFields.length,
                //     itemBuilder: ((context, index) {
                //       return Column(
                //         children: [
                //           AuthTextField(
                //             hintText: state.authFields[index].labelEs,
                //             onChanged: (value) {},
                //           ),
                //         ],
                //       );
                //     }),
                //   ),
                // ),
                const SizedBox(height: 24),
                AuthTextField(
                  hintText: state.authFields[0].labelEs,
                  onChanged: (username) => context
                      .read<AuthBloc>()
                      .add(UsernameChanged(username: username)),
                ),

                AuthTextField(
                  hintText: state.authFields[1].labelEs,
                  onChanged: (password) => context
                      .read<AuthBloc>()
                      .add(PasswordChanged(password: password)),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                    onPressed: () =>
                        context.read<AuthBloc>().add(AuthStatusRequested()),
                    child: const Text('Link bank')),
                const SizedBox(height: 24),
                Text('Status: ${state.status}'),
              ],
            );
          }
        },
      ),
    );
  }
}

class AuthTextField extends StatefulWidget {
  final Function(String) onChanged;
  final String hintText;

  const AuthTextField({
    Key? key,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _controller,
        cursorColor: Colors.black45,
        autofocus: true,
        style: const TextStyle(color: Colors.black),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.black45),
          hintTextDirection: TextDirection.ltr,
          fillColor: Colors.black12,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        textAlign: TextAlign.center,
        onChanged: widget.onChanged,
        keyboardType: TextInputType.text,
      ),
    );
  }
}
