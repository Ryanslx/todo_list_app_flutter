import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../task_model.dart';
import 'add_tarefas.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key, required List tarefas});

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  List<Task> _tarefas = [];

  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  Future<void> _carregarTarefas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tarefasJson = prefs.getString('tarefas');

    if (tarefasJson != null) {
      List<dynamic> lista = json.decode(tarefasJson);
      setState(() {
        _tarefas = lista.map((e) => Task.fromMap(e)).toList();
      });
    }
  }

  Future<void> _salvarTarefas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> listaMap = _tarefas
        .map((t) => t.toMap())
        .toList();
    prefs.setString('tarefas', json.encode(listaMap));
  }

  void _abrirAddTarefaPage() async {
    final novaTarefa = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTarefaPage()),
    );

    if (novaTarefa != null) {
      setState(() {
        _tarefas.add(Task.fromMap(novaTarefa));
      });
      _salvarTarefas();
    }
  }

  void _removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    });
    _salvarTarefas();
  }

  void _toggleFeito(int index, bool? value) {
    setState(() {
      _tarefas[index].isDone = value ?? false;
    });
    _salvarTarefas();
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
      body: _tarefas.isEmpty
          ? const Center(child: Text("Nenhuma tarefa cadastrada"))
          : ListView.builder(
              itemCount: _tarefas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: _tarefas[index].isDone,
                    onChanged: (value) => _toggleFeito(index, value),
                  ),
                  title: Text(
                    _tarefas[index].title,
                    style: TextStyle(
                      decoration: _tarefas[index].isDone
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
