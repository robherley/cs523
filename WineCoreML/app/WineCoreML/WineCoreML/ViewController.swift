//
//  ViewController.swift
//  WineCoreML
//
//  Created by Robert Herley on 3/27/19.
//  Copyright © 2019 Robert Herley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    enum Fields : String, CaseIterable {
        case Alcohol = "Alcohol"
        case MalicAcid = "Malic Acid"
        case Ash = "Ash"
        case AlkalinityAsk = "Alkalinity Ask"
        case Magnesium = "Magnesium"
        case TotalPhenols = "Total Phenols"
    }

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var labels: [UILabel]?
    @IBOutlet var sliders: [UISlider]?
    @IBOutlet weak var cultivarLabel: UILabel!
    
    let numFormat = NumberFormatter()
    let model = wine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.setCustomSpacing(30, after: (sliders!.last)!)
        numFormat.numberStyle = .decimal
        numFormat.maximumFractionDigits = 2
        for (i, slider) in sliders!.enumerated() {
            self.updateLabels(i: i, val: numFormat.string(for: slider.value) ?? "0")
        }
        self.predictCultivar();
    }

    @IBAction func movedSlider(_ sender: UISlider) {
        let index = sliders!.index(of: sender)!
        let value = numFormat.string(for: sender.value) ?? "0"
        DispatchQueue.main.async {
            self.updateLabels(i: index, val: value);
            self.predictCultivar();
        }
    }
    
    func updateLabels(i index: Int, val value: String){
        let field = Fields.allCases[index]
        let label = labels![index]
        label.text = "\(field.rawValue): \(value)"
    }
    
    func predictCultivar() {
        if let prediction = try? model.prediction(alcohol: Double(sliders![0].value), malicAcid:
            Double(sliders![1].value), ash: Double(sliders![2].value), alkalinityAsh:
            Double(sliders![3].value), magnesium: Double(sliders![4].value), totalPhenols:
            Double(sliders![5].value)) {
            cultivarLabel.text = "Cultivar \(prediction.classLabel) (\(prediction.classProbability[prediction.classLabel] ?? 0))"
        }
    }
}

