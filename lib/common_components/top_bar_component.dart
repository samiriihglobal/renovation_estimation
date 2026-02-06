
import 'package:flutter/material.dart';

class TopBarComponent extends StatelessWidget {
  const TopBarComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      child: Row(
        children: [
          Spacer(),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Massimo Ranieri",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                Text("RENOVATOR",style: TextStyle(color: Color(0xFF696969,),fontSize: 10),),
              ],
            ),
          ),
          SizedBox(width: 16,),
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                color: Color(0xFFE9E9E9),
                borderRadius: BorderRadius.circular(45),
                border: BoxBorder.all(
                    color: Colors.black
                )
            ),
          ),
          SizedBox(width: 16,),

        ],
      ),
    );
  }
}