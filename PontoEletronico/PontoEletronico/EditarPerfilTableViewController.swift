//
//  DetalhePerfilTableViewController.swift
//  PontoEletronico
//
//  Created by Amanda Guimaraes Campos on 03/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//
import CoreData
import UIKit

class EditarPerfilTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var btnCancelar: UIBarButtonItem!
    
    var usuario: Usuario!
    var semana: Semana!
    var diaSemana: Array<Semana>?
    var semanaAux = [false, false, false, false, false, false, false]

    @IBOutlet weak var nomeUsuario: UITextField!
    @IBOutlet weak var nomeEmpresa: UITextField!
    @IBOutlet weak var cargaHoraria: UITextField!
    @IBOutlet weak var tempoAlmoco: UITextField!
    @IBOutlet weak var horarioEntrada: UIDatePicker!
    @IBOutlet weak var horarioSaida: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cargaHoraria.delegate = self
        
        self.tabBarController?.tabBar.hidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func botaoCancelar(sender: AnyObject){
        self.navigationController?.popViewControllerAnimated(true)
    }

    func verificacaoDosCampos() -> Bool{
        var aux: Bool?
        var alert = false
        var alertMsg = ""
        var alertT = "Atenção"
        
        if(nomeUsuario.text == ""){
            alertMsg += "- Informe seu nome\n"
            alert = true
        }
        
        if(nomeEmpresa.text == ""){
            alertMsg += "- Informe o nome da empresa\n"
            alert = true
        }

        if(cargaHoraria.text == ""){
            alertMsg += "- Informe a carga horária\n"
            alert = true
        }
        
        if semanaAux == [false, false, false, false, false, false, false] {
            alertMsg += "- Escolha um dia da Semana"
            alert = true
        }
        
        if(alert == false){
            alertMsg = "Perfil criado com sucesso!"
            alertT = "Sucesso"
            aux = true
        } else {
            aux = false
        }
        
        let alerta = UIAlertController(title: alertT, message: alertMsg, preferredStyle: .Alert)
        let ok = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
            if(aux == true){
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
        
        alerta.addAction(ok)
        self.presentViewController(alerta, animated: true, completion: nil)
        return aux!
    }
    
    @IBAction func salvar(sender: AnyObject){
        if verificacaoDosCampos(){
            var dateF = NSDateFormatter()
            var format = "HH:mm"
            
            usuario = UsuarioManager.sharedInstance.novoUsuario()
            
            usuario.nome = nomeUsuario.text
            usuario.nomeEmpresa = nomeEmpresa.text
            usuario.cargaHorariaSemanal = (cargaHoraria.text).toInt()!
            usuario.horaEntrada = horarioEntrada.date
            usuario.horaSaida = horarioSaida.date
            //usuario.horaSaidaAlmoco = horarioSaidaAlmoco.date
            //usuario.horaVoltaAlmoco = horarioVoltaAlmoco.date
            usuario.tempoAlmoco = (tempoAlmoco.text as NSString).integerValue
            
            diaSemana = SemanaManager.sharedInstance.Semana()
            
            
            for i in 0..<self.semanaAux.count {
                if semanaAux[i] == true {
                    var dia = diaSemana?[i]
                    usuario.adcSemana(dia!)
                }
            }
            
            UsuarioManager.sharedInstance.salvar()
            //SemanaManager.sharedInstance.salvar()
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "verDiaSemana" {
            if let proxVC = segue.destinationViewController as? DiaSemanaViewController {
                proxVC.senderViewController = self
            }
        }

    }
    

}
