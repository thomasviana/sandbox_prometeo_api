import 'package:flutter/material.dart';

class SelectBankScreen extends StatelessWidget {
  const SelectBankScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Link your bank'),
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomCard(
                    logoUrl:
                        'https://www.bancolombia.com/wcm/connect/b8e4c3f2-36a9-497d-a125-ac04f83b0bf8/LogoBancolombia.png?MOD=AJPERES',
                    title: 'Bancolombia',
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/auth',
                      arguments: 'test',
                    ),
                  ),
                  CustomCard(
                    logoUrl:
                        'https://pbs.twimg.com/profile_images/1002552048620134400/qZ1XCo_9_400x400.jpg',
                    title: 'Davivienda',
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/auth',
                      arguments: 'test',
                    ),
                  ),
                ],
              )),
        ],
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

class CustomCard extends StatelessWidget {
  final String logoUrl;
  final String title;
  final VoidCallback onTap;
  const CustomCard({
    Key? key,
    required this.logoUrl,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Image.network(logoUrl),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Personas',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
