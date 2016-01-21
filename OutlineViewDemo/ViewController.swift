//
//  ViewController.swift
//  OutlineViewDemo
//
//  Created by Lars on 21.01.16.
//  Copyright © 2016 Lars. All rights reserved.
//

import Cocoa

class Section {
    let title: String
    let items: [String]
    
    init(title: String, items: [String]) {
        self.title = title
        self.items = items
    }
}

class ViewController: NSViewController, NSOutlineViewDataSource, NSOutlineViewDelegate {
    
    //MARK: NSOutlineViewDataSource
    
    let items = [
        Section(title: "Alpha", items: ["Anton",  "Anita"]),
        Section(title: "Beta",  items: ["Bernd",  "Barbara"]),
        Section(title: "Gamma", items: ["Gustav", "Gesine"])]
    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        switch item {
        case nil:        return items.count
        case is Section: return (item as! Section).items.count
        default:         return 0
        }
    }
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        return item == nil
            ? items[index]
            : (item as! Section).items[index]
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        return item is Section
    }
    
    func outlineView(outlineView: NSOutlineView, objectValueForTableColumn tableColumn: NSTableColumn?, byItem item: AnyObject?) -> AnyObject? {
        return item
    }
    
    //MARK: NSOutlineViewDelegate
    
    func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
        let view = outlineView.makeViewWithIdentifier(item is Section ? "HeaderCell" : "DataCell", owner: self) as! NSTableCellView
        view.textField?.stringValue = item is Section
            ? (item as! Section).title
            : item as! String
        return view
    }
}
