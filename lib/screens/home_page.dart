import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/goats_count_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final yearsTextEditingController = TextEditingController();
  late GoatsCountCubit goatsCountCubit;
  final countFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    initCubits();
    super.initState();
  }

  initCubits() {
    goatsCountCubit = context.read<GoatsCountCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Goat Count Example'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: countFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: yearsTextEditingController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.red,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.only(left: 6),
                    fillColor: Colors.transparent,
                    filled: true,
                    labelText: 'Enter years',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter years';
                    }
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    if (countFormKey.currentState!.validate()) {
                      int? years=int.tryParse(yearsTextEditingController.text);
                      if(years!=null){
                        goatsCountCubit.calculateTotalGoats(years);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error occur')));
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Calculate',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                BlocBuilder<GoatsCountCubit, int>(
                  builder: (context, countState) {
                    return countState < 0
                        ? const SizedBox()
                        : Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'Goats count after ${yearsTextEditingController.text} is ${countState}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
