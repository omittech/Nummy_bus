//
//  PhotoViewController.swift
//  Nummy_Bus
//
//  Created by Ralph Wang on 2015-09-06.
//  Copyright (c) 2015 Cheng Sun. All rights reserved.
//

import UIKit
import Photos
import CoreData


var testImage: UIImage? = UIImage(named: "FoodImage.jpg")

class PhotoViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var itemName: UITextField!
    @IBOutlet var itemPrice: UITextField!
    @IBOutlet var note: UITextView!
    
    @IBAction func backBtn(sender: AnyObject) {
        // Cancel this page.
    }

    @IBAction func chefBtn(sender: AnyObject) {
        //
    }
    @IBAction func addToMenuBtn(sender: AnyObject) {
        // Get the description of the entity.
        let DishDescription = NSEntityDescription.entityForName("Dish", inManagedObjectContext: moContext!)
        
        // Create the Managed Object to be inserted into the CoreData.
        let dish = Dish(entity: DishDescription!, insertIntoManagedObjectContext: moContext!)
        
        dish.dName = itemName.text
        dish.dPrice = itemPrice.text
        dish.dNote = note.text
        NSLog("Dish saved!")
    }
    
    
    let moContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var photos = [Photo]()
    
    var picker: UIImagePickerController = UIImagePickerController()
    
    var numOfCell = 0
    
    // Action for add photo button.
    @IBAction func getPhotoFromAlbum(sender: AnyObject) {
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.allowsEditing = false
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    
    // Define the collection view.
    @IBOutlet var photoList: UICollectionView!
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        NSLog("Selected one image!")
        saveImage(image)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        NSLog("Clicked cancel button!")

    }
    
    // Save image into core data.
    func saveImage(img: UIImage) {
        //get the description of the entity
        let photoDescription = NSEntityDescription.entityForName("Photo", inManagedObjectContext: moContext!)
        
        //create the Managed Object to be inserted into the CoreData
        let photo = Photo(entity: photoDescription!, insertIntoManagedObjectContext: moContext!)
        
        let imgData = UIImageJPEGRepresentation(img, 1)
        
        photo.pImage = imgData
        NSLog("Image saved!")
        
    }
    
    // Define cells.
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // If the indexPath is the last cell, it's a button cell.
        if (indexPath.row == numOfCell-1) {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("addPhotoCell", forIndexPath: indexPath) as! AddPhotoCell
            cell.addPhotoButton.tag = indexPath.row
            cell.addPhotoButton.addTarget(self, action: "getPhotoFromAlbum:", forControlEvents: .TouchUpInside)
            NSLog("A button cell is created!")
            return cell
        }
        // Else, a photo cell.
        else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("photoCell", forIndexPath: indexPath) as! PhotoCell
            let photo = photos[indexPath.row]
            cell.image?.contentMode = .ScaleAspectFit
            cell.image?.image = UIImage(data: photo.pImage)
            NSLog("A image cell is created!")
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Return the number of rows in the section.
        NSLog("%@ cells in the collection view!", numOfCell)
        return numOfCell
    }
    
    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        itemName.delegate = self
        itemPrice.delegate = self
        note.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Load images from core data.
        NSLog("Start loading images...")
        var error: NSError?
        let request = NSFetchRequest(entityName: "Photo")
        photos = (try! moContext?.executeFetchRequest(request)) as! [Photo]
        NSLog("Loading finished!")
        
        // Set variable numOfCell.
        numOfCell = photos.count+1
        
        // Reload the photoList view.
        photoList.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
