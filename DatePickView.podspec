

Pod::Spec.new do |s|


  s.name         = "DatePickView"
  s.version      = "1.0"
  s.summary      = "A short description of DatePickView."

  s.description  = <<-DESC
                    this is XZPickView
                   DESC

  s.homepage     = "https://github.com/lyingjie/DatePickView"

  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author       = "liyingjie"

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/lyingjie/DatePickView.git", :tag => s.version.to_s }

  s.source_files  = "DatePickView/Classes/*.{h,m}"

  s.requires_arc = true

  s.dependency "Masonry"


end
