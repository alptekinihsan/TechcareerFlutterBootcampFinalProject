import 'package:flutter/material.dart';
import 'package:bitirmeprojesi/data/entity/pageslider.dart';

class IndicatorDot extends StatelessWidget {
  const IndicatorDot({Key? key, required this.isActive}) : super(key: key);

  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 8,
      decoration: BoxDecoration(
        color:isActive? Colors.white: Colors.black26 ,
        borderRadius: BorderRadius.all(Radius.circular(12)),

      ),
    );
  }
}

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({Key? key}) : super(key: key);

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
        aspectRatio: 1.8,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            PageView.builder(
              itemCount: pageslider.length,
              onPageChanged:(value){
                setState((){
                  _currentPage=value;
                });
              },
              itemBuilder: (context,index)=>
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Container(
                      height: 180.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:AssetImage(pageslider[index],
                          ),
                          fit: BoxFit.fill,
                        ),
                        border: Border.all(
                            color: Colors.grey,
                            width: 2.0,
                            style: BorderStyle.none),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  )
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: Row(
                children: List.generate(
                  pageslider.length,
                      (index) =>Padding(
                    padding: const EdgeInsets.only(left: 16.0 / 4),
                    child: IndicatorDot(isActive: index == _currentPage),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}