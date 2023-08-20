import 'package:counter_app_bloc/counter/bloc.dart';
import 'package:counter_app_bloc/counter/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_actions/quick_actions.dart';

import '../counter/state.dart';

class HomeScreen extends StatelessWidget {
  QuickActions quickActions = const QuickActions();

  late final CounterBloc _counterBloc;

  HomeScreen({CounterBloc? counterBloc}) {
    _counterBloc = counterBloc ?? CounterBloc();

    // _counterBloc
    //     .add(CounterIncrementEvent());

    setupQuickActions();
  }

  setupQuickActions() {
    quickActions.initialize((shortcutType) {
      if (shortcutType == 'actionopen') {
        print("Open button is pressed");
      } else if (shortcutType == "actionupload") {
        print("Upload button is pressed.");
      } else if (shortcutType == "actioncreate") {
        print("Create Button is pressed");
      }
      // More handling code...
    });
  }

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
                  if (state is CounterInitial) {
                    Container(
                        alignment: Alignment.center,
                        child: Column(children: [
                          ElevatedButton(
                              onPressed: () {
                                quickActions.setShortcutItems(<ShortcutItem>[
                                  ShortcutItem(
                                      type: 'actionopen',
                                      localizedTitle: 'Open My Files',
                                      icon: 'folder'),
                                  ShortcutItem(
                                      type: 'actionupload',
                                      localizedTitle: 'Upload New File',
                                      icon: 'folder'),
                                  ShortcutItem(
                                      type: 'actioncreate',
                                      localizedTitle: 'Create New File',
                                      icon: 'folder')
                                ]);
                              },
                              child: Text("Add Shortcut"))
                        ]));
                  }
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
                  return CallbackShortcuts(
                    bindings: <ShortcutActivator, VoidCallback>{
                      //activator: () {}
                      //ShortcutActivator activator = CharacterActivator('+');
                    },
                    child: Focus(
                      child: Column(
                        children: [
                          Text(String.fromEnvironment('SECRET_KEY'),
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              )), //String.fromEnvironment('SECRET_KEY')),
                          Text(
                            'Counter value: ${state.counter}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
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
