# TMDB

### Description
This app provides a view of the upcoming movies and searches for movies by part or full name, all of the data that are shown are provided by https://www.themoviedb.org. The app is currently localized to English and Portuguese, but it requests data in the language that the device uses.

## Platform
iOS
- Minimum Version: 11.0

## Configuration
To manage the dependencies of the project was used [Cocoa Pods](https://cocoapods.org/).

First, it's necessary to clone the project.

`- git clone https://github.com/cardoso19/TMDB.git`

If you don't have Cocoa Pods installed on your computer yet, run the code below on the terminal to install it:

`sudo gem install cocoapods`

After the project had been cloned, inside of the generated directory, using Terminal execute the command:

`pod install`

With the dependencies managemend has been made by Cocoa Pods, to run the project you need to open it by clicking on the file "TMDB.xcworkspace".

## Third-party Libraries Used
- [MDTAlert](https://github.com/cardoso19/MDTAlert): This is a personal framework to present customized alerts.
- [DZNEmptyDataSet](https://github.com/dzenbot/DZNEmptyDataSet): This framework provide a simplified form to show UITableViews and UICollectionView without content. The app used this framework to show messages when the collection view of movies don't have any content to show.
