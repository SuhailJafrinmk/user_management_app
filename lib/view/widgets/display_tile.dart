import 'package:flutter/material.dart';

class DisplayTile extends StatelessWidget {
  const DisplayTile({super.key});

  @override
  Widget build(BuildContext context) {
       return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){},
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  children: [
                                  
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('FirstName:',
                          ),
                      Text('LastName:'),
                      Text('Class :',),
                      TextButton(
                          onPressed: () {
                           
                          },
                          child: const Text('View details')),
                      Row(
                        children: [
                          const Icon(
                            Icons.edit,
                            size: 15,
                          ),
                          Text(
                            'Click tile to edit',
                           
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 40,),
                    IconButton(
                        onPressed: () {
                          
                        },
                        icon: const Icon(Icons.delete)),
                        
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
}
}