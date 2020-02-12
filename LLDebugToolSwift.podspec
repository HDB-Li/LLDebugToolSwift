Pod::Spec.new do |s|
  s.name                = "LLDebugToolSwift"
  s.version             = "1.3.8"
  s.summary             = "LLDebugTool is a debugging tool for developers and testers that can help you analyze and manipulate data in non-xcode situations."
  s.homepage            = "https://github.com/HDB-Li/LLDebugToolSwift"
  s.license             = "MIT"
  s.author              = { "HDB-Li" => "llworkinggroup1992@gmail.com" }
  s.social_media_url    = "https://github.com/HDB-Li"
  s.platform            = :ios, "8.0"
  s.source              = { :git => "https://github.com/HDB-Li/LLDebugToolSwift.git", :tag => s.version }
  s.requires_arc        = true
  s.source_files	    = "LLDebugToolSwift/**/*.{h,m,swift}"
  s.swift_version	    = "4.0"

  s.subspec 'Network' do |ss|
     ss.dependency                 "LLDebugTool/Network", "1.3.8"
  end

   s.subspec 'Log' do |ss|
     ss.dependency                 "LLDebugTool/Log", "1.3.8"
   end
   
   s.subspec 'Crash' do |ss|
     ss.dependency                 "LLDebugTool/Crash", "1.3.8"
   end

   s.subspec 'AppInfo' do |ss|
     ss.dependency                 "LLDebugTool/AppInfo", "1.3.8"
   end
   
   s.subspec 'Sandbox' do |ss|
     ss.dependency                 "LLDebugTool/Sandbox", "1.3.8"
   end
   
   s.subspec 'Screenshot' do |ss|
     ss.dependency                 "LLDebugTool/Screenshot", "1.3.8"
   end
   
   s.subspec 'Hierarchy' do |ss|
     ss.dependency                 "LLDebugTool/Hierarchy", "1.3.8"
   end
   
   s.subspec 'Magnifier' do |ss|
     ss.dependency                 "LLDebugTool/Magnifier", "1.3.8"
   end
   
   s.subspec 'Ruler' do |ss|
     ss.dependency                 "LLDebugTool/Ruler", "1.3.8"
   end
   
   s.subspec 'WidgetBorder' do |ss|
     ss.dependency                 "LLDebugTool/WidgetBorder", "1.3.8"
   end
   
   s.subspec 'Html' do |ss|
     ss.dependency                 "LLDebugTool/Html", "1.3.8"
   end
   
   s.subspec 'Location' do |ss|
     ss.dependency                 "LLDebugTool/Location", "1.3.8"
   end
   
   s.subspec 'ShortCut' do |ss|
     ss.dependency                 "LLDebugTool/ShortCut", "1.3.8"
   end

end
