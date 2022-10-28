//
//  MainViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 26.12.2021.
//

import Foundation
import UIKit

class RoomsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var roomDict: [Int: RoomStruct] = [:]
    let JSONDataClass = JsonDataClass()
    var currentRoom: Int = 0
    private var safeArea: UILayoutGuide!
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var testAddButton: UIButton!
    @IBOutlet weak var allRoomLabel: UILabel!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var mainThemeView: UIView!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var mainThemeImage: UIImageView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.layer.backgroundColor = UIColor.white.cgColor
        getData()
        safeArea = view.layoutMarginsGuide
        setTheViewController()
        setMainTheme()
        setAllRoomLabel()
        refreshController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getData()
        mainCollectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getData()
        mainCollectionView.reloadData()
    }
    
    func refreshController() {
        refreshControl.bounds = CGRect(x: allRoomLabel.frame.maxX, y: allRoomLabel.frame.maxY, width: 50, height: 50)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .black
        mainCollectionView.addSubview(refreshControl)
    }

    @objc func refresh(_ sender: AnyObject) {
        mainCollectionView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func getData() {
        if let oldDictionary = JSONDataClass.getOldData() {
            roomDict = oldDictionary
        }
    }
    
    func updateData() {
        guard let newDictionary = JSONDataClass.getNewData() else { return }
        self.roomDict = JSONDataClass.compareData(oldDictionary: self.roomDict, newDictionary: newDictionary)
        JSONDataClass.saveData(dictionary: self.roomDict)
        mainCollectionView.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let inset = scrollView.contentInset
        let y: CGFloat = offset.x - inset.left
        let reload_distance: CGFloat = -80

        if y < reload_distance{
            mainCollectionView.reloadData()
        }
    }
    
    
    
    
    @IBAction func addButtonGetPressed(_ sender: Any) {
        updateData()
    }
    
    /**
     Функция устанвки параметров UICollectionView
     */
    
    func setAllRoomLabel() {
        allRoomLabel.text = "Все комнаты"
        allRoomLabel.font = UIFont(name: "Inter-Bold", size: 24)
        allRoomLabel.textColor = .white
        allRoomLabel.textAlignment = .center
        blueView.addSubview(allRoomLabel)
    }
    
    func setMainTheme() {
        
        mainThemeView.center.y += 50
        
        let image = UIImage(named: "mainTheme")?.cgImage
        let layerImage = CALayer()
        layerImage.contents = image
        layerImage.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0))
        layerImage.bounds = mainThemeView.bounds
        layerImage.position = mainThemeView.center
        mainThemeView.layer.addSublayer(layerImage)
        
        
        let layerGradient = CAGradientLayer()
        layerGradient.colors = [
            UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1).cgColor,
          UIColor(red: 0.358, green: 0.384, blue: 1, alpha: 1).cgColor
        ]
        layerGradient.locations = [0.27, 0.79]
        layerGradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        layerGradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        layerGradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.25, b: 0, c: 2.23, d: 5.52, tx: -1.11, ty: -2.26))
        layerGradient.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        layerGradient.position = view.center
        blueView.layer.addSublayer(layerGradient)
        testAddButton.setTitle(" ", for: .normal)
        blueView.addSubview(testAddButton)
        
    }
    
    
    func setTheViewController() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        mainCollectionView.collectionViewLayout = layout
        mainCollectionView.backgroundColor = .white
        mainCollectionView.layer.cornerRadius = 30
    }
    
    //MARK: Working with segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CurrentRoom5" {
            let currentRoomVC = segue.destination as! CurrentRoom5ViewController
            currentRoomVC.currentRoom = self.roomDict[currentRoom]
        }
    }
    
    //MARK: Working with collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roomDict.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainViewControllerCell", for: indexPath) as? CollectionViewCell {
            let room = roomDict[indexPath.row]
            roomCell.configure(withPeople: room!.people, withName: room!.name, withTemp: room!.temp, withWet: room!.hum, withCO2: room!.co2, rId: room!.rId)
            roomCell.peopleImageView.image = UIImage(named: "UnionpeopleYellow")
            roomCell.backgroundColor = .tintColor
            roomCell.layer.backgroundColor = UIColor(red: 0.969, green: 0.991, blue: 1, alpha: 1).cgColor
            cell = roomCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let constrain: CGFloat = 10
        return constrain
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let constrain: CGFloat = 10
        return constrain
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        currentRoom = Int(cell.currentRoom!)!
        UIView.animate(withDuration: 0.05, delay: 0, animations: {cell.alpha = 0.5}, completion: {_ in UIView.animate(withDuration: 0.05, delay: 0, animations:  {cell.alpha = 1})})
        self.performSegue(withIdentifier: "CurrentRoom5", sender: self)
    }
}

extension RoomsViewController:  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 50
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize / 2, height: collectionViewSize / 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = 20
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}
