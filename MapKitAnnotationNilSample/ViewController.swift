import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    let skyTree: MKPointAnnotation = {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(35.710066, 139.810713)
        annotation.title = "新東京タワー"
        return annotation
    } ()
    
    let tokyoTower: MKPointAnnotation = {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(35.658574, 139.745436)
        annotation.title = "旧東京タワー"
        return annotation
    } ()
    
    @IBAction func putSkyTreeAnnotation(sender: UIButton) {
        putAnnotationAndZoom(skyTree)
    }
    
    @IBAction func putTokyoTowerAnnotation(sender: UIButton) {
        putAnnotationAndZoom(tokyoTower)
    }
    
    @IBAction func clearAnnotations(sender: UIButton) {
        mapView.removeAnnotations([skyTree, tokyoTower])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setInitialRegion()
    }
    
    private func putAnnotationAndZoom(annotation: MKPointAnnotation) {
        mapView.removeAnnotation(annotation)
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 12000, 12000)
        mapView.setRegion(region, animated: true)
        
        mapView.selectAnnotation(annotation, animated: true)
    }
    
    private func setInitialRegion() {
        let coordinate = CLLocationCoordinate2DMake(35.689488, 139.691706)
        let region = MKCoordinateRegionMakeWithDistance(coordinate, 12000, 12000)
        mapView.setRegion(region, animated: false)
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let id = "myPin"
        
        // 再利用できるアノテーションビューがあれば再利用、なければ作成
        if let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(id) {
            // ここでannotationにnilを渡しても、引数で受け取ったannotationがセットされる
            annotationView.annotation = nil
            return annotationView
        } else {
            // ここでannotationにnilを渡しても、引数で受け取ったannotationがセットされる
            let annotationView = MKPinAnnotationView(annotation: nil, reuseIdentifier: id)
            annotationView.animatesDrop = true
            annotationView.canShowCallout = true
            annotationView.pinTintColor = UIColor.blueColor()
            return annotationView
        }
    }
}
