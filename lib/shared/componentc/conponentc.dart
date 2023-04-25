import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../layout/todoapp/Cubit/Cubit.dart';
import '../styles/colors.dart';

//هنا انا عملت ويدجت سمتها تكست فورم فيلد كستم دخلت جوها واديتو التصميم الى انا عملتو وعيز اعمل منو تكرار هيقولى اي الى هيتغير الكونترولار علاشان دة الى بيتحكم فى الحاجه الى جوه التصميم
Widget TextFormFieldCusstom({
  required TextEditingController controller,
  var validator,
  required String label,
  var prifixIcon,
  var suffixIcon,
  var suffixPress,
  var OnTap,
}) =>
    TextFormField(
      //لازم اديلو حاجه اسمها كونترول علاشان يقدر يتحكم فيها واعملو داله فوق يكون فيها الكنترولا ريكويرد وده علاشان لازم تدخل
      controller: controller,
      //علاشان اقدر اعمل تغيير فى التصميم
      validator: validator,
      onTap: OnTap,
      //علاشان احدد الى هيتكتب فى المربع رقم او نص او
      //النص هيتغير لازم اعملو متغير
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        //الايقونه هيتغير لازم اعملو متغير
        prefix: Icon(
          prifixIcon,
        ),
        //علاشان اعمل علامه النص فى المربع على اليسار
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: suffixPress,
                icon: Icon(suffixIcon),
              )
            : null,
        border: OutlineInputBorder(
          //علاشا اخلى المستطيل الى هكتب فيه مدور
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            width: 1,
            color: Colors.white,
          ),
        ),
      ),
    );

Widget buildItem({
  context,
  required List<Map> task,
  required int index,
}) =>
    Dismissible(
      key: Key(task[index]["id"].toString()),
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.only(left: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.delete_forever_outlined,
              color: Colors.white,
              size: 30,
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        color: Colors.green,
        padding: EdgeInsets.only(left: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete_forever_outlined,
              color: Colors.white,
              size: 30,
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        TodoCubit.get(context).deleteData(id: task[index]["id"]);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: bLUYFoer, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Gold,
                  radius: 50,
                  child: Text(
                    task[index]['time'],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task[index]["title"],
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      task[index]["date"],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        TodoCubit.get(context).UPdetaDate(
                          status: "done",
                          id: task[index]["id"],
                        );
                        AudioCache audioCache = AudioCache();
                        final file =
                            await audioCache.loadAsFile('music/myzek3.mp3');
                        final bytes = await file.readAsBytes();
                        audioCache.playBytes(bytes);
                      },
                      child: CircleAvatar(
                        backgroundColor: Gold,
                        child: Icon(
                          Icons.done_outline_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        TodoCubit.get(context).UPdetaDate(
                          status: "Archive",
                          id: task[index]["id"],
                        );
                        AudioCache audioCache = AudioCache();
                        final file =
                            await audioCache.loadAsFile('music/Myzek4.mp3');
                        final bytes = await file.readAsBytes();
                        audioCache.playBytes(bytes);
                      },
                      child: CircleAvatar(
                        backgroundColor: Gold,
                        child: Icon(
                          Icons.archive,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

Widget ListTodo({
  required List<Map> task,
}) =>
    ListView.separated(
      itemBuilder: (context, index) => buildItem(
        context: context,
        index: index,
        task: task,
      ),
      separatorBuilder: (context, index) => Divider(),
      itemCount: task.length,
    );

Widget NewsItems({context,required List<dynamic>ItemNews,index})=>Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(25),
    ),
    child: Row(
      children: [
        Container(
          height: 120,
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${ItemNews[index]['title']}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Text("${ItemNews[index]['publishedAt']}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 15,),
        Container(
          child: Image.network("${ItemNews[index]['urlToImage']}",height: 100,width: 150,),
        ),
      ],
    ),
  ),
);

Widget ListNewsItem({context, required List<dynamic>task})=> ListView.builder(
  itemBuilder: (context, index) => NewsItems(
    context: context,
    index: index,
    ItemNews: task,
  ),
  itemCount:task.length ,
);
