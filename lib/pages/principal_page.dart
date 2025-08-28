import 'package:flutter/material.dart';
import 'package:todo_list_app/pages/add_tarefas.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key, required List tarefas});

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  List<Map<String, dynamic>> _tarefas = [];

  void _abrirAddTarefaPage() async {
    final novaTarefa = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTarefaPage()),
    );

    if (novaTarefa != null) {
      setState(() {
        _tarefas.add(novaTarefa);
      });
    }
  }

  void _removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    });
  }

  void _toggleFeito(int index, bool? value) {
    setState(() {
      _tarefas[index]["feito"] = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: const [
            Icon(Icons.list, color: Colors.white, size: 35),
            SizedBox(width: 10),
            Text("Lista de Tarefas", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: _tarefas.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Checkbox(
              value: _tarefas[index]["feito"],
              onChanged: (value) => _toggleFeito(index, value),
            ),
            title: Text(
              _tarefas[index]["titulo"],
              style: TextStyle(
                decoration: _tarefas[index]["feito"]
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removerTarefa(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirAddTarefaPage,
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
