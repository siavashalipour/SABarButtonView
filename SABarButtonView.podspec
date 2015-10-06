Pod::Spec.new do |s|
  s.name             = "SABarButtonView"
  s.version          = "0.1.2"
  s.summary          = "A subclass of UIView which helps you to create toggle able views easily."
  s.description      = <<-DESC
                    SABarButtonView easily lets you design and create your TabBar in Interface builder using IBDesignables. Configure your tabButtons and attached the toggle able views and thats all.
                       DESC

  s.homepage         = "https://github.com/siavashalipour/SABarButtonView"
  s.license          = 'MIT'
  s.author           = { "Siavash" => "siavash.apps@yahoo.coom" }
  s.source           = { :git => "https://github.com/siavashalipour/SABarButtonView.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'SABarButtonView' => ['Pod/Assets/*.png']
  }

  s.frameworks = 'UIKit'
end