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

class PhotoViewController: UIViewController, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Save the image user selected into core data.
        saveImage(image)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Save image into core data.
    func saveImage(img: UIImage) {
        //get the description of the entity
        let photoDescription = NSEntityDescription.entityForName("Photo", inManagedObjectContext: moContext!)
        
        //create the Managed Object to be inserted into the CoreData
        let photo = Photo(entity: photoDescription!, insertIntoManagedObjectContext: moContext!)
        
        let imgData = UIImageJPEGRepresentation(img, 1)
        
        photo.pImage = imgData
        
    }
    
    // Define cells.
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // If the indexPath is the last cell, it's a button cell.
        if (indexPath.row == numOfCell) {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("addPhotoCell", forIndexPath: indexPath) as! AddPhotoCell
            cell.addPhotoButton.tag = indexPath.row
            cell.addPhotoButton.addTarget(self, action: "getPhotoFromAlbum:", forControlEvents: .TouchUpInside)
            return cell
        }
            // Else, a photo cell.
        else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("photoCell", forIndexPath: indexPath) as! PhotoCell
            let photo = photos[indexPath.row]
            cell.image?.contentMode = .ScaleAspectFit
            cell.image?.image = UIImage(data: photo.pImage)
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Return the number of rows in the section.
        return numOfCell
    }
    
    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        // Load images from core data.
        println("Start loading images...")
        var error: NSError?
        let request = NSFetchRequest(entityName: "Photo")
        photos = moContext?.executeFetchRequest(request, error: &error) as! [Photo]
        println("loading finished")
        
        // Set variable numOfCell.
        numOfCell = photos.count+1
        
        // Reload the photoList view.
        self.photoList.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
