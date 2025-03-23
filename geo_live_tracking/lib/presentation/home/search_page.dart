import 'package:flutter/material.dart';
import 'package:geo_live_tracking/data_layer/maps_api.dart';
import 'package:geo_live_tracking/models/auto_complete_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List places = [];

void searchPlace(String query)async{
  MapsApi api = MapsApi();
 AutoCompleteModel model = await api.getAutoComplete(query);
  setState(() {
    places = model.predictions!;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left:20.0,right: 20, top: 50),
        child: Column(
          children: [
            TextFormField(
            onChanged: (value) {
              if(value != ""){
                searchPlace(value);
              }
            },
          
            decoration: InputDecoration(
              hintText: 'Destination',
              prefixIcon: const Icon(Icons.navigation_outlined, color: Colors.grey),
              
              border:OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(width: 1,color: Colors.grey)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
        
          ),
          SizedBox(height: 20,),
          
          Expanded(
            child: ListView.builder(
              itemCount: places.length,
              itemBuilder: (context,index){
              return ListTile(
                title: Text(places[index].description!),
                onTap: (){
                  print('You just selected destination');
                },
              );
            }),
          )
          ],
        ),
      ),
    );
  }
}