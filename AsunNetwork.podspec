
Pod::Spec.new do |s|


  s.name         = "AsunNetwork"
  s.version      = "1.0.1"
  s.summary       = "Moya+HandyJSON Request"


 s.description   = <<-DESC
    Moya+HandyJSON 封装的网络请求 支持自动模型
                     DESC

  s.homepage  = 'https://github.com/BecomerichAsun/AsunNetwork'

  s.license   = { :type => 'MIT', :file => 'LICENSE' }

  s.author    = { 'Asun' => 'becomerichios@163.com' }

  s.ios.deployment_target = '8.0'

  s.swift_version = '5.0'

  s.source       = { :git => "https://github.com/BecomerichAsun/AsunNetwork.git", :tag => s.version  }

  s.source_files = 'NetWork/**/*'

  s.dependency 'HandyJSON', '~> 5.0.0-beta.1'
  s.dependency 'Moya'

end