# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :therapeutic_function do |f|
  f.sequence(:name) {|n| "Release exterior #{n}"}
end