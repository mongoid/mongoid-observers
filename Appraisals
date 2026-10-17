{
  4 => '4.2',
  5 => '4.2',
  6 => '5.2',
  7 => '6.1',
  8 => '7.2',
  9 => '8.1'
}.each do |mongoid, rails|
  appraise "mongoid_#{mongoid}" do
    gem 'mongoid', "~> #{mongoid}.0"
    gem 'railties', "~> #{rails}.0"
    gem 'bigdecimal', mongoid < 6 ? '< 2' : '>= 0'
  end
end
