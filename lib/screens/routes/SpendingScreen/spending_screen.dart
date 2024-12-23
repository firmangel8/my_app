import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:my_app/components/skeleton_list_item.dart';
import 'package:my_app/cubit/balance/balance_cubit.dart';

import 'package:my_app/dto/spendings.dart';
import 'package:my_app/screens/routes/SpendingScreen/spending_form_screen.dart';
import 'package:my_app/services/data_service.dart';
import 'package:my_app/utils/constants.dart';

class SpendingScreen extends StatefulWidget {
  const SpendingScreen({super.key});

  @override
  State<SpendingScreen> createState() => _SpendingScreenState();
}

class _SpendingScreenState extends State<SpendingScreen> {
  Future<List<Spendings>>? _spendings;
  // late bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _spendings =
        DataService.fetchSpendings(); // Call your data fetching function
  }

  Future<void> sendSpending(BalanceCubit balanceCubit, int spending) async {
    // setState(() {
    //   _isLoading = true;
    // });
    final response =
        await DataService.sendSpendingData(spending); // Get the Cubit
    if (response.statusCode == 201) {
      // setState(() {
      //   _isLoading = false;
      // });
      debugPrint("sending success");
      setState(() {
        _spendings = DataService.fetchSpendings();
      });
      balanceCubit.updateBalance(spending);
    } else {
      // setState(() {
      //   _isLoading = false;
      // });
      debugPrint("failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    final balanceCubit = BlocProvider.of<BalanceCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spendings'),
      ),
      body: Column(
        children: [
          FutureBuilder<List<Spendings>>(
            future: _spendings,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final dataList = snapshot.data!;
                return Expanded(
                  // Constrain height to available space
                  child: ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      final item = dataList[index];
                      return MyListItemWidget(item: item);
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'), // Handle errors
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => SpendingFormScreen(
              onSubmit: (spending) {
                sendSpending(balanceCubit, spending);
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyListItemWidget extends StatelessWidget {
  final Spendings item;

  const MyListItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${item.spending}'),
      subtitle: Text(formatDate.format(item.createdAt)),
      leading: const Icon(Icons.monetization_on),
    );
  }
}
