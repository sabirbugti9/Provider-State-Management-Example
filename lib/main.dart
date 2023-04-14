import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("Hello 12221");

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MyModel>(create: (context) => MyModel(),),
        ProxyProvider<MyModel,AnotherModel>(
          update: (context, myModel, anotherModel) => AnotherModel(myModel),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('My App')),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.all(20),
                      color: Colors.green[200],
                      child: Consumer<MyModel>(
                        //                    <--- Consumer
                        builder: (context, myModel, child) {
                          return ElevatedButton(
                            child: const Text('Do something'),
                            onPressed: () {
                              // We have access to the model.
                              myModel.doSomething("Do Something");
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) =>
                              //         const TestValueScreen()));
                            },
                          );
                        },
                      )),
                  Container(
                    padding: const EdgeInsets.all(35),
                    color: Colors.blue[200],
                    child: Consumer<MyModel>(
                      //
                      builder: (context, myModel, child) {
                        return Text(myModel.someValue);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      color: Colors.red[200],
                      child: Consumer<AnotherModel>(
                        //                    <--- Consumer
                        builder: (context, anothModel, child) {
                          return ElevatedButton(
                            child: const Text('Do something Else'),
                            onPressed: () {
                              // We have access to the model.
                              anothModel.doSomethingElse();
                            },
                          );
                        },
                      )),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Container(
              //         padding: const EdgeInsets.all(20),
              //         color: Colors.green[200],
              //         child: Consumer<AnotherModel>(
              //           //                    <--- Consumer
              //           builder: (context, anothModel, child) {
              //             return ElevatedButton(
              //               child: const Text('Do something'),
              //               onPressed: () {
              //                 // We have access to the model.
              //                 anothModel.doSomething();
              //               },
              //             );
              //           },
              //         )),
              //     Container(
              //       padding: const EdgeInsets.all(35),
              //       color: Colors.blue[200],
              //       child: Consumer<AnotherModel>(
              //         //
              //         builder: (context, myModel, child) {
              //           return Text(myModel.someValue.toString());
              //         },
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// Future<MyModel> someAsyncFunctionToGetMyModel() async {
//   //  <--- async function
//   await Future.delayed(const Duration(seconds: 5));
//   return MyModel(someValue: 'new data');
// }

// Stream<MyModel> getStreamOfMyModel() {
//   //                        <--- Stream
//   return Stream<MyModel>.periodic(
//       const Duration(seconds: 1), (x) => MyModel(someValue: '$x')).take(10);
// }

class MyModel extends ChangeNotifier {
  // MyModel({required this.someValue});
  //
  String someValue="Hello";
  void doSomething(String value) {
    someValue = value;
    notifyListeners();
    print(someValue);
  }
}

// class AnotherModel with ChangeNotifier {
//   //                   <--- AnotherModel
//   int someValue = 0;
//   void doSomething() {
//     someValue = 5;
//     print(someValue);
//     notifyListeners();
//   }
// }

class AnotherModel {
  //                                      <--- AnotherModel
  final MyModel _myModel;
  AnotherModel(this._myModel);
  void doSomethingElse() {
    _myModel.doSomething("Do something Else");
    print('doing something else');
  }
}
