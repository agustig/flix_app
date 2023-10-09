part of '../movie_page.dart';

Widget searchBar(BuildContext context) => Row(
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width - 24 - 24 - 90,
          height: 50.0,
          margin: const EdgeInsets.only(left: 24.0, right: 10.0),
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
            color: const Color(0xFF252836),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            style: TextStyle(color: Colors.green.shade400),
            decoration: const InputDecoration(
              hintText: 'Search movie',
              border: InputBorder.none,
              icon: Icon(Icons.search),
            ),
          ),
        ),
        SizedBox(
          width: 80,
          height: 50,
          child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            child: const Center(child: Icon(Icons.search)),
          ),
        ),
      ],
    );
