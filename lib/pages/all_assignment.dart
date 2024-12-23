import 'package:app/pages/assignment.dart';
import 'package:flutter/material.dart';

class AllAssignmentPage extends StatelessWidget {
  static const nameRoute = '/assignmentpage';
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment'),
        backgroundColor: Colors.blueAccent,
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
        actions: [  
          IconButton(onPressed: () {}, icon: Icon(Icons.add, color: Colors.white))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Closest Deadline', style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    )),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AssignmentPage())),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xfff4f4f5),
                    borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.red),
                              SizedBox(width: 10),
                              Text('Jaringan Saraf Tiruan', style: TextStyle(fontWeight: FontWeight.w500)),
                            ],
                          ),
                        )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: PopupMenuButton(
                                icon: Icon(Icons.more_horiz),
                                onSelected: (String value) {
                                  if (value == "delete") {
                                    print('Delete Success');
                                  }
                                },
                                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                    value: 'profile',
                                    child: Text('Profile'),
                                  ),
                                ],
                              )
                          ),
                        )
                      ],
                    ),
                    Text('Mereview Jurnal', style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    )),
                    Text('Mereview sebuah jurnal yang berkaitan dengan Jaringan Saraf Tiruan alias Neural Network lalu juga sertakan referensi jurnal yang dipakai', style: TextStyle(
                        fontSize: 18
                    ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Icon(Icons.access_time_outlined),
                                SizedBox(width: 10),
                                Text('Today, 23 : 00 WIB')
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('All Assignment', style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                    )),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  height: 10,
                  color: Colors.white,
                );
              },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xfff4f4f5),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle, color: Colors.red),
                                  SizedBox(width: 10),
                                  Text('Jaringan Saraf Tiruan', style: TextStyle(fontWeight: FontWeight.w500)),
                                ],
                              ),
                            )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: PopupMenuButton(
                                    icon: Icon(Icons.more_horiz),
                                    onSelected: (String value) {
                                      if (value == "delete") {
                                        print('Delete Success');
                                      }
                                    },
                                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: 'profile',
                                        child: Text('Profile'),
                                      ),
                                    ],
                                  )
                              ),
                            )
                          ],
                        ),
                        Text('Mereview Jurnal', style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                        )),
                        Text('Mereview sebuah jurnal yang berkaitan dengan Jaringan Saraf Tiruan alias Neural Network', style: TextStyle(
                          fontSize: 18,
                        ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Icon(Icons.access_time_outlined),
                                    SizedBox(width: 10),
                                    Text('Today, 23 : 00 WIB')
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}