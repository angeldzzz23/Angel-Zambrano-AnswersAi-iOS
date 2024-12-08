//
//  UITableView+Extension.swift
//  AppStore
//
//  Created by angel zambrano on 12/6/24.
//


import UIKit


extension UITableView {
    
    /// Registers a UITableViewCell class with the table view.
       /// - Parameter cell: The UITableViewCell type to register.
       ///
       /// This method simplifies the registration process by using the class name of the cell
       /// as its reuse identifier. It avoids the need to manually specify a string identifier.
    func registerCell<Cell: UITableViewCell>(_ cell: Cell.Type) {
        register(cell, forCellReuseIdentifier: String(describing: cell))
    }

    // Dequeues a reusable UITableViewCell for the given index path.
        /// - Parameter indexPath: The index path specifying the location of the cell.
        /// - Returns: A UITableViewCell of the expected type.
        ///
        /// This method simplifies cell dequeuing and ensures type safety by automatically
        /// casting the dequeued cell to the specified type. If the cast fails, the method
        /// throws a runtime error with a descriptive message.
    func dequeueReusableCell<Cell: UITableViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier,
                                                  for: indexPath) as? Cell else {
                                                    fatalError("Error for cell id: \(identifier) at \(indexPath))")
        }
        return cell
    }
}
