//
//  ViewController.swift
//  MockData
//
//  Created by Cesar Gonzalez on 4/3/17.
//  Copyright © 2017 Cesar Gonzalez. All rights reserved.
//

import UIKit
import Parse
// TODO: add text fields instead of needing to relaunch app to change vars

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var createRequestButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if PFUser.current() != nil {
            //show sign out button
            textLabel.text = "\(String(describing: PFUser.current()!.username!)) is logged in"
            signInButton.isHidden = true
            signUpButton.isHidden = true
            signOutButton.isHidden = false
            createRequestButton.isHidden = false

        } else {
            // show sign in button
            textLabel.text = "no one is logged in"
            signInButton.isHidden = false
            signUpButton.isHidden = false
            signOutButton.isHidden = true
            createRequestButton.isHidden = true
        }
    }

    @IBAction func onSignIn(_ sender: UIButton) {
        PFUser.logInWithUsername(inBackground: "walker1", password: "walker1") { (user: PFUser?, error: Error?) in
            if user != nil {
                print("success logging in!")
                self.textLabel.text = "\(String(describing: PFUser.current()!.username!)) is logged in"
                self.signInButton.isHidden = true
                self.signUpButton.isHidden = true
                self.signOutButton.isHidden = false
                self.createRequestButton.isHidden = false
            } else {
                print("\(String(describing: error?.localizedDescription))")
            }
        }
    }

    @IBAction func onSignUp(_ sender: UIButton) {
        let newUser = PFUser()
        newUser.username = "walker1"
        newUser.password = "walker1"
        newUser["firstName"] = "walker1"
        newUser["lastName"] = "walker1"
        newUser["phone"] = 4444444444
        newUser["driver"] = false
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                print("success signing up")
                self.textLabel.text = "\(String(describing: PFUser.current()!.username!)) is logged in"
                self.signInButton.isHidden = true
                self.signUpButton.isHidden = true
                self.signOutButton.isHidden = false
                self.createRequestButton.isHidden = false

            } else {
                print("\(String(describing: error?.localizedDescription))")
            }
        }

    }
    @IBAction func onSignOut(_ sender: UIButton) {
        PFUser.logOutInBackground { (error: Error?) in
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
                print("logging out")
                self.textLabel.text = "no on is logged in"
                self.signInButton.isHidden = false
                self.signUpButton.isHidden = false
                self.signOutButton.isHidden = true
                self.createRequestButton.isHidden = true
            }
        }
    }
    @IBAction func createRequest(_ sender: UIButton) {
        Request.postRequest { (success: Bool, error: Error?) in
            if success {
                print("request created")
                self.createRequestButton.isHidden = true
            } else {
                print("not created: \(String(describing: error?.localizedDescription))")
            }

        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
