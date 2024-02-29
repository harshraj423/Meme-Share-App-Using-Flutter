import 'package:flutter/material.dart';
import 'package:meme_share/controller/fetchMeme.dart';
import 'package:meme_share/controller/saveMyData.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String imgUrl = "";
  int? memeNo;
  int targetMeme = 100;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    GetInitMemeNo();
    UpdateImg();
  }

  void UpdateImg() async {
    String getImgUrl = await FetchMeme.fetchNewMeme();
    setState(() {
      imgUrl = getImgUrl;
      isLoading = false;
    });
  }

  GetInitMemeNo() async {
    memeNo = await SaveMyData.fetchData() ?? 0;
    if(memeNo!>100){
      targetMeme = 500;
    }else if(memeNo! > 500){
      targetMeme  = 1000;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 120,
          ),
          Text(
            "Meme #${memeNo.toString()}",
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Target $targetMeme Memes",
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 30,
          ),
          isLoading
              ? SizedBox(
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                      child: SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator())))
              : Image.network(
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitHeight,
                  imgUrl),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await SaveMyData.saveData(memeNo! + 1);
                GetInitMemeNo();
                UpdateImg();
              },
              child: Container(
                  height: 50,
                  width: 150,
                  child: const Center(
                      child: Text(
                    "More Fun!!",
                    style: TextStyle(fontSize: 25),
                  )))),
          const Spacer(),
          const Text(
            "APP CREATED BY",
            style: TextStyle(fontSize: 20),
          ),
          const Text(
            "HARSH RAJ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
