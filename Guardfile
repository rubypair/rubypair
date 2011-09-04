# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'minitest' do
  #with Minitest::Spec
  watch(%r|^test/(.*)_test\.rb|)
  watch(%r|^lib/(.*)\.rb|)            { |m| "test/#{m[1]}_test.rb" }
  watch(%r|^test/test_helper\.rb|)    { "spec" }
  watch(%r|^app/models/(.*).rb|)      { |m| "test/unit/#{m[1]}_test.rb" }
  watch(%r|^app/controllers/(.*).rb|) { |m| "test/functional/#{m[1]}_test.rb" }
end
