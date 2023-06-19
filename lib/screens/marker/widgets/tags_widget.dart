import 'package:easyplay_app/models/validator_model.dart';
import 'package:easyplay_app/widgets/inputs/custom_tags_form_field.dart';
import 'package:flutter/material.dart';
import '../../../constants/theme/theme_app.dart';

class TagsWidget extends StatefulWidget {

  final Function(List) onChangeTags;

  const TagsWidget({Key? key,
    required this.onChangeTags
  }) : super(key: key);

  @override
  _TagsWidgetState createState() => _TagsWidgetState();
}

class _TagsWidgetState extends State<TagsWidget> with ValidatorModelAppDefault {

  final GlobalKey<FormState> _formKeyTags = GlobalKey<FormState>();

  TextEditingController tagsController = TextEditingController();

  List tags = [];

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKeyTags,
        child:  Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomTagsFormField(
              hintText: '#tags',
              validator: validateTags,
              maxLength: 17,
              controller: tagsController,
              onPressed: () {
                if(_formKeyTags.currentState!.validate()){
                  setState(() {
                    tags.add(tagsController.text.replaceAll(' ', ''));
                    tagsController.text = '';
                  });
                  widget.onChangeTags(tags);
                }
              },
            ),
            SizedBox(
              height: 50,
              width: tags.length * 500,
              child: ListView.builder(
                  padding: const EdgeInsets.only(top: 15),
                  scrollDirection: Axis.horizontal,
                  itemCount: tags.length,
                  itemBuilder: (_, index) => Container(
                      height: 35,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: ThemeApp.themeMainColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              '#${tags[index]}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              softWrap: false,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Center(
                                child: IconButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  icon: const Icon(
                                    Icons.clear,
                                    size: 17,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      tags.remove(tags[index]);
                                    });
                                    widget.onChangeTags(tags);
                                  },
                                ),
                              )
                          ),
                        ],
                      )
                  )
              ),
            ),
          ],
        )
    );
  }
}