//
//  ConfiguracaoTableViewController.swift
//  PontoEletronico
//
//  Created by Amanda Guimaraes Campos on 03/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit
import MessageUI
import Social

class ConfiguracaoTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {

    let cancelar = UIAlertAction(title: "Cancel", style: .Cancel) { action in }
    var usuarioAux : Usuario!
    
    @IBOutlet weak var btnFeedBack: UIButton!
    
    @IBAction func btnFeedBack(sender: AnyObject) {
        alerta()
    }
    
    @IBAction func btnFacebook(sender: AnyObject) {
        compartilharFB()
    }
    @IBAction func btnZerarBanco(sender: AnyObject) {
        alertaBancoDeHoras()
    }

    @IBAction func btnApagar(sender: AnyObject) {
        alertaDiasTrabalhados()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func alerta() {
        
        let nomeAlerta: UIAlertController = UIAlertController(title: "Caso queira uma resposta, favor escolher E-Mail", message: "", preferredStyle: .ActionSheet)

        nomeAlerta.addAction(cancelar)
        
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
    
    func alertaDiasTrabalhados(){
        let alert: UIAlertController = UIAlertController(title: "Atenção", message: "Tem certeza que deseja apagar tudo?", preferredStyle: .Alert)
        let ok: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            DiaTrabalhadoManager.sharedInstance.deletarTudo()
            DiaTrabalhadoManager.sharedInstance.salvar()
        }
        
        alert.addAction(ok)
        alert.addAction(cancelar)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func alertaBancoDeHoras(){
        let alert: UIAlertController = UIAlertController(title: "Atenção", message: "Tem certeza que deseja apagar o banco de horas?", preferredStyle: .Alert)
        let ok: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            let usuarios = UsuarioManager.sharedInstance.Usuario()
            let usuario = usuarios![0] as Usuario
            
            usuario.bancoHoras = 0
            UsuarioManager.sharedInstance.salvar()
        }
        
        alert.addAction(ok)
        alert.addAction(cancelar)
        
        self.presentViewController(alert, animated: true, completion: nil)
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

    func compartilharFB(){
        
        if (SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook)) {
            var facebookShare: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            facebookShare.setInitialText("Estou utilizando o PontoEletronico!")
            
            self.presentViewController(facebookShare, animated: true, completion: nil)
            
        } else {
            var alert = UIAlertController(title: "Conta", message: "Favor fazer o login no Facebook", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
