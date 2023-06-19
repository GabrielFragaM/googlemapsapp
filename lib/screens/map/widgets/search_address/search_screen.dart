import 'dart:convert';
import 'package:easyplay_app/constants/app_config/app_config.dart';
import 'package:easyplay_app/models/marker_model.dart';
import 'package:easyplay_app/widgets/texts/custom_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../widgets/appbar/custom_app_bar.dart';
import '../../../../widgets/inputs/custom_text_form_field.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);


  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List _results = [];
  
  _searchAddress(String address) async {
    String query = address;
    String url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$query&key=XXXX';

    final response = await http.get(Uri.parse(url));
    final decodedJson = json.decode(response.body);

    setState(() {
      _results = decodedJson['results'];
    });
  }

  _onSelectAddress(double lat, double lng){
    setState(() {
      MarkerModel.goToSelectedAddress = {
        'latitude': lat,
        'longitude': lng
      };
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(45),
              child: CustomAppBar(
                title: 'buscar endereço',
              )
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: AppConfig.paddingLeft, right: AppConfig.paddingRight, top: 10),
            children: [
              CustomTextFormField(
                hintText: 'endereço',
                onChanged: (String value){
                  _searchAddress(value);
                },
              ),
              _results.isEmpty ?
              Padding(
                padding: const EdgeInsets.only(top: 155),
                child: Column(
                  children: const [
                    Icon(Icons.apartment, size: 60, color: Colors.grey,),
                    CustomText(
                      text: 'nenhum endereço encontrado.',
                      fontColor: Colors.grey,
                    )
                  ],
                ),
              ) :
              ListView.builder(
                shrinkWrap: true,
                itemCount: _results.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_results[index]['formatted_address']),
                    onTap: () {
                      final result = _results[index]['geometry']['location'];
                      _onSelectAddress(result['lat'], result['lng']);
                    },
                  );
                },
              )
            ],
          ),
        )
    );
  }

}

