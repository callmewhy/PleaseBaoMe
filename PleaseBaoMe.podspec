Pod::Spec.new do |s|
  s.name         = "PleaseBaoMe"
  s.version      = "0.1"
  s.summary      = "A useful tool to view SQLite file in Web browser during app running￼procedure."
  s.description  = <<-DESC
                    You can input your SQL query in the URI. And you can set TableName、 LIMIT、 OFFSET in navigation bar easily, too.
                    DESC
  s.homepage     = "https://github.com/callmewhy/PleaseBaoMe"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license = { :type => "MIT", :file => "LICENSE" }
  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.author = { "callmewhy" => "https://github.com/callmewhy" }
  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.platform = :ios, "7.0"
  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source = { :git => "https://github.com/callmewhy/PleaseBaoMe.git", :tag => "0.1" }
  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source_files  = "Classes/*.{h,m}"
  # ――― Dependency ―――――――――――――――――――――――――――-――――――――――――――――――――――――――――――――――― #
  s.dependencies = {
    'CocoaHTTPServer' => '~> 2', 
    'FMDB' => '~> 2'
  }
  # ――― Dependency ―――――――――――――――――――――――――――-――――――――――――――――――――――――――――――――――― #
  s.resource = "Classes/Web.bundle"
  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.requires_arc = true
end