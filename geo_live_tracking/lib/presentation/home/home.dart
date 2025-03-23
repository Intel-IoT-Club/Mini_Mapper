import 'package:flutter/material.dart';
import 'package:geo_live_tracking/data_layer/maps_api.dart';
import 'package:geo_live_tracking/models/auto_complete_model.dart';
import 'package:geo_live_tracking/presentation/home/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _sourceController.dispose();
    _destinationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0), // Prevents overlap when keyboard is open
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Live Track Card
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Live Track',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Current Ride',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('From: Kashyapa bhavanam', style: TextStyle(fontSize: 16)),
                            const SizedBox(height: 8),
                            const Text('To: Elimadai', style: TextStyle(fontSize: 16)),
                            const SizedBox(height: 8),
                            const Text(
                              'Distance:',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: SizedBox(
                                width: 120,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text('Cancel'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Input Form - Scrollable Green Area
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'From',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          controller: _sourceController,
                          decoration: InputDecoration(
                            hintText: 'Source Location',
                            prefixIcon: const Icon(Icons.location_on_outlined, color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          ),
                          onTap: () {
                            Future.delayed(const Duration(milliseconds: 300), () {
                              _scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'To',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: SearchField2(),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Confirm',
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20), // Extra spacing for safe scrolling
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}

class SearchField2 extends StatelessWidget {
  const SearchField2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
        
            children: [
              Icon(Icons.navigation_outlined,color: Colors.grey,),
              Text("Destination",style: TextStyle(color: Colors.grey),),
            ],
          ),
          height: 50,),
      ),
    );
  }
}

class SearchFIeld extends StatelessWidget {
  const SearchFIeld({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Autocomplete(
      optionsBuilder: (textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        } else {
          MapsApi api = MapsApi();
          AutoCompleteModel text = await api.getAutoComplete(textEditingValue.text);
          return text.predictions!.map((e) => e.description!).toList();
        }
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          onSubmitted: (String value) {
            onFieldSubmitted();
          },
          decoration: InputDecoration(
            hintText: 'Destination',
            prefixIcon: const Icon(Icons.navigation_outlined, color: Colors.grey),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
          onTap: () {
            Future.delayed(const Duration(milliseconds: 300), () {
              _scrollController.animateTo(
                60,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            });
          },
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected,
          Iterable<String> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(20),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 40,
                maxHeight: 200,
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  return ListTile(
                    title: Text(option),
                    onTap: () {
                      onSelected(option);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
