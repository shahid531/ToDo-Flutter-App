
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/crud_bloc/crud_bloc.dart';
import '../../bloc/crud_bloc/crud_event.dart';
import '../../bloc/crud_bloc/crud_state.dart';

class CrudUi extends StatefulWidget {
  const CrudUi({super.key});

  @override
  State<CrudUi> createState() => _CrudUiState();
}

class _CrudUiState extends State<CrudUi> {
  TextEditingController textEditingController = TextEditingController();
  var focusNode = FocusNode();

  @override
  void dispose() {
    textEditingController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ToDo',style: TextStyle(fontSize: 24,fontWeight:FontWeight.bold),),

          backgroundColor: Colors.orange,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
          child: Column(
            children: [
              BlocBuilder<CrudBloc,CrudState>(
                builder: (context, state) {

                  if(state is CrudUpdateState){
                    textEditingController.text=state.name;
                    return TextField(
                      controller: textEditingController,
                      style: const TextStyle(fontSize: 16,fontWeight: FontWeight.normal),
                      cursorColor: Colors.orange,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                       hintText: 'enter here',
                        hintStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.normal),

                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.orange)
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                        isDense: true,

                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.orange)
                        )

                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<CrudBloc, CrudState>(
                builder: (context, state) {
                  if (state is CrudUpdateState) {
                    return ElevatedButton(
                        onPressed: () {

                          if(state.isEditable){
                            if(textEditingController.text.isNotEmpty){
                              FocusScope.of(context).requestFocus(FocusNode());
                              context.read<CrudBloc>().add(CrudUpdateTextEvent(id: state.id, name: textEditingController.text.trim()));
                            }

                          }else{
                            if(textEditingController.text.isNotEmpty){
                              FocusScope.of(context).requestFocus(FocusNode());
                              context.read<CrudBloc>().add(CrudAddEvent(name: textEditingController.text.trim()));
                            }

                          }

                    }, child: Text(state.isEditable ? 'EDIT':'ADD',style: const TextStyle(fontWeight: FontWeight.w500),));
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<CrudBloc, CrudState>(
                builder: (context, state) {
                  if (state is CrudUpdateState) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.list?.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      state.list?[index]['name'].toString() ?? '',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        focusNode.requestFocus();
                                        context.read<CrudBloc>().add(
                                            CrudEditClickEvent(id: int.parse(state.list?[index]['id'].toString() ?? '0'), name: state.list?[index]['name'].toString() ?? ''));
                                      },
                                      child: const Icon(Icons.edit)),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        context.read<CrudBloc>().add(
                                            CrudDeleteByNameEvent(id: int.parse(state.list?[index]['id'].toString() ?? '0')));
                                      },
                                      child: const Icon(Icons.delete))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
