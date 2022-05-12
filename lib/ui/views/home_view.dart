import 'package:flutter/material.dart';
import 'package:product_listing/ui/views/star_rate.dart';
import 'package:product_listing/view_model/user_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        backgroundColor: Colors.lightBlue[800],
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: ChangeNotifierProvider(
          create: (context) => UserModel(),
          child: Builder(builder: (context) {

            final model = Provider.of<UserModel>(context);
            if (model.homeState == HomeState.Loading) {
              return Center(child: CircularProgressIndicator());
            }
            if (model.homeState == HomeState.Error) {
              return Center(child: Text('An Error Occured ${model.message}'));
            }
            final users = model.users;
            return GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 1.9 / 3.0,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              // physics: ScrollPhysics(),
              children: List.generate(users.length, (index) {
                    print("image: "+users[index].image);
                return GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    margin: EdgeInsetsDirectional.only( top: index == 0 || index == 1 ? 10 : 0, bottom: 10, end: 5, start: 5),
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 5)),
                        ],
                        border: Border.all(color: Colors.white.withOpacity(0.05))),
                    child: Column(
                      children: <Widget>[
                        // Image of the card
                        Stack(
                          fit: StackFit.loose,
                          alignment: AlignmentDirectional.topStart,
                          children: <Widget>[
                            Image.network(
                              users[index].image,
                              fit: BoxFit.fill,
                              height: 150.0,
                              //width: 80.0,
                              alignment: Alignment.center,
                              filterQuality: FilterQuality.low,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                users[index].title,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "RS: "+users[index].price.toString(),
                                overflow: TextOverflow.fade,
                                maxLines: 2,
                                softWrap: false,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                users[index].category,
                                overflow: TextOverflow.fade,
                                maxLines: 2,
                                softWrap: false,
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    children: StarRate.getStarsList(
                                        users[index].rating.rate),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}
