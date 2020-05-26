# MVVM-CoreData-Car-Example
MVVM App with core data in swift example
func NKPlaceholderImage(image:UIImage?, imageView:UIImageView?,imgUrl:String,compate:@escaping (UIImage?) -> Void){

    if image != nil && imageView != nil {
        imageView!.image = image!
    }

    var urlcatch = imgUrl.replacingOccurrences(of: "/", with: "#")
    let documentpath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    urlcatch = documentpath + "/" + "\(urlcatch)"

    let image = UIImage(contentsOfFile:urlcatch)
    if image != nil && imageView != nil
    {
        imageView!.image = image!
        compate(image)

    }else{

        if let url = URL(string: imgUrl){

            DispatchQueue.global(qos: .background).async {
                () -> Void in
                let imgdata = NSData(contentsOf: url)
                DispatchQueue.main.async {
                    () -> Void in
                    imgdata?.write(toFile: urlcatch, atomically: true)
                    let image = UIImage(contentsOfFile:urlcatch)
                    compate(image)
                    if image != nil  {
                        if imageView != nil  {
                            imageView!.image = image!
                        }
                    }
                }
            }
        }
    }
}


NKPlaceholderImage(image: UIImage(named: "placeholder"), imageView: imgPicture, imgUrl: "Put Here your server image Url Sting") { (image) in }

