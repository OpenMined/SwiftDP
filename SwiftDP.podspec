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

  s.prepare_command = <<-CMD
    echo "here `pwd`"
    mkdir SwiftDP.framework
    mkdir OCDP.framework
  CMD

  s.script_phases = [
    { :name => "Bazel Build Frameworks", :script => "echo 'Building SwiftDP in `pwd`' && cd SwiftDP && source build_frameworks.sh", :execution_position => :before_compile },
    { :name => "Copying Frameworks", :script => "cd SwiftDP && rm -rf SwiftDP.framework || true && rm -rf OCDP.framework || true && cp -R bazel-bin/src/SwiftDP/SwiftDP_archive-root/SwiftDP.framework ./SwiftDP.framework && cp -R bazel-bin/src/OCDP/OCDP_archive-root/OCDP.framework ./OCDP.framework", :execution_position => :before_compile },
  ]

  s.ios.vendored_frameworks = "SwiftDP.framework", "OCDP.framework"

  s.preserve_paths = "**/*"
  s.source_files = "src/fake.swift"

  s.ios.deployment_target = "13.0"
  s.platforms = { ios: "13.0" }
end
