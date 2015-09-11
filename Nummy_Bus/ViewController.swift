//
//  ViewController.swift
//  Nummy_Bus
//
//  Created by Cheng Sun on 2015-08-16.
//  Copyright (c) 2015 Cheng Sun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        var storyboard = UIStoryboard(name: "Photo", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("addNewItem") as! UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

