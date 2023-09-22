// Widget getAvatar(String? profileImageUrl, String name) {
//   if (profileImageUrl != null && profileImageUrl.isNotEmpty) {
//     return CircleAvatar(
//       backgroundImage: AssetImage(profileImageUrl),
//     );
//   } else {
//     print('No profile image for user: $name'); // Debugging
//     return CircleAvatar(
//       backgroundColor: Colors.blue,
//       child: Text(
//         name.isNotEmpty ? name[0] : '?',
//         style: TextStyle(fontSize: 20, color: Colors.white),
//       ),
//     );
//   }
// }