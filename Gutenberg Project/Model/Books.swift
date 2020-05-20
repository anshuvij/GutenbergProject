//
//  Books.swift
//  Gutenberg Project
//
//  Created by Anshu Vij on 5/19/20.
//  Copyright © 2020 Anshu Vij. All rights reserved.
//

import Foundation


struct Books  {
    let title : String
    let authorname : String
    let imageLink : String
    let format : String
   
    init(_ books : Dictionary<String,Any>) {
        self.title = (books["title"] as? String)!
        let authors = books["authors"]as? [Dictionary<String,Any>]
        if authors!.count > 0
        {
        let authorName = ((authors![0]["name"]) as? String)!
            let array = authorName.components(separatedBy: ", ")
            if array.count>1
            {
               self.authorname = array[1]+" "+array[0]
            }
            else
            {
                self.authorname = array[0]
                
            }
        }
        else
        {
            self.authorname = "NA"
        }
        let imageJson = books["formats"] as? Dictionary<String,String>
        self.imageLink = (imageJson?["image/jpeg"]!) as! String
        
         if let link = imageJson!["text/html"] {
             self.format = link
        }
        else if let link = imageJson!["text/html; charset=utf-8"] {
            self.format = link
        }
        else if let link = imageJson!["text/html; charset=iso-8859-1"] {
             self.format = link
        }
        else if let link = imageJson!["application/pdf"] {
                 self.format = link
            }
        else if let link = imageJson!["text/plain"] {
             self.format = link
        }
        else if let link = imageJson!["text/plain; charset=utf-8"] {
             self.format = link
        }
        else if let link = imageJson!["text/html; charset=us-ascii"] {
             self.format = link
        }
        else if let link = imageJson!["text/plain; charset=iso-8859-1"] {
             self.format = link
        }
            
        else
         {
            self.format = "NA"
        }
    
            
        
    }
}




