import 'package:flutter/material.dart';

class AddTarefaPage extends StatelessWidget {
  AddTarefaPage({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Tarefa"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Digite a tarefa",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  Navigator.pop(context, {
                    "title": _controller.text,
                    "isDone": false,
                  });
                }
              },
              child: const Text("Salvar", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
