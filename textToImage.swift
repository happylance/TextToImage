#!/usr/bin/env swift

import AppKit
import CoreGraphics

func imageFromString(string: String, size: CGSize, path: String) {
    let style: NSMutableParagraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
    style.alignment = .Center
    
    let fontSize = floor(min(size.width, size.height) * 0.8)
    let font = NSFont(name:"Helvetica", size: fontSize)
    let attr = NSDictionary(objects:[font!, NSColor.blackColor(), style],forKeys: [NSFontAttributeName, NSForegroundColorAttributeName, NSParagraphStyleAttributeName])

    let image = NSImage(size:size)
    image.lockFocus();
    
    let textHeight = floor(fontSize * 1.1)
    let y = floor((size.height - textHeight) / 2.0)
    
    let rect = NSRect(origin: NSPoint(x: 0, y: y), size: NSSize(width: size.width, height: textHeight))
    
    NSColor.greenColor().drawSwatchInRect(NSRect(origin: NSPoint(x: 0, y: 0), size: size))
    string.drawInRect(rect, withAttributes: attr as? [String : AnyObject])
    image.unlockFocus();
    
    image.backgroundColor = NSColor.greenColor()
    try! image.TIFFRepresentation?.writeToFile(path, options:.AtomicWrite)
}

var path: String = "/tmp/iconWithText.png"


let arguments = Process.arguments
if arguments.count >= 3 {
    path = arguments[2]
}

var string = "🔑"
if arguments.count >= 2 {
    string = arguments[1]
}

var width = 1024
var height = 1024
if arguments.count >= 4 {
    width = Int(arguments[3]) ?? width
}
if arguments.count >= 5 {
    height = Int(arguments[4]) ?? height
}

imageFromString(string, size: NSSize(width: width, height: height), path: path)
print(path)

