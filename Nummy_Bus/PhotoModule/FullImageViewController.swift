//
//  FullImageViewController.swift
//  Nummy_Bus
//
//  Created by Ralph Wang on 2015-09-10.
//  Copyright (c) 2015 Cheng Sun. All rights reserved.
//

import UIKit

class FullImageViewController: UIViewController {

    @IBOutlet var FullImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        FullImage.image = testImage
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
