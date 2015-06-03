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
    
    var usuario = Usuario()
    var semana = Semana()
    var diaSemana: Array<Semana>?

    @IBOutlet weak var nomeUsuario: UITextField!
    @IBOutlet weak var nomeEmpresa: UITextField!
    @IBOutlet weak var horaEntrada: UITextField!
    @IBOutlet weak var horaSaida: UITextField!
    @IBOutlet weak var horaSaidaAlmoco: UITextField!
    @IBOutlet weak var horaEntradaAlmoco: UITextField!
    @IBOutlet weak var cargaHoraria: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nomeUsuario.delegate = self
        nomeEmpresa.delegate = self
        horaEntrada.delegate = self
        horaSaida.delegate = self
        horaSaidaAlmoco.delegate = self
        horaEntradaAlmoco.delegate = self
        cargaHoraria.delegate = self

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
            alertMsg = "- Informe seu nome\n"
            alert = true
        }
        
        if(nomeEmpresa.text == ""){
            alertMsg = "- Informe o nome da empresa\n"
            alert = true
        }
        
        if(horaEntradaAlmoco.text == ""){
            alertMsg = "- Informe seu horário de saída para o almoço\n"
            alert = true
        }
        if(horaSaidaAlmoco.text == ""){
            alertMsg = "- Informe seu horário de volta do almoço\n"
            alert = true
        }
        if(cargaHoraria.text == ""){
            alertMsg = "- Informe a carga horária"
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
            var format = "hh:mm"
            
            usuario = UsuarioManager.sharedInstance.novoUsuario()
            
            usuario.nome = nomeUsuario.text
            usuario.nomeEmpresa = nomeEmpresa.text
            usuario.horaSaidaAlmoco = dateF.dateFromString(horaSaidaAlmoco.text)!
            usuario.horasAlmoco = (horaEntradaAlmoco.text).toInt()!
            usuario.cargaHorariaSemanal = (cargaHoraria.text).toInt()!
            
           // semana = SemanaManager.sharedInstance.novaSemana()
            //falta semana...
            
            UsuarioManager.sharedInstance.salvar()
        }
    }
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
