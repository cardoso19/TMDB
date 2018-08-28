# TMDB

### Description
This app provides a view of the upcoming movies and search for movies by part or full name, all of the data that are show are provided by https://www.themoviedb.org. The app is currently localized to english and portuguese, but it request data in the language that the device uses.

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
- [Alamofire](https://github.com/Alamofire/Alamofire): Was choosed by his easy utilization and for his confiability with request on all of kind of types. It was used on each request that the app do to the backend.
- [Alamofire Image](https://github.com/Alamofire/AlamofireImage): As a componnent library of Alamofire, Alamofire Image provides a easy way to get images from the backend and cache them. The application has used this Framework to manage the memory usage of the cache of images.
- [DZNEmptyDataSet](https://github.com/dzenbot/DZNEmptyDataSet):This framework provide a simplified form to show UITableViews and UICollectionView without content. The app used this framework to show messages when the collection view of movies don't have any content to show.