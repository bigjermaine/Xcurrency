//
//  PieGraphViewController.swift
//  Xcurrency
//
//  Created by MacBook AIR on 17/07/2023.
//

import UIKit
import Charts


class PieGraphViewController: UIViewController {
    
    var lineChart = PieChartView()
    
    var result = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = skyDarkBlueColor
        view.addSubview(lineChart)
        networkCalls()
        
    }
    override func viewDidLayoutSubviews() {
        lineChart.frame = CGRect(x: view.frame.size.width/8,
                                        y: 0,
                                        width: self.view.frame.size.width - (view.frame.size.width/4),
                                        height: self.view.frame.size.width/1.5)
      
       
    }
    
    private func dataSet() {
        for country in result{
            let set =  PieChartDataSet(entries: [
                ChartDataEntry(x: country.rate, y: Double(country.name) ?? 0.00)])
            
            set.colors = ChartColorTemplates.material()
            
            let data = PieChartData(dataSet: set)
            lineChart.data = data
        }
    }
    
    private func networkCalls() {
        NetworkManager.shared.getCountriesData { [weak self] result in
            
            switch result {
            case .success(let result):
                self?.result = Array(result.prefix(12))
                DispatchQueue.main.async {[weak self] in
                    self?.dataSet()
                }
            case .failure(let error):
                print(error.localizedDescription)
              
            }
        }
    }
    
}
