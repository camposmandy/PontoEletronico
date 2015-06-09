//
//  ConfiguracaoTableViewController.swift
//  PontoEletronico
//
//  Created by Amanda Guimaraes Campos on 03/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit
import MessageUI

class ConfiguracaoTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var btnFeedBack: UIButton!
    
    @IBAction func btnFeedBack(sender: AnyObject) {
        alerta()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func alerta() {
        
        let nomeAlerta: UIAlertController = UIAlertController(title: "Caso queira uma resposta, favor escolher E-Mail", message: "", preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
        }
        nomeAlerta.addAction(cancelAction)
        
        let appStore: UIAlertAction = UIAlertAction (title: "App Store", style: .Default) { action -> Void in
            
        }
        
        nomeAlerta.addAction(appStore)
        
        let eMail: UIAlertAction = UIAlertAction (title: "E-Mail", style: .Default) { action -> Void in
            
            
            let mailComposeViewController = self.configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
        }
        nomeAlerta.addAction(eMail)
        
        
        self.presentViewController(nomeAlerta, animated: true, completion: nil)
    }

    
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["leonardo_brunassi@hotmail.com"])
        mailComposerVC.setSubject("Feedback")
        mailComposerVC.setMessageBody("", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Impossível mandar um e-mail.", message: "Seu aparelho não pode enviar email.  Por favor, verifique as configurações e tente novamente.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
