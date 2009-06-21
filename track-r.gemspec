# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name                      = "track-r"
  s.version                   = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors                   = [ "Jose Felix Gomez" ]
  s.date                      = %q{2009-06-21}
  s.description               = "track-r is a library that provides wrapper classes and methods for accessing PivotalTracker's public API."
  s.email                     = "moc.liamg@68zemogfj".reverse
  s.files                     = Dir.glob('{config,lib}/**/*.{rb,yml}')
  s.has_rdoc                  = false
  s.homepage                  = "http://github.com/jfgomez86/Track-R"
  s.require_paths             = ["lib"]
  s.rubygems_version          = %q{1.3.0}
  s.summary                   = "A wrapper library for pivotal tracker's API"

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hpricot>, [">= 0"])
    else
      s.add_dependency(%q<hpricot>, [">= 0"])
    end
  else
    s.add_dependency(%q<hpricot>, [">= 0"])
  end
end

