//
//  DiaSemanaViewController.swift
//  PontoEletronico
//
//  Created by Amanda Guimaraes Campos on 08/06/15.
//  Copyright (c) 2015 Amanda Guimaraes Campos. All rights reserved.
//

import UIKit

class DiaSemanaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var diaSemana: Array<Semana>!
    var semana = [false, false, false, false, false, false, false]

    var senderViewController: EditarPerfilTableViewController?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        diaSemana = SemanaManager.sharedInstance.Semana()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaSemana!.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath)
        if (cell?.accessoryType == UITableViewCellAccessoryType.Checkmark){
            cell?.accessoryType = UITableViewCellAccessoryType.None
            semana[indexPath.row] = false
        }
        else {
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            semana[indexPath.row] = true
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cellSemana", forIndexPath: indexPath) as! DiaSemanaTableViewCell
        
        cell.diaLbl.text = diaSemana?[indexPath.row].nomeDIa
        
        return cell
    }
    
    override func viewWillDisappear(animated: Bool) {
        senderViewController?.semanaAux = semana
    }
    
}

