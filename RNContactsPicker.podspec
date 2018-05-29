require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "RNContactsPicker"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  RNContactsPicker
                   DESC
  s.homepage     = "https://github.com/bluebamboostudios/react-native-contacts-picker"
  s.license      = "MIT"
  # s.license    = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "author" => "hello@bluebamboostudios.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/bluebamboostudios/react-native-contacts-picker.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m}"
  s.requires_arc = true

  s.dependency "React"
  #s.dependency "others"
end

  