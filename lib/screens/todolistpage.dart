import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  TodoListPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child:TextField(
                      onChanged: onChanged,
                      onSubmitted: onSubmitted,
                      controller: emailController,
                      //keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Adicione uma tarefa",
                        hintText: "Exemplo: Estudar Flutter",
                        border: OutlineInputBorder(),
                        //errorText: "campo obrigatório",
                      ),
                      obscureText: true,
                      obscuringCharacter: ".",
                    ),

                  ),
                  ElevatedButton(
                    onPressed: entrar,
                    child: Text("entrar"),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  void entrar() {
    String text = emailController.text;
    print(text);
  }
}

void onChanged(String text) {
  print(text);
}

void onSubmitted(String text) {
  print(text);
}
