//
//  DetailsVC.swift
//  CodeTestNinetyNine
//
//  Created by sawpyae on 10/19/22.
//

import UIKit
import MapKit

class DetailsVC: BaseVC {

    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var flatImg: UIImageView!
    @IBOutlet weak var bathlbl: UILabel!
    @IBOutlet weak var bedlbl: UILabel!
    @IBOutlet weak var arealbl: UILabel!
    @IBOutlet weak var prjNamelbl: UILabel!
    @IBOutlet weak var addresslbl: UILabel!
    @IBOutlet weak var categorylbl: UILabel!
    @IBOutlet weak var propertyPricelbl: UILabel!
    @IBOutlet weak var propertyFloorlbl: UILabel!
    @IBOutlet weak var propertyFacinglbl: UILabel!
    @IBOutlet weak var propertyBuildlbl: UILabel!
    @IBOutlet weak var propertyTenurelbl: UILabel!
    @IBOutlet weak var propertyTypelbl: UILabel!
    @IBOutlet weak var propertyLastUpdatelbl: UILabel!
    @IBOutlet weak var descriptionlbl: UITextView!

    var detailsData: DetailData?
    var detailsVM: DetailVM?

    override func viewDidLoad() {
        super.viewDidLoad()
        detailsVM?.beforeApiCall = {
            DispatchQueue.main.async {
                OverlayLoadingView.shared.show()
            }
        }

        detailsVM?.afterApiCall = {
            DispatchQueue.main.async {
                OverlayLoadingView.shared.hide()
            }
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getDetailsData()
    }

    func getDetailsData() {
        if Reachability.isConnectedToNetwork() {
            detailsVM?.getDetailData(success: { [weak self] res  in
                guard let self = self else { return  }
                DispatchQueue.main.async {
                    self.detailsData = res
                    self.setUpView(data: res)
                }
            }, failure: { error in
                debugPrint(error?.result ?? "unknown")
            })
        } else{
            self.showNetworkError()
        }
    }

    func setUpView(data: DetailData) {

        self.pricelbl.text = Utility.shared.currencyFormatter(data: data.attributes.price)
        self.bathlbl.text = String(data.attributes.bathrooms) + (Int(data.attributes.bathrooms)>1 ? "Baths" : "Bath")
        self.bedlbl.text = String(data.attributes.bathrooms) + (Int(data.attributes.bathrooms)>1 ? "Beds" : "Bed")
        self.arealbl.text = String(data.attributes.area_size) + "sqft"
        self.prjNamelbl.text = data.projectName
        self.addresslbl.text = data.address.subtitle
        self.categorylbl.text = data.address.title

        self.descriptionlbl.text = data.flatDescription
        let _: [()] = data.propertyDetails.map {
            if $0.label == "Floor Level" {
                self.propertyFloorlbl.text = $0.text
            }
            if $0.label == "Facing" {
                self.propertyFacinglbl.text = $0.text
            }
            if $0.label == "Built year" {
                self.propertyBuildlbl.text = $0.text
            }
            if $0.label == "Price/sqft" {
                self.propertyPricelbl.text = $0.text
            }
            if $0.label == "Tenure" {
                self.propertyTenurelbl.text = $0.text
            }
            if $0.label == "Property type" {
                self.propertyTypelbl.text = $0.text
            }
            if $0.label == "Last updated" {
                self.propertyLastUpdatelbl.text = $0.text
            }
            guard let url = URL(string: data.photo) else { return }
            self.flatImg.load(url: url)

        }
    }

    func openMapForPlace() {
        guard let data = self.detailsData else { return }

        let latitude:CLLocationDegrees =  data.address.mapCoordinates.lat
        let longitude:CLLocationDegrees =  data.address.mapCoordinates.lng

        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Location"
        mapItem.openInMaps(launchOptions: options)

    }

    @IBAction func clickBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clickMap(_ sender: UIButton) {
        openMapForPlace()
    }
}

