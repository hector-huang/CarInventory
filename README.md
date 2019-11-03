CarInventory
========

This repository contains a simple iOS application that loads data from a REST API which will return a list of cars. They should be displayed in a scrolling list. The detail screen should be displayed when the user taps on a listing cell.

---
# Installation

The only dependency URLImage will automatically be installed by Swift Packages, if not:
* HTTPS https://github.com/dmytro-anokhin/url-image.git URL from github
* Open File/Swift Packages/Add Package Dependency... in Xcode 11
* Paste the URL and follow steps

# Structure Features
The app is an exploration of SwfitUI and Combine, meanwhile aim to procure more clear, maintainable, testable and flawless architecture and code base by:

* MVVM pattern is introduced to extract a mass of model-to-view transformation codes from the view controller into view model, which encapsulte all the UI related states and contents.
* Reactive programming paradigm facilitated by Combine is implemented to help with data binding, especially with asychronous network and user interaction.
* SwiftUI performs well to realise dynamic numbers of columns (iPhone: 1 column, iPad: 2 columns portrait and 3 landscape) by re-rendering (similar to React), the only problem is the VStack/HStack doesn't have flowlayout feature to redraw the layout smoothly.
* Web requests and responses are handled by a singelton ApiManager
* ActivityIndicator shows the feasibility of wrapping a custom UIView for SwiftUI
* URLProtocol is mocked to help Unit Testing URLSession
---

# Bugs
* The provided API only returns two kinds of car detail response (one with price $40,037 and one with $53,081). Can check by:
https://buttered-pewter.glitch.me/details/AD-5979131?username=test&password=2h7H53eXsQupXvkz
https://buttered-pewter.glitch.me/details/AD-5889516?username=test&password=2h7H53eXsQupXvkz
https://buttered-pewter.glitch.me/details/AD-6011725?username=test&password=2h7H53eXsQupXvkz
* There's a known bug in SwiftUI Navigationlink, if navigates to detail view and then press go back, sometimes the user will be directed to detail view again. To resolve this, I created isNavigating state to control the navigation action (CarListCell).
References: 
https://swiftui-lab.com/bug-navigationlink-isactive/
4:28 https://www.youtube.com/watch?v=xJaQnG0-kU8


# Future Improvements
Due to time limits, the app can be improved and extended in follow ways:

* ApiManager is apt to supporting other web APIs and more all-rounded web error categorizing (such as Authentication, Authorization, No Data) in the future.
* Unit Testing in SwiftUI is not supported by Apple at the moment, as testability of SwiftUI hasn't yet be designed or exposed to developers.
* SwiftUI ScrollView currently doesn't support pagination effect, we can either wait for Apple to update or make our own SwiftUI ImageSlider by UIViewRepresentable (integrating with UIKit)
