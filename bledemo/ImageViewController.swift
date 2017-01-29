//
//  ImageViewController.swift
//  bledemo
//
//  Created by xiaokelin on 30/01/2017.
//  Copyright © 2017 lxk. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var photoimageview: UIImageView!
    var image: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let meals=NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]{
            if let image = meals[meals.count-1].photo{
                photoimageview.image = image
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoimageview.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }

  
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
   
    
    @IBAction func save(_ sender: Any) {
        guard let photoimageview=photoimageview.image  else {
            return
        }
        
        var meals=[Meal]()
        let meal0 = Meal(volume: 1, photo: photoimageview, isVibrate: true)
        meals.append(meal0!)
                let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
            if isSuccessfulSave {
                print("successfully saved")
            } else {
                print("Failed to save...")
            }

        cancel(self)
    }

    @IBAction func cancel(_ sender: Any) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            return
        }
        let photo = photoimageview.image
        
    }

}
