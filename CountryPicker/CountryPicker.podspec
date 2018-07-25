Pod::Spec.new do |s|
  s.name         = "CountryPicker"
  s.version      = "1.0"
  s.summary      = "Swift iOS library for CountryPicker and Countries List with images!"
  s.description  = <<-DESC
                  Swift iOS library for CountryPicker and Countries List with flag images for around 226 countries!
                   DESC
  s.homepage     = "https://goo.gl/RYckY1"
  s.screenshots  = "https://imgur.com/NMyjx5w.png", "https://imgur.com/3NZT92A.png", "https://imgur.com/au3ksmn.png"
  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Randika Chandrapala" => "randikachan@gmail.com" }
  s.social_media_url   = "https://twitter.com/randikachan"
  s.platform     = :ios, "11.2"
  s.source       = { :git => "https://github.com/randikachan/countrypicker-ios-swift.git", :tag => "#{s.version}" }
  s.source_files = "CountryPicker/CountryPicker/Classes/*.swift"
  s.resources = "CountryPicker/CountryPicker/Resources/*.{png,json}"

  # s.swift_version = "4.2" 
  `echo "4.2" > .swift-version` # ---> delete this and run the lint it will be given an error!

end
