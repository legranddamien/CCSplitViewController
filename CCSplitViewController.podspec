Pod::Spec.new do |s|
  s.name         = "CCSplitViewController"
  s.version      = "1.0"
  s.summary      = "Simple container for viewController."
  s.homepage     = "https://github.com/Fourni-j/CCSplitViewController"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Charles-Adrien Fournier" => "charladfr@me.com" }
  s.source       = { 
  :git => "https://github.com/Fourni-j/CCSplitViewController.git",
  }

  s.platform     = :ios, '7.0'
  s.source_files = 'Classes/**/*.{h,m}'
  s.requires_arc = true

  s.dependency "Masonry"
end
