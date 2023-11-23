
import 'package:brasil_fields/brasil_fields.dart';
import 'package:financas_pessoais_flutter/modules/conta/controllers/conta_controller.dart';
import 'package:financas_pessoais_flutter/modules/conta/models/conta_model.dart';
import 'package:financas_pessoais_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContaListPage extends StatelessWidget {
  const ContaListPage({super.key});

  @override
  Widget build(BuildContext context) {

  // final controller = Provider.of<ContaController>(context);
  final controller = context.watch<ContaController>();

  // final controller = Provider.of<ContaController>(context, listen: false);
  // final controller = context.read<ContaController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contas'),
      ),
      body: FutureBuilder(
          future: controller.findAll(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<Conta> data = snapshot.data!;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (ctx, index) => 
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Descrição', 
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(data[index].descricao ?? '-'),
                              const SizedBox(height: 8,),
                               Text('Data',style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),),
                              Text(data[index].data == null 
                                    ? '-' 
                                    : Utils.convertDate(data[index].data!)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text('Lançamento',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(data[index].createdAt == null ? '' : Utils.convertDate(data[index].createdAt!)),
                              const SizedBox(height: 8,),
                               Text('Valor',style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),),
                              Text(data[index].valor == null
                                    ? '-'
                                    : UtilBrasilFields.obterReal(data[index].valor!)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Card(
                    // child: ListTile(
                    //   title: Text(data[index].descricao),
                    //   trailing: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       IconButton(
                    //         onPressed: ()=>controller.edit(context,data[index]), 
                    //         icon: const Icon(
                    //           Icons.edit,
                    //           color: Colors.amber,
                    //         ),
                    //       ),
                    //       IconButton(
                    //         onPressed: ()=>controller.delete(data[index]), 
                    //         icon: const Icon(
                    //           Icons.delete,
                    //           color: Colors.red,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // ),
                );
              } else {
                return const Center(
                  child: Text("Erro ao buscar contas..."),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.create(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
