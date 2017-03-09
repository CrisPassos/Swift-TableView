//
//  MoviesTableViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 08/03/17.
//  Copyright © 2017 EricBrito. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {

    var dataSource: [Movie] = []
    
    func loadLocalJSON(){
        if let jsonURL = Bundle.main.url(forResource: "movies", withExtension: "json"){
        
            let data: Data = try! Data(contentsOf: jsonURL)
            let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as![[String: Any]]
            
            for item in json {
                let title = item["title"] as! String
                let duration = item["duration"] as! String
                let summary = item["summary"] as! String
                let imageName = item["image_name"] as! String
                let rating = item["rating"] as! Double
                
                let movie = Movie(title: title, rating: rating, summary:summary, duration: duration, imageName: imageName)
                
                movie.categoris = item["categories"] as! [String]
                dataSource.append(movie)
            }
            //refresh
            tableView.reloadData()
        }
    }
    
    //prepara a proxima tela
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MovieViewController
        vc.movie = dataSource[tableView.indexPathForSelectedRow!.row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //valor estimado
        tableView.estimatedRowHeight = 106
        tableView.rowHeight = UITableViewAutomaticDimension
        
        loadLocalJSON()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    //Separa por sessoes os itens da tablea
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }

    //configura cada uma das minhas celulas
    //é chamado quando uma celula e apresentada
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //pede para a tabela entregar alguma célula que já foi utilizada
        //utiliza o nome da tabela que está na view
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
            as! MovieTableViewCell

        //popula os dados 
         //acessar os labels
        //cell.textLabel?.text = dataSource[indexPath.row].title
        //cell.detailTextLabel?.text = "\(dataSource[indexPath.row].rating)"
        //cell.imageView?.image = UIImage(named: dataSource[indexPath.row].imageSmall)
        
        cell.ivPoster.image = UIImage(named: dataSource[indexPath.row].imageSmall)
        cell.lblRating?.text =  "😡😡😡😡😡\(dataSource[indexPath.row].rating)"
        cell.lblTitle?.text =  dataSource[indexPath.row].title
        cell.lblSummary?.text = dataSource[indexPath.row].summary
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
