Pod::Spec.new do |s|
  s.name = "SwiftDP"
  s.version = "0.0.1"
  s.summary = "SwiftDP"

  s.description = <<-DESC
    Swift wrapper for Google's Differential Privacy Project via an Objective-C++ bridge.
                         DESC

  s.homepage = "https://www.openmined.org/"
  s.license = { :type => "Apache 2.0", :file => "LICENSE" }
  s.authors = { "OpenMined" => "@openminedorg",
                "Madhava Jay" => "@madhavajay",
                "Madalin Mamuleanu" => "@mmamuleanu" }

  s.social_media_url = "https://twitter.com/openminedorg"

  s.source = {
    :git => "https://github.com/OpenMined/SwiftDP.git",
    :branch => "dev",
  }

  s.cocoapods_version = ">= 1.4.0"
  s.module_name = "SwiftDP"

  s.script_phase = { :name => "Hello World", :script => "echo ocdp `pwd`", :execution_position => :before_compile }

  s.preserve_paths = "**/*.*"
  s.source_files = "src/fake.swift"

  s.ios.deployment_target = "13.0"
  s.platforms = { ios: "13.0" }
end
