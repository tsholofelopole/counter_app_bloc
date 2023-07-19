import 'package:counter_app_bloc/counter/bloc.dart';
import 'package:counter_app_bloc/counter/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../counter/state.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Whole \'HomeScreen\' built');
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: BlocConsumer<CounterBloc, CounterState>(
                listener: (context, state) {
                  if (state is IncrementState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Successfully increased'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  }
                  if (state is DecrementState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Successfully decreased'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return Text(
                    'Counter value: ${state.counter}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context
                            .read<CounterBloc>()
                            .add(CounterDecrementEvent());
                      },
                      icon: Icon(Icons.remove),
                      label: Text('Decrease'),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context
                            .read<CounterBloc>()
                            .add(CounterIncrementEvent());
                      },
                      icon: Icon(Icons.add),
                      label: Text('Increase'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
