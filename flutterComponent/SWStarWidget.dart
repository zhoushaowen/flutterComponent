import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SWStarWidget extends StatefulWidget {
  final int starCount;
  final double rate;
  final double size;
  final Color unSelectedColor;
  final Color selectedColor;

  SWStarWidget({
    int starCount = 5,
    double rate = 0,
    this.size = 20,
    this.unSelectedColor = Colors.grey,
    this.selectedColor = Colors.red}):this.starCount = (starCount >= 0 ? starCount : 0),this.rate = (rate < 0 ? 0 : rate > starCount ? starCount.toDouble() : rate);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SWStarState();
  }

}

class _SWStarState extends State<SWStarWidget> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: [Row(children: createUnSelectedStars(),),
      Row(children: createSelectedStars())]);
  }

  List<Widget> createUnSelectedStars() {
    return createStars(false,widget.starCount);
  }

  List<Widget> createSelectedStars() {
    var rate = widget.rate;
    if(rate % 1 == 0) {//整数
      return createStars(true, rate.toInt());
    }
    else{//小数
      int num = (rate / 1).toInt();
      var list = createStars(true,num);
      list.add(clipStar(rate - num));
      return list;
    }
  }

  List<Widget> createStars(bool isSelected,int starCount)  {
    return List.generate(starCount, (index) {
      return Icon(Icons.star,size: widget.size,color: isSelected ? widget.selectedColor : widget.unSelectedColor,);
    });

  }

  Widget clipStar(double percent) {
    return ClipRect(clipper: SWStarClip(widget.size*percent),child: createStars(true, 1).first,);
  }
}

class SWStarClip extends CustomClipper<Rect> {
  double width;

  SWStarClip(this.width);

  @override
 Rect getClip(Size size) {
    // TODO: implement getClip
    return Rect.fromLTWH(0, 0, width, size.height);
  }

  @override
  bool shouldReclip(covariant SWStarClip oldClipper) {
    // TODO: implement shouldReclip
    return width != oldClipper.width;
  }
  
}
