# iOS-Code-Challenge
Hiring Challenge

Pods used: 

1) Alamofire: For Web Service integration

2) View Animator: For Animations in details screen.

3) Skeletal: For tableview Animations

4) Snapkit: For assigning constraints to the ui elements.

5) Realm: For offline Storage.

6) SwiftyJSON: For parsing json responses. 

7) SwiftyGIF: For displaying Gifs.

UIStoryboard reference is removed and complete project was designed using snapkit pod. The Web Service is integrated using Alamofire and the images are downloaded
using AlamofireImage pod. The root view controller is also set in the Appdelegate file.

On start of the app if internet connection is available then the local data is cleared after which new data is fetched and stored locally.
If internet connection isnt available at the start the data within the app is loaded using the locally stored data.  

Initially data is fetched from the provided link and it is then parsed using swiftyJson pod. The data is sorted into two parts using the types parameter. 
This data is then stored in the realm and the images are also stored locally. Table view is loaded using the local data. On click of the table view cell
a new details screen is openned which displays ID, Date, Image and the Text message as well. 

Dummy cell animations are created using the skeleton pod. If the image fails to download then a placeholder image is loaded and on the details screen a error gif 
is displayed using swiftyGIF pod. Likwise if any textual data is empty then a default string "Unavailable" is loaded. 

