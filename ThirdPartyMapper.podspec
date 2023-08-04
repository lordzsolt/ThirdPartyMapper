Pod::Spec.new do |spec|
  spec.name = "ThirdPartyMapper"
  spec.version = "0.9.0"
  spec.summary = "Interact with third-party iOS map clients, using custom URL schemes."
  spec.homepage = "https://www.iosmith.com"
  spec.license = { 
    type: 'MIT',
    file: 'LICENSE'
  }
  spec.authors = { 
    "Zsolt Kovacs" => 'zsolt@iosmith.com'
  }
  spec.social_media_url = "https://www.linkedin.com/in/zs-kovacs/"

  spec.platform = :ios, "11.0"
  spec.requires_arc = true

  spec.source = { 
    :git => 'https://github.com/lordzsolt/ThirdPartyMapper.git',
    :tag => spec.version 
  }
  spec.source_files = 'Sources/*.swift'
  spec.swift_version = "5.0"
end
