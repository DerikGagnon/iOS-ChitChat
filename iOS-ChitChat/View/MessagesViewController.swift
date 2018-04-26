//
//  MessagesViewController.swift
//  iOS-ChitChat
//
//  Created by derk on 4/24/18.
//  Copyright © 2018 Gagnon, Derik. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class MessagesViewController: UIViewController {

    //Basic variables needed
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var map: MKMapView!
    var lat:CLLocationDegrees = 0
    var lon:CLLocationDegrees = 0
    var url:URL = URL.init(string: "whatever")!

    override func viewDidLoad() {
        super.viewDidLoad()

        //Sets up the mapview
        let marker = MKPointAnnotation()
        let coord = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        marker.coordinate = coord
        map.addAnnotation(marker)
        map.centerCoordinate = coord

        //Checks to see if the url has changed
        if url.absoluteString != "whatever"{
            load_image()
        }
    }

    //Basic function that uses picture data to read the image and apply it to the imageview
    func load_image(){
        let pictureData = NSData(contentsOf: url)
        if((pictureData) != nil) {
            let image = UIImage(data: pictureData! as Data)
            detailImage.image = image
            detailImage.contentMode = UIViewContentMode.scaleAspectFit
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

