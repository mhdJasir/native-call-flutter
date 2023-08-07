import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:train/getx/Instance_model.dart';
import 'package:train/getx/instance_controller.dart';

class GetXInstances extends StatefulWidget {
  const GetXInstances({super.key});

  @override
  State<GetXInstances> createState() => _GetXInstancesState();
}

class _GetXInstancesState extends State<GetXInstances> {
  InstanceModel selected = InstanceModel.instances.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(child: Container()),
                  Expanded(
                    flex: 3,
                    child: ListView.separated(
                      itemCount: InstanceModel.instances.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (c, i) => const SizedBox(
                        width: 50,
                      ),
                      itemBuilder: (context, i) {
                        final InstanceModel instance =
                            InstanceModel.instances[i];
                        final isSelected = selected == instance;
                        return SizedBox(
                          width: 80,
                          child: ElevatedButton(
                            onPressed: () {
                              selected = instance;
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isSelected ? Colors.green : Colors.black,
                            ),
                            child: Text(instance.name),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'You have pushed the button this many times:',
          ),
          GetBuilder<InstanceController>(
            key: UniqueKey(),
            tag: selected.name,
            builder: (_) {
              return Text(
                '${selected.controller.count}',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          selected.controller.increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
