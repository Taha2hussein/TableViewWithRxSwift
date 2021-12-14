//
//  TodoTableViewCell.swift
//  RxSwiftTraining
//
//  Created by A on 13/12/2021.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var todoName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configure(todo:Todo) {
        self.todoName.text = todo.todoName
        if todo.isComplete {
        self.accessoryType = .checkmark
        }
        else {
            self.accessoryType = .none
        }
    }
}
