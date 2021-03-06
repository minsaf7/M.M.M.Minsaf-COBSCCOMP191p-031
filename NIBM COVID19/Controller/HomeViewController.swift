//
//  HomeViewController.swift
//  NIBM COVID19
//
//  Created by Mohamed Minsaf on 8/25/20.
//  Copyright © 2020 Mohamed Minsaf. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import FirebaseAuth
import FirebaseDatabase


private let reuseIdentifier = "LocationCell"
private let annotationIdentifier = "UserAnnotation"


class HomeViewController: UIViewController {


    //MARK: Properties

    private let userMap = MKMapView()
  
     private let locationInputUIView = LocationInputUIView()
     private let locationManager = LocationHandler.shared.locationManager
    private var route: MKRoute?

    
    
    private let topViewContainer: UIView = {
           let containerView = UIView()
           containerView.backgroundColor = .white
           
           let iconImage = UIImageView()
           iconImage.image = UIImage(named: "patient")
           containerView.addSubview(iconImage)
           iconImage.anchor(left: containerView.leftAnchor, paddingLeft: 36,  height: 125,width: 125)
           iconImage.centerY(inView: containerView)
           
           let topText = UILabel()
           topText.text = "All you need is"
           topText.font = UIFont(name: "Avenir-Medium", size: 26)
           containerView.addSubview(topText)
           topText.anchor(top: iconImage.topAnchor, left: iconImage.rightAnchor, paddingLeft: 34)
           
           let subTitle = UILabel()
           subTitle.text = "stay at home"
           subTitle.font = UIFont(name: "Avenir-Black", size: 30)
           containerView.addSubview(subTitle)
           subTitle.anchor(top: topText.bottomAnchor, left: iconImage.rightAnchor, paddingLeft: 34)
           
           let safeActions = UIButton()
           let imgConfig = UIImage.SymbolConfiguration(pointSize: 0, weight: .medium, scale: .small)
           safeActions.setTitle("Safe Actions ", for: .normal)
           safeActions.setTitleColor(.darkGray, for: .normal)
           safeActions.setImage(UIImage(systemName: "chevron.left", withConfiguration: imgConfig), for: .normal)
           safeActions.tintColor = .darkGray
           safeActions.titleLabel?.font = UIFont.systemFont(ofSize: 14)
           safeActions.semanticContentAttribute = .forceRightToLeft
           safeActions.sizeToFit()
          safeActions.addTarget(self, action: #selector(showSafeActions), for: .touchUpInside)
           containerView.addSubview(safeActions)
           safeActions.anchor(top: subTitle.bottomAnchor, left: iconImage.rightAnchor, paddingTop: 15, paddingLeft: 34)
           
           return containerView
       }()
       
    private let notificTab: UIButton = {
           let notificBtn = UIButton()
           notificBtn.backgroundColor = .white
           notificBtn.layer.cornerRadius = 5
           notificBtn.layer.masksToBounds = true
           
           let bell = UIImageView()
           bell.image = UIImage(systemName: "bell")
           bell.tintColor = .systemYellow
           notificBtn.addSubview(bell)
         //  bell.anchor(left: tile.leftAnchor, paddingLeft: 20, width: 32, height: 32)
        bell.anchor( left: notificBtn.leftAnchor,  paddingLeft: 20, height: 32, width: 32)
           bell.centerY(inView: notificBtn)
           
           let arrow = UIImageView()
           arrow.image = UIImage(systemName: "chevron.right")
           arrow.tintColor = .darkGray
           arrow.layer.masksToBounds = true
           notificBtn.addSubview(arrow)
          // arrow.anchor(right: tile.rightAnchor, paddingRight: 20, width: 14, height: 26)
        arrow.anchor( right: notificBtn.rightAnchor,  paddingRight: 20, height: 26, width: 14)
           arrow.centerY(inView: notificBtn)
           
           let title = UILabel()
           title.text = "NIBM is closed until further notice"
           notificBtn.addSubview(title)
           title.anchor(top: notificBtn.topAnchor,  left: bell.rightAnchor, right: arrow.leftAnchor, paddingTop: 15, paddingLeft: 12, paddingRight: 12)
           
           let description = UILabel()
           description.text = "Get in touch with the lecturers to get further details"
           description.font = UIFont(name: "Avenir-Medium", size: 12)
           description.textColor = .darkGray
           description.numberOfLines = 2
           notificBtn.addSubview(description)
           description.anchor(top: title.bottomAnchor,  left: bell.rightAnchor, right: arrow.leftAnchor, paddingLeft: 12, paddingRight: 12)
           
         notificBtn.addTarget(self, action: #selector(showNotific), for: .touchUpInside)
           return notificBtn
       }()
       
       private let caseTab: UIView = {
           let covidTab = UIView()
           covidTab.backgroundColor = .white
           
           let title = UILabel()
           title.text = "University Case Update"
           covidTab.addSubview(title)
           title.anchor(top: covidTab.topAnchor, left: covidTab.leftAnchor, paddingTop: 20, paddingLeft: 16)
           
           let moreBtn = UIButton()
           moreBtn.setTitle("See More", for: .normal)
           moreBtn.setTitleColor(.systemBlue, for: .normal)
           moreBtn.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 14)
           covidTab.addSubview(moreBtn)
           moreBtn.anchor(top: covidTab.topAnchor, right: covidTab.rightAnchor, paddingTop: 14, paddingRight: 16)
           
           let timeAgo = UILabel()
           timeAgo.text = "1 minute ago"
           timeAgo.font = UIFont(name: "Avenir-Medium", size: 11)
           timeAgo.textColor = .darkGray
           covidTab.addSubview(timeAgo)
           timeAgo.anchor(top: title.bottomAnchor, left: covidTab.leftAnchor, paddingLeft: 16)
           
           let infectedUI = UIView()
           
           let deathsUI = UIView()
           
           let recoveredUI = UIView()
           
           let yellowDot = UIImageView()
           yellowDot.image = UIImage(systemName: "smallcircle.fill.circle")
           yellowDot.tintColor = .systemYellow
           infectedUI.addSubview(yellowDot)
           yellowDot.anchor(top: infectedUI.topAnchor, paddingTop: 18)
           yellowDot.centerX(inView: infectedUI)

           let redDot = UIImageView()
           redDot.image = UIImage(systemName: "smallcircle.fill.circle")
           redDot.tintColor = .systemRed
           deathsUI.addSubview(redDot)
           redDot.anchor(top: deathsUI.topAnchor, paddingTop: 18)
           redDot.centerX(inView: deathsUI)

           let greenDot = UIImageView()
           greenDot.image = UIImage(systemName: "smallcircle.fill.circle")
           greenDot.tintColor = .systemGreen
           recoveredUI.addSubview(greenDot)
           greenDot.anchor(top: recoveredUI.topAnchor, paddingTop: 18)
           greenDot.centerX(inView: recoveredUI)

           let infectedCount = UILabel()
           infectedCount.text = "3"
           infectedCount.font = UIFont(name: "Avenir-Medium", size: 52)
           infectedUI.addSubview(infectedCount)
           infectedCount.anchor(top: yellowDot.bottomAnchor, paddingTop: 12)
           infectedCount.centerX(inView: infectedUI)

           let deathsCount = UILabel()
           deathsCount.text = "0"
           deathsCount.font = UIFont(name: "Avenir-Medium", size: 52)
           deathsUI.addSubview(deathsCount)
           deathsCount.anchor(top: redDot.bottomAnchor, paddingTop: 12)
           deathsCount.centerX(inView: deathsUI)

           let recoveredCount = UILabel()
           recoveredCount.text = "12"
           recoveredCount.font = UIFont(name: "Avenir-Medium", size: 52)
           recoveredUI.addSubview(recoveredCount)
           recoveredCount.anchor(top: greenDot.bottomAnchor, paddingTop: 12)
           recoveredCount.centerX(inView: recoveredUI)
           
           let infectedLbl = UILabel()
           infectedLbl.text = "Infected"
           infectedLbl.font = UIFont(name: "Avenir-Medium", size: 14)
           infectedLbl.textColor = .darkGray
           infectedUI.addSubview(infectedLbl)
           infectedLbl.anchor(top: infectedCount.bottomAnchor)
           infectedLbl.centerX(inView: infectedUI)
           
           let deathsLbl = UILabel()
           deathsLbl.text = "Deaths"
           deathsLbl.font = UIFont(name: "Avenir-Medium", size: 14)
           deathsLbl.textColor = .darkGray
           deathsUI.addSubview(deathsLbl)
           deathsLbl.anchor(top: deathsCount.bottomAnchor)
           deathsLbl.centerX(inView: deathsUI)
           
           let recoveredLbl = UILabel()
           recoveredLbl.text = "Recovered"
           recoveredLbl.font = UIFont(name: "Avenir-Medium", size: 14)
           recoveredLbl.textColor = .darkGray
           recoveredUI.addSubview(recoveredLbl)
           recoveredLbl.anchor(top: recoveredCount.bottomAnchor)
           recoveredLbl.centerX(inView: recoveredUI)
           
           let countStack = UIStackView(arrangedSubviews: [infectedUI, deathsUI, recoveredUI])
           countStack.axis = .horizontal
           countStack.distribution = .fillEqually
           countStack.spacing = 0
           covidTab.addSubview(countStack)
           countStack.anchor(top: timeAgo.bottomAnchor, left: covidTab.leftAnchor, bottom: covidTab.bottomAnchor, right: covidTab.rightAnchor)
           
           return covidTab
       }()
       
       private let mapTab: UIView = {
           let map = UIView()
           //tile.backgroundColor = .red
           return map
       }()
    
    private var user: User? {
        didSet {
            locationInputUIView.user = user
  
            
        }
    }






    override func viewDidLoad() {
        super.viewDidLoad()
        enableLocationServices()

        configController()
    }

    // MARK: - API
    

    
    
    func fetchUsers() {

        guard let location = locationManager?.location else { return }
        Service.shared.fetchUsersLocation(location: location) { (user) in
            guard let coordinate = user.location?.coordinate else { return }
            let annotation = UserAnnotation(uid: user.uid, coordinate: coordinate)

            let bodyTemp = user.temperature
            let surveyScore = user.surveyScore
            var userIsVisible: Bool {

                return self.userMap.annotations.contains { (annotation) -> Bool in
                    guard let userAnno = annotation as? UserAnnotation else { return false }

                    if userAnno.uid == user.uid {

                          if bodyTemp > 35 && surveyScore >= 3{

                        userAnno.updateAnnotationPosition(withCoordinate: coordinate)

                            let alet = UIAlertController(title: "WARNING", message: "Covid infect patient is near you!! Take safe actions", preferredStyle: .alert)
                    //  let  alertAction = UIAlertAction(title: "OK", style: .default, handler: {self.dismiss(animated: true)})
                         //   alet.addAction(alertAction)
                            alet.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                                action in
                            }))
                           self.present(alet,animated: true)
                        return true
                    }
                    }
                    return false
                }
            }

            if !userIsVisible {
      if bodyTemp > 35 && surveyScore >= 3{
                self.userMap.addAnnotation(annotation)

        let alet = UIAlertController(title: "WARNING", message: "Covid infect patient is near you!! Take safe actions", preferredStyle: .alert)
        alet.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
            action in
        }))
        self.present(alet,animated: true)


          }
            }
        }
    }
    
    
    
    
    @objc func didmissAlert(){
        self.navigationController?.popViewController(animated: true)
    }
    

    // MARK: - Helper Function
    
    func configController() {
        configureNavigationBar()
       configureUI()
       fetchUsers()
       // fetchOtherUsers()
    }

    
    // MARK: - Configuring UI

    func configureUI(){
         configureNavigationBar()
        view.backgroundColor = .systemGray6
               view.addSubview(topViewContainer)
        topViewContainer.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 30 * view.bounds.height/100)
        
        view.addSubview(notificTab)
       // notificTile.anchor(top: mainTile.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16, height: 80)
        notificTab.anchor(top: topViewContainer.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16, height: 80)
        view.addSubview(caseTab)
        caseTab.anchor(top: notificTab.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, height: 25 * view.bounds.height/100)
        view.addSubview(mapTab)
        mapTab.anchor(top: caseTab.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
     setMap()



    }


    func setMap(){

       mapTab.addSubview(userMap)
               userMap.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 220)
               //mapView.frame = view.frame
               print(userMap.bounds.height)
               userMap.showsUserLocation = true
               userMap.userTrackingMode = .follow
               userMap.delegate = self
    }

    // MARK: - Navigation

    func configureNavigationBar() {
           navigationController?.navigationBar.isHidden = true
          // navigationController?.navigationBar.barStyle = .black
       }


   

     // MARK: - Selectors
    
    
    func checkIsUserLoggedIn() {
                           if(Auth.auth().currentUser?.uid == nil) {
               
                              let popAlert = UIAlertController(title: "Please sign in", message: "Guest users cannot view notifications", preferredStyle: .alert)
                                         popAlert.addAction(UIAlertAction(title: "OK", style: .default))
                                        self.present(popAlert, animated: true)
               
               
               
               
               
                           } else {
                               print("DEBUG: User is logged in..")
                               
                           }
                       }
    
    
    
    
        
        @objc func showNotific() {
            checkIsUserLoggedIn()
            print("notific")
      let vc = NotificTableViewViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        @objc func showSafeActions() {
            let vc = SafeActionViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }


    func signOut() {
                  do {
                      try Auth.auth().signOut()
                  } catch {
                      print("DEBUG: sign out error")
                  }
              }


    }


// MARK: - MKMapViewDelegate

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? UserAnnotation {
            let view = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
          //  view.image = UIImage(systemName: "mappin.circle.fill")
            view.image = #imageLiteral(resourceName: "alertVirus")
            view.image?.withTintColor(.red)
            //view.tintColor = .red
            return view
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let route = self.route {
            let polyline = route.polyline
            let lineRenderer = MKPolylineRenderer(overlay: polyline)
            lineRenderer.strokeColor = .mainBlueTint
            lineRenderer.lineWidth = 4
            return lineRenderer
        }
        return MKOverlayRenderer()
    }
}

// MARK: - LocationServices

extension HomeViewController {
    
    func enableLocationServices() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedWhenInUse:
            locationManager?.requestAlwaysAuthorization()
        case .authorizedAlways:
            locationManager?.startUpdatingLocation()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        default:
            break
        }
    }
}


