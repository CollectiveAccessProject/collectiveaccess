# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: collectiveaccess 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "collectiveaccess"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["CollectiveAccess", "Stefan"]
  s.date = "2015-08-14"
  s.description = "This gem is a simple plain Ruby wrapper for the CollectiveAccess Web Service API. For more info see https://github.com/CollectiveAccessProject/collectiveaccess"
  s.email = "info@collectiveaccess.org"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "collectiveaccess.gemspec",
    "lib/collectiveaccess.rb",
    "test/helper.rb",
    "test/test_collectiveaccess.rb"
  ]
  s.homepage = "http://github.com/CollectiveAccessProject/collectiveaccess"
  s.licenses = ["GPL3"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubygems_version = "2.4.6"
  s.summary = "Ruby wrapper for CollectiveAccess Web Service API"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, ["~> 0.13"])
      s.add_development_dependency(%q<shoulda>, ["~> 3.5"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.10"])
    else
      s.add_dependency(%q<httparty>, ["~> 0.13"])
      s.add_dependency(%q<shoulda>, ["~> 3.5"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_dependency(%q<simplecov>, ["~> 0.10"])
    end
  else
    s.add_dependency(%q<httparty>, ["~> 0.13"])
    s.add_dependency(%q<shoulda>, ["~> 3.5"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 2.0"])
    s.add_dependency(%q<simplecov>, ["~> 0.10"])
  end
end

