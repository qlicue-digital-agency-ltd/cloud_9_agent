
import 'package:flutter/material.dart';

import 'background.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
        screen: SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0,
              expandedHeight: 120.0,
              backgroundColor: Colors.transparent,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                title: Text(
                  'Terms & Conditions',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(height: 50),
              Text(
                'Terms',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                  'Jelly brownie dessert jelly beans apple pie soufflé jelly beans. Cake gummies soufflé chupa chups sweet danish carrot cake pastry danish. Bear claw cake lollipop. Lemon drops sweet liquorice. Donut dragée gummi bears candy cheesecake. Lollipop jelly beans marshmallow macaroon. Biscuit sweet roll chocolate. Cheesecake topping macaroon. Candy canes donut sweet toffee icing bonbon. Sweet roll marzipan sesame snaps sweet. Sesame snaps biscuit cheesecake marzipan danish jujubes apple pie sweet brownie. Tart donut dragée cupcake gummies lollipop soufflé. Ice cream jujubes sesame snaps marshmallow wafer Jelly brownie dessert jelly beans apple pie soufflé jelly beans. Cake gummies soufflé chupa chups sweet danish carrot cake pastry danish. Bear claw cake lollipop. Lemon drops sweet liquorice. Donut dragée gummi bears candy cheesecake. Lollipop jelly beans marshmallow macaroon. Biscuit sweet roll chocolate. Cheesecake topping macaroon. Candy canes donut sweet toffee icing bonbon. Sweet roll marzipan sesame snaps sweet. Sesame snaps biscuit cheesecake marzipan danish jujubes apple pie sweet brownie. Tart donut dragée cupcake gummies lollipop soufflé. Ice cream jujubes sesame snaps marshmallow wafer'),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                'Conditions',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                  'Jelly brownie dessert jelly beans apple pie soufflé jelly beans. Cake gummies soufflé chupa chups sweet danish carrot cake pastry danish. Bear claw cake lollipop. Lemon drops sweet liquorice. Donut dragée gummi bears candy cheesecake. Lollipop jelly beans marshmallow macaroon. Biscuit sweet roll chocolate. Cheesecake topping macaroon. Candy canes donut sweet toffee icing bonbon. Sweet roll marzipan sesame snaps sweet. Sesame snaps biscuit cheesecake marzipan danish jujubes apple pie sweet brownie. Tart donut dragée cupcake gummies lollipop soufflé. Ice cream jujubes sesame snaps marshmallow wafer Jelly brownie dessert jelly beans apple pie soufflé jelly beans. Cake gummies soufflé chupa chups sweet danish carrot cake pastry danish. Bear claw cake lollipop. Lemon drops sweet liquorice. Donut dragée gummi bears candy cheesecake. Lollipop jelly beans marshmallow macaroon. Biscuit sweet roll chocolate. Cheesecake topping macaroon. Candy canes donut sweet toffee icing bonbon. Sweet roll marzipan sesame snaps sweet. Sesame snaps biscuit cheesecake marzipan danish jujubes apple pie sweet brownie. Tart donut dragée cupcake gummies lollipop soufflé. Ice cream jujubes sesame snaps marshmallow wafer'),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                'Copy Rights',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                  'Jelly brownie dessert jelly beans apple pie soufflé jelly beans. Cake gummies soufflé chupa chups sweet danish carrot cake pastry danish. Bear claw cake lollipop. Lemon drops sweet liquorice. Donut dragée gummi bears candy cheesecake. Lollipop jelly beans marshmallow macaroon. Biscuit sweet roll chocolate. Cheesecake topping macaroon. Candy canes donut sweet toffee icing bonbon. Sweet roll marzipan sesame snaps sweet. Sesame snaps biscuit cheesecake marzipan danish jujubes apple pie sweet brownie. Tart donut dragée cupcake gummies lollipop soufflé. Ice cream jujubes sesame snaps marshmallow wafer Jelly brownie dessert jelly beans apple pie soufflé jelly beans. Cake gummies soufflé chupa chups sweet danish carrot cake pastry danish. Bear claw cake lollipop. Lemon drops sweet liquorice. Donut dragée gummi bears candy cheesecake. Lollipop jelly beans marshmallow macaroon. Biscuit sweet roll chocolate. Cheesecake topping macaroon. Candy canes donut sweet toffee icing bonbon. Sweet roll marzipan sesame snaps sweet. Sesame snaps biscuit cheesecake marzipan danish jujubes apple pie sweet brownie. Tart donut dragée cupcake gummies lollipop soufflé. Ice cream jujubes sesame snaps marshmallow wafer')
            ])),
          ],
        ),
      ),
    ));
  }
}
