import 'package:flutter/material.dart';
import 'package:flutter_chat_app/ui/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => MainViewModel(),
      child: const MainScreen(),
    );
  }

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 115),
                child: Text(
                  'Chat App',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              const UserIdTitleWidget(),
              const SizedBox(
                height: 50,
              ),
              const SearchIdTextFieldWidget(),
              const ChangeUserNameButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class UserIdTitleWidget extends StatelessWidget {
  const UserIdTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var userId = context.watch<MainViewModel>().userIdTitle;
    const image = AssetImage('images/picture.png');
    return Column(
      children: [
        const SizedBox(height: 175, width: 175, child: Image(image: image)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'ID: $userId',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ],
    );
  }
}

class SearchIdTextFieldWidget extends StatelessWidget {
  const SearchIdTextFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userName = context.select((MainViewModel value) => value.userName);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      child: SizedBox(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Name: $userName',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter chat id',
                labelStyle: TextStyle(color: Colors.black),
                suffixIcon: Icon(Icons.send_rounded),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  MainViewModel().getChatUserId(value);
                  Navigator.of(context)
                      .popAndPushNamed('/chat_screen', arguments: value);
                } else {
                  return;
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class ChangeUserNameButtonWidget extends StatelessWidget {
  const ChangeUserNameButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainViewModel>();
    return TextButton(
      onPressed: () {
        showBottomSheet(
            context: context,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            builder: (BuildContext context) {
              return Container(
                height: 200,
                color: Colors.white.withOpacity(0.5),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Column(
                    children: [
                      Text(
                        'What is your name ?',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        decoration: const InputDecoration(
                          label: Text('Your name'),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          model.changeUserName(value);
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Save name'),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      child: const Text('Change name'),
    );
  }
}
