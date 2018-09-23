Pod::Spec.new do |s|
  s.name                = "LLDebugToolSwift"
  s.version             = "1.2.0"
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
  s.dependency            "LLDebugTool" , '1.2.0'
  s.swift_version	= "4.0"

  s.subspec 'Network' do |ss|
    ss.dependency                 "LLDebugTool/Network" , '1.2.0'
  end

  s.subspec 'Log' do |ss|
    ss.source_files             = "LLDebugToolSwift/**/*.{h,m,swift}"
    ss.dependency                 "LLDebugTool/Log" , '1.2.0'
  end

  s.subspec 'Crash' do |ss|
    ss.dependency                 "LLDebugTool/Crash" , '1.2.0'
  end

  s.subspec 'AppInfo' do |ss|
    ss.dependency                 "LLDebugTool/AppInfo" , '1.2.0'
  end

  s.subspec 'Sandbox' do |ss|
    ss.dependency                 "LLDebugTool/Sandbox" , '1.2.0'
  end

  s.subspec 'Screenshot' do |ss|
    ss.dependency                 "LLDebugTool/Screenshot" , '1.2.0'
  end

  s.subspec 'StorageManager' do |ss|
    ss.dependency                 "LLDebugTool/StorageManager" , '1.2.0'
  end

  s.subspec 'General' do |ss|
    ss.dependency                 "LLDebugTool/General" , '1.2.0'
  end

end
