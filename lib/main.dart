import 'package:demo/src/api_call.dart';
import 'package:demo/src/models/user_data_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserDataModel? res;
  List<Data>? data = [];
  TextEditingController page = TextEditingController();
  TextEditingController limit = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() async {
    res = await ApiCall().getUserData(page: page.text, limit: limit.text);
    setState(() {
      data?.clear();
      data?.addAll(res?.data as List<Data>);
      // print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    // margin: EdgeInsets.all(50),
                    height: size.height * 0.8,
                    width: size.width,
                    child:
                        // data!.isEmpty?
                        // Center(
                        //   child: CustomPaint(
                        //     painter: ArrowContainer()
                        //     ,
                        //     child: Text("Text"),
                        //   )
                        // )
                        Center(
                      child: Stack(children: [
                        ClipPath(
                          clipper: DemoCliper(),
                          child: Container(
                            color: Colors.red,
                          ),
                        ),
                        ClipPath(
                          clipper: DemoRect(),
                          child: Container(
                            color: Colors.yellow,
                          ),
                        ),
                        Center(child: CircleAvatar(
                          radius: size.width*0.25,
                        ))
                      ]),
                    )
                    //     :ListView.builder(
                    //   itemCount: data?.length,
                    //   itemBuilder: (context, index) {
                    //     return Container(
                    //       height: 80,
                    //       width: size.width,
                    //       child: Row(
                    //         children: [
                    //           Expanded(
                    //               flex: 3,
                    //               child: Image.network(
                    //                   (data![index].picture).toString())),
                    //           Expanded(
                    //               flex: 9,
                    //               child: Column(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                 children: [
                    //                   Text((data![index].id).toString()),
                    //                   Text(
                    //                       '${(data![index].title).toString()} ${(data![index].firstName).toString()} ${(data![index].lastName).toString()}   '),
                    //                 ],
                    //               ))
                    //         ],
                    //       ),
                    //     );
                    //   },
                    // ),
                    ),
                Container(
                  height: size.height * 0.2,
                  child: Center(
                    child: Column(children: [
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: page,
                                    decoration: InputDecoration(
                                        label: Text("Page No.")),
                                  ))),
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: limit,
                                    decoration:
                                        InputDecoration(label: Text("Limits")),
                                  )))
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          res = await ApiCall()
                              .getUserData(page: page.text, limit: limit.text);
                          setState(() {
                            data?.clear();
                            data?.addAll(res?.data as List<Data>);
                            print(data);
                          });
                        },
                        child: Text("Click"),
                      ),
                    ]),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class ArrowContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Gradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.orangeAccent, Colors.yellow],
      tileMode: TileMode.clamp,
    );
    // TODO: implement paint
    final Rect colorBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    final Paint paint = Paint()..shader = gradient.createShader(colorBounds);

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, 30);
    path.lineTo(30, 30);
    path.lineTo(40, 40);
    path.lineTo(50, 30);
    path.lineTo(80, 30);
    path.lineTo(80, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    // throw UnimplementedError();
    return true;
  }
}

class DemoCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.6);
    var firstControlPoint = Offset(size.width * 0.1, size.height * 0.35);
    var endPoint = Offset(size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(
        firstControlPoint.dx, firstControlPoint.dy, endPoint.dx, endPoint.dy);
    var SecondControlPoint = Offset(size.width * 0.8, size.height * 0.6);
    var secondEndPoint = Offset(size.width, size.height * 0.5);
    path.quadraticBezierTo(SecondControlPoint.dx, SecondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}


class DemoRect extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
   Path path = Path();

   path.moveTo(size.width*0.1, 0);
   path.lineTo(size.width*0.15, size.height*0.03);
   path.lineTo(size.width*0.85, size.height*0.03);
   path.lineTo(size.width*0.9, 0);
   path.close();
   return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
   return true;
  }

}
