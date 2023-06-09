import 'package:flutter/material.dart';

class EmployeeAvatar extends StatelessWidget {
  final int displayActive;
  final double backgroundRadius;
  final double paddingSpace;
  final String? imageURL;
  const EmployeeAvatar({
    this.displayActive = 1,
    this.backgroundRadius = 64,
    this.paddingSpace = 4,
    this.imageURL,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = backgroundRadius * 2;
    return Container(
      height: size,
      width: size,
      padding: EdgeInsets.all(paddingSpace),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 0),
          )
        ],
      ),
//       child: ClipOval(
// //TODO: replace with image url late
//         child: SizedBox(
//           height: size - paddingSpace,
//           width: size - paddingSpace,
//           child: imageURL == null
//               ? Image.asset(
//                   "assets/images/person_holder.png",
//                   fit: BoxFit.contain,
//                 )
//               : Image.network(
//                   imageURL!,
//                   fit: BoxFit.fill,
//                   errorBuilder: ((context, error, stackTrace) => Image.asset(
//                         "assets/images/person_holder.png",
//                         fit: BoxFit.contain,
//                       )),
//                 ),
//         ),
//       ),

    child: SizedBox(
      child: CircleAvatar(
        backgroundColor: Color(0xfff3e0a6),
        radius: 30.0,
        backgroundImage: NetworkImage(imageURL ?? ""),
        child: displayActive == 1 ? Align(
          alignment: Alignment.bottomRight,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 8.0,
            child: Icon(
              Icons.circle_rounded,
              size: 12,
              color: Colors.green,
            ),
          ),
        ): displayActive == 2 ? Align(
          alignment: Alignment.bottomRight,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 8.0,
            child: Icon(
              Icons.circle_rounded,
              size: 12,
              color: Colors.grey,
            ),
          ),
        ): SizedBox(),

      ),
    ));
  }
}
