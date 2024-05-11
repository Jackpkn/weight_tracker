import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weight_tracker/src/app_exports.dart';
import 'package:weight_tracker/src/core/widgets/get_random_color.dart';
import 'package:weight_tracker/src/core/widgets/loader.dart';
import 'package:weight_tracker/src/features/weight/presentation/widgets/add_new_weight_dialog.dart';
import 'package:weight_tracker/src/features/weight/presentation/widgets/weight_list_card.dart';

class WeightListPage extends StatefulWidget {
  final String username;
  const WeightListPage({super.key, required this.username});

  @override
  State<WeightListPage> createState() => _WeightListPageState();
}

class _WeightListPageState extends State<WeightListPage> {
  final _weightController = TextEditingController();
  final _addNewWeightController = TextEditingController();
  final _addMonthController = TextEditingController();
  @override
  void initState() {
    context.read<WeightBloc>().add(
          GetAllWeightEntries(
            widget.username,
          ),
        );
    super.initState();
  }

  @override
  void deactivate() {
    _addNewWeightController.dispose();
    _weightController.dispose();
    _addMonthController.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ReusableText(
          text: AppTexts.weightTracker,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              context.read<WeightBloc>().add(
                    GetSortedWeightEntriesWithTime(widget.username),
                  );
            },
          ),
        ],
      ),
      body: BlocBuilder<WeightBloc, WeightState>(
        builder: (context, state) {
          if (state is WeightInitial) {
            return const Loader();
          } else if (state is WeightLoaded) {
            return Padding(
              padding: AppCustomStyle.addScreenPadding,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 45,
                      child: Row(
                        children: [
                          Expanded(
                            child: ReusableTextFormField(
                              keyboardType: TextInputType.number,
                              hintText: AppTexts.enterNewWeight,
                              labelText: 'Enter number of months',
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return AppTexts.enterNewWeight;
                                }
                                return null;
                              },
                              controller: _addMonthController,
                            ),
                          ),
                          const SizedBox(width: 7),
                          InkWell(
                            onTap: () {
                              if (_addMonthController.text.isEmpty) {
                                showSnackBar(
                                    context, 'Please enter number of months');
                                FocusScope.of(context).unfocus();
                                return;
                              } else if (double.parse(
                                      _addMonthController.text) <=
                                  0) {
                                showSnackBar(
                                    context, 'Please enter a valid weight');
                                FocusScope.of(context).unfocus();
                                return;
                              }
                              context.push(
                                '/weight-chart',
                                extra: {
                                  'weights': state.weightEntries.isNotEmpty
                                      ? state.weightEntries
                                      : [],
                                  'numMonths': int.parse(
                                      _addMonthController.text.trim()),
                                },
                              );
                            },
                            child: GlobalContainer(
                              height: 45,
                              width: 50,
                              color: Colors.black,
                              borderWidth: 1,
                              borderRadius: BorderRadius.circular(5),
                              child: const Icon(Icons.area_chart_outlined),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.weightEntries.length,
                      itemBuilder: (context, index) {
                        final weight = state.weightEntries[index];

                        final colors = getRandomPredefinedColor(); // Gen
                        return WeightCard(
                          weight: weight!,
                          color: colors,
                          listOfWeights: state.weightEntries,
                          index: index,
                          weighController: _weightController,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is NoWeightFound) {
            return Center(
              child: ReusableText(
                text: AppTexts.noWeighFound,
              ),
            );
          } else if (state is WeightError) {
            return Center(
              child: ReusableText(
                text: 'Error: ${state.message}',
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNewWeight(
              context: context,
              weighController: _addNewWeightController,
              onTap: () {
                if (_addNewWeightController.text.isEmpty) {
                  showSnackBar(context, 'Please enter weight');
                  return;
                } else {
                  double weight = double.parse(_addNewWeightController.text);
                  if (weight <= 0) {
                    showSnackBar(context, 'Please enter a valid weight');
                    return;
                  } else if (weight < 10 || weight > 200) {
                    showSnackBar(
                        context, 'Weight should be in range between 10 to 200');
                    return;
                  }
                }
                context.read<WeightBloc>().add(
                      AddWeight(
                        WeightModel(
                          weight: double.parse(_addNewWeightController.text),
                          username: widget.username,
                          date: DateTime.now().subtract(Duration(days: 67)),
                        ),
                      ),
                    );
                Navigator.of(context).pop();
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
