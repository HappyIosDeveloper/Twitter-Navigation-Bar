# Twitter-Navigation-Bar
Super cool navigation bar blur effect like Twitter!

![alt text](https://github.com/UzumakiAlfredo/Twitter-Navigation-Bar/blob/master/preview.gif?raw=true)


# Usage:

1. Copy TwitterViewController.swift to your project.
2. Insted of UIViewController, extend you class from TwitterViewController.
3. Put a UIScrollView in your storyboard & connect it to you class.
4. call setupTwitterNavigationBar function anywhere you desire & pass it your scrollView & image.
5. If you need a title for your navigation bar, create a UILabel programmically & pass it to the setup function.

# Caution:
Your ViewController must embedded in a navigation bar(on storyboard), otherwise app will crash!


# Usage example: 

    let label = UILabel()
    label.text = "test"
    label.textColor = .white
    setupTwitterNavigationBar(scrollView:scrollView, withCustomHeight: 200, image: #imageLiteral(resourceName: "69574601030257393cefb27df012fe04586e"), titleLabel: label)
