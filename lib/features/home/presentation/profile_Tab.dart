import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesproject/core/constants/app_assets.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/core/constants/app_string.dart';
import 'package:moviesproject/core/constants/app_text_style.dart';
import 'package:moviesproject/core/routes/app_routes.dart';
import 'package:moviesproject/features/home/presentation/watchList_Bloc/watchlist_bloc.dart';
import 'package:moviesproject/features/home/presentation/history_page.dart';
import 'package:moviesproject/features/home/presentation/watch_list_page.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  int selectedTab = 0;

  String? userAvatar;
  String? userName;

  Stream<DocumentSnapshot<Map<String, dynamic>>>? userStream;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;


    final historyStream = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('history')
        .snapshots();
    if (user != null) {
      userStream = FirebaseFirestore.instance .collection('users') .doc(user.uid) .snapshots(); }  }


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: AppColors.black,

body: SafeArea(
child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
stream: userStream,
builder: (context, snapshot) {
  String? avatar;
  String? name;

  if (snapshot.hasData && snapshot.data!.exists) {
    final data = snapshot.data!.data();

    avatar = data?['avatar'];
    name = data?['name'];
  }

  return SingleChildScrollView(
    child: Column(
      children: [

        Padding(
          padding: const EdgeInsets.fromLTRB(
            16,
            35,
            16,
            20,
          ),
          child: Column(
            children: [



              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                    width: 125,
                    child: Column(
                      children: [

                        CircleAvatar(
                          radius: 58,
                          backgroundColor: Colors.transparent,
                          backgroundImage: avatar != null &&
                              avatar.isNotEmpty
                              ? AssetImage(avatar)
                              : null,
                          child: avatar == null || avatar.isEmpty
                              ? const Icon(
                            Icons.person,
                            color: AppColors.white,
                            size: 50,
                          )
                              : null,
                        ),

                        const SizedBox(height: 10),

                        Text(
                          name ??
                              user?.displayName ??
                              '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.bold20white,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 15),


                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        children: [

                          BlocBuilder<WatchlistBloc, WatchlistState>(
                            builder: (context, state) {
                              int watchlistCount = 0;

                              if (state is WatchlistSuccess) {
                                watchlistCount = state.movies.length;
                              }

                              return Text(
                                '$watchlistCount',
                                style: AppTextStyle.bold30white,
                              );
                            },
                          ),

                          const SizedBox(height: 8),

                          Text(
                            AppString.wishlist,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.bold20white,
                          ),
                        ],
                      ),
                    ),
                  ),


                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        children: [

                          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(user!.uid)
                                .collection('history')
                                .snapshots(),
                            builder: (context, snapshot) {

                              final historyCount =
                                  snapshot.data?.docs.length ?? 0;

                              return Text(
                                '$historyCount',
                                style: AppTextStyle.bold30white,
                              );
                            },
                          ),

                          const SizedBox(height: 8),

                          Text(
                            AppString.history,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.bold20white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),


              const SizedBox(height: 25),

              Row(
                children: [

                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.updateProfileScreen,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.yellow,
                          foregroundColor: AppColors.black,
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          AppString.editprofile,
                          style: AppTextStyle.regular20black,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();

                          if (!context.mounted) return;

                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.loginScreen,
                                (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.red,
                          foregroundColor: AppColors.white,
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppString.exit,
                              style: AppTextStyle.bold20white,
                            ),

                            const SizedBox(width: 8),

                            const Icon(
                              Icons.logout,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),


        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 16,
            right: 16,
          ),
          child: Row(
            children: [

              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = 0;
                    });
                    context.read<WatchlistBloc>().add(
                        GetWatchlistEvent(),
                    );
                  },
                  child: _buildProfileTab(
                    icon: Icons.list,
                    title: AppString.wishlist,
                  ),
                ),
              ),



              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = 1;
                    });
                  },

                  child: _buildProfileTab(
                    icon: Icons.folder,
                    title: AppString.history,
                  ),
                ),
              ),
            ],
          ),
        ),

        Row(
          children: [

            Expanded(
              child: Container(
                height: 3,
                color: selectedTab == 0
                    ? AppColors.yellow
                    : AppColors.transport,
              ),
            ),

            Expanded(
              child: Container(
                height: 3,
                color: selectedTab == 1
                    ? AppColors.yellow
                    : AppColors.transport,
              ),
            ),
          ],
        ),



        Container(
          width: double.infinity,
          color: AppColors.darkblack,
          child: selectedTab == 0
              ?  WatchListPage()
              : HistoryPage(),
        ),
      ],
    ),
  );
},
        ),
      ),
    );
  }

  Widget _buildProfileTab({
    required IconData icon,
    required String title,
  }) {
    return Column(
      children: [

        Icon(
          icon,
          size: 30,
          color: AppColors.yellow,
        ),

        const SizedBox(height: 5),

        Text(
          title,
          style: AppTextStyle.regular20whitewithoutalpha,
        ),
      ],
    );
  }


}




