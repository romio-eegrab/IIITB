//
//  FindProfessorController.swift
//  IIITB
//
//  Created by Generic Generic on 11/02/20.
//  Copyright © 2020 Generic Generic. All rights reserved.
//

import UIKit

class FindProfessorController: UIViewController {

    
    @IBOutlet weak var professorsTblview: UITableView!
    var sharedLocationView = SharedLocationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sharedLocationView = SharedLocationView.instanceFromNib() as! SharedLocationView
        sharedLocationView.frame = CGRect(x:0, y: 130, width:self.view.frame.size.width, height:(70 ))
        self.view.addSubview(sharedLocationView)
        
        professorsTblview.register(UINib(nibName: "FindPersonsCell", bundle: nil), forCellReuseIdentifier: "FindPersonsCell")
        professorsTblview.dataSource = self
        professorsTblview.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        showAlert(title: "Alert", message: "This part is under development", noOfButton: 1)
    }


}
extension FindProfessorController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // let cell =
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindPersonsCell", for: indexPath) as! FindPersonsCell
        cell.borderView.setCirculer()
        cell.borderView.setBorder(color: UIColor.yellow.cgColor, borderWidth: 2)
        cell.nameTitle.text = "Romio Prasad Bera"
        cell.distanceTitle.text = "800 meter"
        cell.profileImg.contentMode = .scaleAspectFit
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    
    
}
