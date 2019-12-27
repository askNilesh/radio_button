import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class GroupModel {
  String text;
  int index;
  bool selected;

  GroupModel({this.text, this.index, this.selected});
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  int _value2 = 0;
  List<GroupModel> _group = [
    GroupModel(text: "Andorid", index: 1, selected: true),
    GroupModel(text: "IOS", index: 2, selected: false),
    GroupModel(text: "Flutter", index: 3, selected: false),
  ];

  List<RadioModel> sampleData = new List<RadioModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sampleData.add(RadioModel(
        true, Icons.account_balance, 'Option A', Colors.blue, Colors.grey));
    sampleData.add(
        RadioModel(false, Icons.receipt, 'Option B', Colors.blue, Colors.grey));
    sampleData.add(RadioModel(
        false, Icons.account_circle, 'Option C', Colors.blue, Colors.grey));
    sampleData.add(RadioModel(
        false, Icons.shopping_cart, 'Option D', Colors.blue, Colors.grey));
  }

  Widget makeRadioTiles() {
    List<Widget> list = new List<Widget>();

    for (int i = 0; i < _group.length; i++) {
      list.add(Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
            color: _group[i].selected ? Colors.purple : Colors.green,
            borderRadius: BorderRadius.all(
                Radius.circular(10.0) //         <--- border radius here
                )),
        child: RadioListTile(
          value: _group[i].index,
          groupValue: _value2,
          selected: _group[i].selected,
          onChanged: (val) {
            setState(() {
              for (int i = 0; i < _group.length; i++) {
                _group[i].selected = false;
              }
              _value2 = val;
              _group[i].selected = true;
            });
          },
          activeColor: Colors.white,
          controlAffinity: ListTileControlAffinity.trailing,
          title: Text(
            ' ${_group[i].text}',
            style: TextStyle(
                color: _group[i].selected ? Colors.white : Colors.black,
                fontWeight:
                    _group[i].selected ? FontWeight.bold : FontWeight.normal),
          ),
        ),
      ));
    }

    Column column = Column(
      children: list,
    );
    return column;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RadioListTile Demo'),
      ),
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              makeRadioTiles(),
              SizedBox(
                height: 500,
                width: 500,
                child: CustomRadio(sampleData),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomRadio extends StatefulWidget {
  List<RadioModel> sampleData = List<RadioModel>();

  CustomRadio(this.sampleData);

  @override
  createState() {
    return CustomRadioState(sampleData);
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> sampleData = List<RadioModel>();

  CustomRadioState(this.sampleData);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sampleData.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          //highlightColor: Colors.red,
          splashColor: Colors.blueAccent,
          onTap: () {
            setState(() {
              sampleData.forEach((element) => element.isSelected = false);
              sampleData[index].isSelected = true;
            });
          },
          child: RadioItem(sampleData[index]),
        );
      },
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 50.0,
            width: 50.0,
            child: Center(
              child: Icon(
                _item.icon,
                color:
                    _item.isSelected ? _item.selectedColor : _item.defaultColor,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text(
              _item.text,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight:
                    _item.isSelected ? FontWeight.bold : FontWeight.normal,
                color:
                    _item.isSelected ? _item.selectedColor : _item.defaultColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final IconData icon;
  final String text;
  final Color selectedColor;
  final Color defaultColor;

  RadioModel(this.isSelected, this.icon, this.text, this.selectedColor,
      this.defaultColor);
}
