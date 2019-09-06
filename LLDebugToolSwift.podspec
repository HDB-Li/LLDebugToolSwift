Pod::Spec.new do |s|
  s.name                = "LLDebugToolSwift"
  s.version             = "1.3.1"
  s.summary             = "LLDebugTool is a debugging tool for developers and testers that can help you analyze and manipulate data in non-xcode situations."
  s.homepage            = "https://github.com/HDB-Li/LLDebugToolSwift"
  s.license             = "MIT"
  s.author              = { "HDB-Li" => "llworkinggroup1992@gmail.com" }
  s.social_media_url    = "https://github.com/HDB-Li"
  s.platform            = :ios, "8.0"
  s.source              = { :git => "https://github.com/HDB-Li/LLDebugToolSwift.git", :tag => s.version }
  s.requires_arc        = true
  s.source_files	    = "LLDebugToolSwift/**/*.{h,m,swift}"
#  s.resources		    = "LLDebugToolSwift/**/*.{xib,storyboard,bundle}"
  s.dependency            "LLDebugTool" , '1.3.1'
  s.swift_version	    = "4.0"

end
