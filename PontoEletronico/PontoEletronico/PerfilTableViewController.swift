//
//  PerfilTableViewController.swift
//  PontoEletronico
//
//  Created by Amanda Guimaraes Campos on 03/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class PerfilTableViewController: UITableViewController {

    var usuario : Array<Usuario>!
    var user : Usuario!
    var i = 0
    
    @IBOutlet weak var nomeEmpresa: UILabel!
    @IBOutlet weak var nomeUsuario: UILabel!
    @IBOutlet weak var cargaHoraria: UILabel!
    @IBOutlet weak var tempoAlmoco: UILabel!
    @IBOutlet weak var horarioSaida: UILabel!
    @IBOutlet weak var horarioEntrada: UILabel!
    
    @IBOutlet weak var sabLbl: UILabel!
    @IBOutlet weak var sexLbl: UILabel!
    @IBOutlet weak var quinLbl: UILabel!
    @IBOutlet weak var quaLbl: UILabel!
    @IBOutlet weak var terLbl: UILabel!
    @IBOutlet weak var segLbl: UILabel!
    @IBOutlet weak var domLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preencherLabels()
    }
    
    override func viewDidAppear(animated: Bool) {
        preencherLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }

    func preencherLabels() {
        
        usuario = UsuarioManager.sharedInstance.Usuario()
        
        var horario = NSDateFormatter()
        horario.dateFormat = "HH:mm"
        var minhaCor = UIColor(red: 38/255, green: 166/255, blue: 91/255, alpha: 1)
        
        tempoAlmoco.text = "\(usuario[i].tempoAlmoco) minutos"
        horarioSaida.text = horario.stringFromDate(usuario[i].horaSaida)
        horarioEntrada.text = horario.stringFromDate(usuario[i].horaEntrada)
        nomeUsuario.text = usuario[i].nome
        nomeEmpresa.text = usuario[i].nomeEmpresa
        cargaHoraria.text = "\(usuario[i].cargaHorariaSemanal) horas"
        
        var dia = usuario[i].possuiSemana.allObjects as NSArray
        for i in 0...dia.count-1 {
            var nomeDIa = (dia.objectAtIndex(i) as! Semana).nomeDIa
            
            if nomeDIa == "Domingo" {
                domLbl.textColor = minhaCor
            }
            if nomeDIa == "Segunda" {
                segLbl.textColor = minhaCor
            }
            if nomeDIa == "Terça" {
                terLbl.textColor = minhaCor
            }
            if nomeDIa == "Quarta" {
                quaLbl.textColor = minhaCor
            }
            if nomeDIa == "Quinta" {
                quinLbl.textColor = minhaCor
            }
            if nomeDIa == "Sexta" {
                sexLbl.textColor = minhaCor
            }
            if nomeDIa == "Sábado" {
                sabLbl.textColor = minhaCor
            }
        }
    }
}
