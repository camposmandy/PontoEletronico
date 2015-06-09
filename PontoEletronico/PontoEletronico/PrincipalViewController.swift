//
//  PrincipalViewController.swift
//  PontoEletronico
//
//  Created by Amanda Guimaraes Campos on 03/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class PrincipalViewController: UIViewController {

    var tempo = NSTimer()
    var inicioTempo = NSTimeInterval()
    
    @IBOutlet weak var graficoUm: JMView!
    @IBOutlet weak var graficoDois: JMView!
    @IBOutlet weak var tempoLabel: UILabel!
    @IBOutlet weak var entrada: UIButton!
    
    
    @IBAction func entrada(sender: AnyObject) {
        tempo = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "atualizaTempo", userInfo: nil, repeats: true)
        inicioTempo = NSDate.timeIntervalSinceReferenceDate()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        verificaPrimeiroAcesso()
       
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func verificaPrimeiroAcesso() {
        var userDefault = NSUserDefaults()
        var acesso = userDefault.objectForKey("Acesso") as? String
        if acesso == nil {
            var domingo: Semana
            domingo = SemanaManager.sharedInstance.novaSemana()
            domingo.nomeDIa = "Domingo"
            SemanaManager.sharedInstance.salvar()
            
            var segunda: Semana
            segunda = SemanaManager.sharedInstance.novaSemana()
            segunda.nomeDIa = "Segunda"
            SemanaManager.sharedInstance.salvar()
            
            var terca: Semana
            terca = SemanaManager.sharedInstance.novaSemana()
            terca.nomeDIa = "Terça"
            SemanaManager.sharedInstance.salvar()
            
            var quarta: Semana
            quarta = SemanaManager.sharedInstance.novaSemana()
            quarta.nomeDIa = "Quarta"
            SemanaManager.sharedInstance.salvar()
            
            var quinta: Semana
            quinta = SemanaManager.sharedInstance.novaSemana()
            quinta.nomeDIa = "Quinta"
            SemanaManager.sharedInstance.salvar()
            
            var sexta: Semana
            sexta = SemanaManager.sharedInstance.novaSemana()
            sexta.nomeDIa = "Sexta"
            SemanaManager.sharedInstance.salvar()
            
            var sabado: Semana
            sabado = SemanaManager.sharedInstance.novaSemana()
            sabado.nomeDIa = "Sábado"
            SemanaManager.sharedInstance.salvar()
            
            let VCEdit = self.storyboard?.instantiateViewControllerWithIdentifier("editarView") as? EditarPerfilTableViewController
            VCEdit?.btnCancelar.enabled = false
            self.navigationController?.pushViewController(VCEdit!, animated: false)
            
            userDefault.setObject("JaAcessou", forKey: "Acesso")
        }
    }
    
    func atualizaTempo(){
        var tempoAtual = NSDate.timeIntervalSinceReferenceDate() as NSTimeInterval
        var tempoDecorrido = tempoAtual - inicioTempo
        
        let minutos = UInt8(tempoDecorrido/60.0)
        tempoDecorrido -= (NSTimeInterval(minutos)*60)
        
        let segundos = UInt8(tempoDecorrido)
        tempoDecorrido -= NSTimeInterval(segundos)
        
        let fracao = UInt8(tempoDecorrido*100)
        
        let strMinutos = minutos > 9 ? String(minutos):"0" + String(minutos)
        let strSegundos = segundos > 9 ? String(segundos): "0" + String(segundos)
        let strFracao = fracao > 9 ? String(fracao): "0" + String(fracao)
        
        tempoLabel.text = "\(strMinutos):\(strSegundos):\(strFracao)"

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
