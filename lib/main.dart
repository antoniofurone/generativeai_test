import 'package:flutter/material.dart';
import 'openai/oai_chat_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generative AI Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Generative AI Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController systemController = TextEditingController();
  TextEditingController promptController = TextEditingController();
  TextEditingController promptMaxNumToken = TextEditingController(text: '100');


  String? response;

  String? _selectedModel="gpt-4";
   
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(2),
            child: DropdownButton(
              hint: const Text("Model"),
              value: _selectedModel,
              items: <String>["gpt-4","gpt-3.5-turbo","gpt-3.5-turbo-0613"]
                        .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                             );
                          }).toList(), 
                          
                          onChanged: (String? value) {  
                                setState(() {
                                  _selectedModel = value;
                                });
                          },


              ),
            ),


          Padding(
            padding: const EdgeInsets.all(2),
            child: TextFormField(
              controller: systemController,
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: "System",
                hintText: "Enter your System here",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: TextFormField(
              controller: promptController,
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: "Prompt",
                hintText: "Enter your prompt here",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: TextFormField(
              controller: promptMaxNumToken,
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: "MaxNumToken",
                hintText: "Enter your MaxNumToken here",
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(2),
            
            child:SingleChildScrollView (
              scrollDirection: Axis.vertical,
            
              child: Text(
                response ?? "",
                style: TextStyle(
                  color: Colors.grey.shade800,
                  backgroundColor: const Color.fromARGB(255, 184, 159, 189)),
              ),

            )
          ),


          ElevatedButton(
              style: ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 80, vertical: 20)), backgroundColor: MaterialStateProperty.all(Colors.deepPurple)),
              onPressed: () async {
                response="";
                setState(() {});
                response = await OpenAiChatService().request(systemController.text,promptController.text,_selectedModel,int.parse(promptMaxNumToken.text));
                setState(() {});
              },
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}

