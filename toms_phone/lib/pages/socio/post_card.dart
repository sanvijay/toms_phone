import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class PostCard extends StatelessWidget {
  const PostCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  // text: "By continuing you agree the",
                                  children:[
                                    TextSpan(
                                      text: "Sandeep",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                      ),
                                      recognizer: TapGestureRecognizer()..onTap = () { Navigator.of(context).pushNamed("/socio-profile"); },
                                    ),
                                    TextSpan(
                                      text: " tagged with "
                                    ),
                                    TextSpan(
                                      text: "Reethika, ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                      ),
                                      recognizer: TapGestureRecognizer()..onTap = () { Navigator.of(context).pushNamed("/socio-profile"); },
                                    ),
                                    TextSpan(
                                      text: "Avyukth, ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                      ),
                                      recognizer: TapGestureRecognizer()..onTap = () { Navigator.of(context).pushNamed("/socio-profile"); },
                                    ),
                                    TextSpan(
                                      text: "Ishanvi, ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                      ),
                                      recognizer: TapGestureRecognizer()..onTap = () { Navigator.of(context).pushNamed("/socio-profile"); },
                                    ),
                                  ],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16
                                  )
                              ),
                            ),
                          ),
                          // Expanded(
                          //   child: Text(
                          //     "Sandeep tagged with Reethika, Avyukth, Sruthi, Ishanvi",
                          //     style: TextStyle(
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: 16,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Image.network(
                      "https://media.sproutsocial.com/uploads/2017/01/Instagram-Post-Ideas.png",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: const Icon(true ? Icons.favorite : Icons.favorite_border)
                        ),
                        const SizedBox(width: 10.0,),
                        GestureDetector(
                            onTap: () {},
                            child: const Icon(Icons.message),
                        ),
                      ],
                    ),
                    GestureDetector(
                        onTap: () {},
                      child: const Icon(true ? Icons.bookmark : Icons.bookmark_border),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12,),
              const Padding(
                padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                child: Text(
                  "This is where the description goes.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                child: Text(
                  "View all 5 Comments.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                child: Text(
                  "Dec 5, 2022.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        )
    );
  }
}
