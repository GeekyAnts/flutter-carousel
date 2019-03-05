# Flutter_Carosel

A simple Carousel Widget with multiple configuration option.

```yaml
...
dependencies:
 ...
 flutter_multi_carousel: ^1.0.0
...
```

And install it using `flutter packages get` on your project folder. After that, just import the module and use it:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_multi_carousel/carousel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: CarouselExample(),
    );
  }
}

class CarouselExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Carousel(
            height: 350.0,
            width: 350,
            type: "slideswiper",
            indicatorType: "bubble",
            arrowColor: Colors.white,
            axis: Axis.horizontal,
            showArrow: true,
            children: List.generate(
                7,
                (i) => Center(
                      child: Container(color: Colors.red),
                    ))),
      ),
    );
  }
}
```

## For detailed demonstration refer this [GitHub](https://github.com/jaiswalshubham84/Flutter-Carousel) link

https://github.com/jaiswalshubham84/Flutter-Carousel

## Getting Startedslide

<table style="width:100%">
    <tr>
        <th>Properties</th>
        <th>Type</th>
        <th>Default Value</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>height</td>
        <td>Double</td>
        <td>null</td>
        <td>Defines height of carousel.This field is required</td>
    </tr>
    <tr>
        <td>width</td>
        <td>Double</td>
        <td>null</td>
        <td>Defines width of carousel. This field is required</td>
    </tr>
     <tr>
        <td>axis</td>
        <td>Axis</td>
        <td>Axis.horizontal</td>
        <td>Defines axis of carousel.</td>
    </tr>
    <tr>
        <td>type</td>
        <td>String</td>
        <td>"simple"</td>
        <td>Defines type of carousel.<br> Available carousel types are: "simple", "slideswiper",
             "xrotating",
            "yrotating", "zrotating", "multirotating"</br></td>
    </tr>
    <tr>
        <td>showArrow</td>
        <td>Bool</td>
        <td>true</td>
        <td>choice to show arrow in carousel</td>
    </tr>
    <tr>
        <td>arrowColor</td>
        <td>Color</td>
        <td>Colors.white</td>
        <td>Define the color of arrow</td>
    </tr>
    <tr>
        <td>showIndicator</td>
        <td>Bool</td>
        <td>true</td>
        <td>Choice to show indicator in carousel</td>
    </tr>
    <tr>
        <td>indicatorType</td>
        <td>String</td>
        <td>bar</td>
        <td>Defines the type of indicator.<br> Available indicator types are: "bar", "dot", "bubble"</br></td>
    </tr>
    <tr>
        <td>activeIndicatorColor</td>
        <td>Color</td>
        <td>Colors.white</td>
        <td>Defines the color of active indicator</td>
    </tr>
    <tr>
        <td>unActiveIndicatorColor</td>
        <td>Color</td>
        <td>Colors.black</td>
        <td>Defines the color of unactive indicator</td>
    </tr>
    <tr>
        <td>indicatorBackgroundColor</td>
        <td>Color</td>
        <td>Color(0xff121212)</td>
        <td>Defines the background color of indicator</td>
    </tr>
    <tr>
        <td>indicatorBackgroundOpacity</td>
        <td>Double</td>
        <td>0.5</td>
        <td>Defines the opacity of indicator background</td>
    </tr>
</table>
<br></br>

| ![](https://github.com/jaiswalshubham84/readme/blob/master/gifs/simple_carousel.gif?raw=true) | ![](https://github.com/jaiswalshubham84/readme/blob/master/gifs/slide_swipe.gif?raw=true) | ![](https://github.com/jaiswalshubham84/readme/blob/master/gifs/x_rotating.gif?raw=true)     |
| :-------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------- |
| ![](https://github.com/jaiswalshubham84/readme/blob/master/gifs/y_rotating.gif?raw=true)      | ![](https://github.com/jaiswalshubham84/readme/blob/master/gifs/z_rotating.gif?raw=true)  | ![](https://github.com/jaiswalshubham84/readme/blob/master/gifs/multi_rotating.gif?raw=true) |

## Credits

Developed by Shubham Jaiswal <jaiswal.shubham84@gmail.com>

## Contributing

Feel free to Contribute!

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).
