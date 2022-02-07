//
//  MainViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 26.12.2021.
//

import Foundation
import UIKit

class RoomsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var rooms: [CurrentRoomClass] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var safeArea: UILayoutGuide!
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.backgroundColor = UIColor(red: 0.867, green: 0.918, blue: 0.953, alpha: 1)
        navigationController?.navigationBar.backgroundColor = UIColor(red: 0.867, green: 0.918, blue: 0.953, alpha: 1)
        safeArea = view.layoutMarginsGuide
        setTheViewController()
        fetchCurrentRooms()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCurrentRooms()
    }
    
    @IBAction func addButtonGetPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Test creator", message: "Fill all the rows: Name, temp, wet, co2", preferredStyle: .alert)
        alert.addTextField()
        
        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
            let nameField = alert.textFields![0]
            
            let newRoom = CurrentRoomClass(context: self.context)
            newRoom.roomName = nameField.text
            newRoom.co2 = "123"
            newRoom.wet = "234"
            newRoom.temperature = "24"
            do {
                try self.context.save()
            }
            catch {
                print("error in add")
            }
            // reload info
            self.fetchCurrentRooms()
        }
        
        alert.addAction(submitButton)
        present(alert, animated: true, completion: nil)
    }
    
    func fetchCurrentRooms() {
        do {
            self.rooms = try context.fetch(CurrentRoomClass.fetchRequest())
            
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
            }
        } catch {
            print("Saving error")
        }
    }
    
    private func initLayoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes?{
        let layoutAttributes =   UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let radius = 100
        let center = (mainCollectionView?.center)!
        let angle = (CGFloat(indexPath.row)  /  CGFloat(indexPath.row) * CGFloat.pi * 2)
        layoutAttributes.center = CGPoint.init(x:  center.x + cos(angle) * CGFloat(radius)   , y: center.y + sin(angle) * CGFloat(radius) )
        layoutAttributes.bounds  = CGRect.init(x: 0, y: 0, width: 100, height: 100 )
        return layoutAttributes
    }
    
    /**
     Функция устанвки параметров UICollectionView
     */
    func setTheViewController() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        mainCollectionView.collectionViewLayout = layout
        mainCollectionView.backgroundColor = UIColor.init(_colorLiteralRed: 0.949, green: 0.969, blue: 0.976, alpha: 1)
        mainCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        mainCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    //MARK: Working with segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CurrentRoomSegue" {
            let curentRoomCellIndex = mainCollectionView.indexPathsForSelectedItems![0][1]
            let currentRoomVC = segue.destination as! CurrentRoomViewController
            currentRoomVC.currentRoom = self.rooms[curentRoomCellIndex]
        }
    }
    
    //MARK: Working with collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainViewControllerCell", for: indexPath) as? CollectionViewCell {
            roomCell.configure(withName: self.rooms[indexPath.row].roomName!, withTemp: self.rooms[indexPath.row].temperature!, withWet: self.rooms[indexPath.row].wet!, withCO2: self.rooms[indexPath.row].co2!)
            roomCell.peopleImageView.image = UIImage(named: "people")
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
        let cell = collectionView.visibleCells[indexPath.row]
        UIView.animate(withDuration: 0.05, delay: 0, animations: {cell.alpha = 0.5}, completion: {_ in UIView.animate(withDuration: 0.05, delay: 0, animations:  {cell.alpha = 1})})
        self.performSegue(withIdentifier: "CurrentRoomSegue", sender: self)
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
