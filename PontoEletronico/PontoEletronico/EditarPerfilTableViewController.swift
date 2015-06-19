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
    var usuarios: Array<Usuario>?
    
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
        
        usuarios = UsuarioManager.sharedInstance.Usuario()
        
        if usuarios?.count != 0 {
            if let us = usuarios?[0] {
                usuario = us
            }
        }
        
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
        if verificacaoDosCampos() {
            var dateF = NSDateFormatter()
            var format = "HH:mm"
            
            if usuarios?.count != 0 {
                usuario = usuarios?[0]
            } else {
                usuario = UsuarioManager.sharedInstance.novoUsuario()
            }

            usuario.nome = nomeUsuario.text
            usuario.nomeEmpresa = nomeEmpresa.text
            usuario.cargaHorariaSemanal = (cargaHoraria.text).toInt()!
            usuario.horaEntrada = horarioEntrada.date
            usuario.horaSaida = horarioSaida.date
            usuario.tempoAlmoco = (tempoAlmoco.text as NSString).integerValue
            
            diaSemana = SemanaManager.sharedInstance.Semana()
            
            for i in 0..<self.semanaAux.count {
                if semanaAux[i] == true {
                    var dia = diaSemana?[i]
                    usuario.adcSemana(dia!)
                }
            }
            
            UsuarioManager.sharedInstance.salvar()
            notificacaoManda()
        }
    }
    
    func notificacaoManda(){
        if let ll = usuario{
            var diasSemanaTrab = ll.possuiSemana.allObjects as NSArray
            var diasSemana = ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta","Sábado"]
            var i  = 0
            for dia in diasSemana {
                for i in 0..<diasSemanaTrab.count{
                    var mm = diasSemanaTrab[i] as! Semana
                    if  dia == mm.nomeDIa {
                        var notificacao = UILocalNotification()
                        var format = NSDateFormatter()
                        
                        format.dateFormat = "yyyy/MM/dd hh:mm:ss"
                        format.dateFromString("2015/06/14 ")
                        let hora = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitHour, fromDate: ll.horaEntrada)
                        let min = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitMinute, fromDate: ll.horaEntrada)
                        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
                        let dataNotificacao = NSDateComponents()
                        let calendarAux = NSCalendar.currentCalendar()
                        
                        dataNotificacao.year = 2015
                        dataNotificacao.month = 06
                        dataNotificacao.day = 14 + i
                        dataNotificacao.hour = hora.hour
                        dataNotificacao.minute = min.minute
                        dataNotificacao.second = 10
                        
                        let dateNot = calendar!.dateFromComponents(dataNotificacao)
                        
                        notificacao.alertAction = "Ir ao App"
                        notificacao.alertBody = "Faltam 15 minutos para o inicio do expediente."
                        notificacao.soundName = UILocalNotificationDefaultSoundName
                        notificacao.fireDate = calendarAux.dateByAddingUnit(.CalendarUnitMinute, value: -15, toDate: dateNot!, options: nil)
                        notificacao.repeatInterval = NSCalendarUnit.CalendarUnitWeekday
                        
                        UIApplication.sharedApplication().scheduleLocalNotification(notificacao)
                        println("Data: \(dateNot)")
                    }
                }
            }
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

