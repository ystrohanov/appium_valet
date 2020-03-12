Gem::Specification.new do |s|
    s.name        = %q{appium_valet}
    s.version     = "0.1.2.2"
    s.licenses    = ['MIT']
    s.date        = %q{2019-07-30}
    s.authors     = ["Yevhen Strohanov"]
    s.homepage    = 'https://cardservices-git-dev.onefiserv.net/ystrohanov/appium_valet'
    s.summary     = %q{appium_valet makes using Appium easier}
    s.files       = [
      'lib/appium_valet.rb',
      'lib/check_valet.rb',
      'lib/control_valet.rb',
      'lib/driver_extension.rb',
      'lib/input_valet.rb',
      'lib/ui_valet.rb',
    ]
    s.add_dependency('appium_lib', '~> 9.17.0')
  end
