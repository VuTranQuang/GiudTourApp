//
//  ViewController.swift
//  GuidTourApp
//
//  Created by Vu on 06/01/2021.
//

import UIKit
import Instructions

class ViewController: UIViewController {

    @IBOutlet weak var segmentControll: UISegmentedControl!
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var btnButton: UIButton!
    
    let coachMarksController = CoachMarksController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.coachMarksController.delegate = self
        self.coachMarksController.dataSource = self
        
        let skipView = CoachMarkSkipDefaultView()
        skipView.setTitle("Skip", for: .normal)
        self.coachMarksController.skipView = skipView
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !AppManager.getUserSeenAppInstruction() {
            self.coachMarksController.start(in: .viewController(self))
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.coachMarksController.stop(immediately: true)
    }

}

extension ViewController: CoachMarksControllerDataSource, CoachMarksControllerDelegate {
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        switch index {
        case 0:
            coachViews.bodyView.hintLabel.text = "Hello! this is a segmented control you can toggle dark and light mode here"
            coachViews.bodyView.nextLabel.text = "OK!!"
        case 1:
        coachViews.bodyView.hintLabel.text = "This is a search text field you can search for your favourite texts here."
        coachViews.bodyView.nextLabel.text = "Ok!"
            case 2:
        coachViews.bodyView.hintLabel.text = "Yor search texxt will appear here when you hit enter"
        coachViews.bodyView.nextLabel.text = "OK!"
            case 3:
        coachViews.bodyView.hintLabel.text = "Finally you can hit the control button to view your search details!"
        coachViews.bodyView.nextLabel.text = "Ok!"

        default:
            break
        }
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        switch index {
        case 0:
            return coachMarksController.helper.makeCoachMark(for: segmentControll)
        case 1:
            return coachMarksController.helper.makeCoachMark(for: search)
        case 2:
            return coachMarksController.helper.makeCoachMark(for: lblText)
        case 3:
            return coachMarksController.helper.makeCoachMark(for: btnButton)
        default:
            return coachMarksController.helper.makeCoachMark()
        }
    }
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 4
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, didEndShowingBySkipping skipped: Bool) {
        AppManager.setUserSeenAppInstruction()
    }
    
    
}
